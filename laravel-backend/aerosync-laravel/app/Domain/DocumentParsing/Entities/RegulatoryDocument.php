<?php

namespace App\Domain\DocumentParsing\Entities;

use App\Domain\DocumentParsing\ValueObjects\DocumentType;
use App\Domain\DocumentParsing\ValueObjects\QualityScore;
use App\Domain\DocumentParsing\Events\DocumentProcessingStarted;
use App\Domain\DocumentParsing\Events\DocumentProcessingCompleted;
use App\Domain\DocumentParsing\Events\QualityThresholdFailed;
use Illuminate\Support\Collection;
use InvalidArgumentException;

/**
 * Regulatory Document Entity
 * Core aggregate root for aviation regulatory documents
 */
class RegulatoryDocument
{
    private Collection $sections;
    private Collection $events;
    private ?DocumentHierarchy $hierarchy = null;
    private ?QualityScore $overallQualityScore = null;
    private array $processingMetadata = [];

    public function __construct(
        private string $id,
        private string $fileName,
        private string $filePath,
        private DocumentType $type,
        private ProcessingStatus $status = ProcessingStatus::PENDING,
        private ?\DateTimeImmutable $uploadedAt = null,
        private ?\DateTimeImmutable $processedAt = null
    ) {
        if (empty(trim($id))) {
            throw new InvalidArgumentException('Document ID cannot be empty');
        }

        if (empty(trim($fileName))) {
            throw new InvalidArgumentException('File name cannot be empty');
        }

        if (empty(trim($filePath))) {
            throw new InvalidArgumentException('File path cannot be empty');
        }

        $this->sections = new Collection();
        $this->events = new Collection();
        $this->uploadedAt = $uploadedAt ?? new \DateTimeImmutable();
    }

    public static function create(
        string $id,
        string $fileName,
        string $filePath,
        DocumentType $type
    ): self {
        $document = new self($id, $fileName, $filePath, $type);
        
        $document->recordEvent(new DocumentProcessingStarted(
            $id,
            $type,
            $fileName,
            new \DateTimeImmutable()
        ));

        return $document;
    }

    public function getId(): string
    {
        return $this->id;
    }

    public function getFileName(): string
    {
        return $this->fileName;
    }

    public function getFilePath(): string
    {
        return $this->filePath;
    }

    public function getType(): DocumentType
    {
        return $this->type;
    }

    public function getStatus(): ProcessingStatus
    {
        return $this->status;
    }

    public function getUploadedAt(): \DateTimeImmutable
    {
        return $this->uploadedAt;
    }

    public function getProcessedAt(): ?\DateTimeImmutable
    {
        return $this->processedAt;
    }

    public function getSections(): Collection
    {
        return $this->sections;
    }

    public function getHierarchy(): ?DocumentHierarchy
    {
        return $this->hierarchy;
    }

    public function getOverallQualityScore(): ?QualityScore
    {
        return $this->overallQualityScore;
    }

    public function getProcessingMetadata(): array
    {
        return $this->processingMetadata;
    }

    public function getDomainEvents(): Collection
    {
        return $this->events;
    }

    public function startProcessing(): void
    {
        if (!$this->status->canTransitionTo(ProcessingStatus::PROCESSING)) {
            throw new InvalidArgumentException(
                "Cannot start processing document in {$this->status->getValue()} status"
            );
        }

        $this->status = ProcessingStatus::processing();
        $this->addProcessingMetadata('processing_started_at', new \DateTimeImmutable());
    }

    public function addSection(DocumentSection $section): void
    {
        if ($this->sections->contains('id', $section->getId())) {
            throw new InvalidArgumentException("Section with ID {$section->getId()} already exists");
        }

        $this->sections->push($section);
    }

    public function removeSection(string $sectionId): void
    {
        $this->sections = $this->sections->reject(fn($section) => $section->getId() === $sectionId);
    }

    public function getSectionById(string $sectionId): ?DocumentSection
    {
        return $this->sections->first(fn($section) => $section->getId() === $sectionId);
    }

    public function getSectionsByLevel(int $level): Collection
    {
        return $this->sections->filter(
            fn($section) => $section->getSectionNumber()->getDepth() === $level
        );
    }

    public function setHierarchy(DocumentHierarchy $hierarchy): void
    {
        $this->hierarchy = $hierarchy;
        $this->addProcessingMetadata('hierarchy_built_at', new \DateTimeImmutable());
    }

    public function calculateOverallQuality(): QualityScore
    {
        if ($this->sections->isEmpty()) {
            $this->overallQualityScore = QualityScore::zero();
            return $this->overallQualityScore;
        }

        $totalScore = 0.0;
        $sectionCount = 0;

        foreach ($this->sections as $section) {
            if ($section->getQualityScore() !== null) {
                $totalScore += $section->getQualityScore()->getValue();
                $sectionCount++;
            }
        }

        if ($sectionCount === 0) {
            $this->overallQualityScore = QualityScore::zero();
        } else {
            $averageScore = $totalScore / $sectionCount;
            $this->overallQualityScore = new QualityScore($averageScore);
        }

        return $this->overallQualityScore;
    }

    public function validateQuality(QualityScore $minimumThreshold): bool
    {
        $overallScore = $this->calculateOverallQuality();
        
        if (!$overallScore->passesThreshold($minimumThreshold)) {
            $this->recordEvent(new QualityThresholdFailed(
                $this->id,
                $overallScore,
                $minimumThreshold,
                new \DateTimeImmutable()
            ));
            
            return false;
        }

        return true;
    }

    public function completeProcessing(): void
    {
        if (!$this->status->canTransitionTo(ProcessingStatus::COMPLETED)) {
            throw new InvalidArgumentException(
                "Cannot complete processing for document in {$this->status->getValue()} status"
            );
        }

        $this->status = ProcessingStatus::completed();
        $this->processedAt = new \DateTimeImmutable();
        $this->calculateOverallQuality();
        
        $this->addProcessingMetadata('processing_completed_at', $this->processedAt);
        
        $this->recordEvent(new DocumentProcessingCompleted(
            $this->id,
            $this->type,
            $this->overallQualityScore ?? QualityScore::zero(),
            $this->sections->count(),
            $this->processedAt
        ));
    }

    public function failProcessing(string $reason): void
    {
        if (!$this->status->canTransitionTo(ProcessingStatus::FAILED)) {
            throw new InvalidArgumentException(
                "Cannot fail processing for document in {$this->status->getValue()} status"
            );
        }

        $this->status = ProcessingStatus::failed();
        $this->addProcessingMetadata('processing_failed_at', new \DateTimeImmutable());
        $this->addProcessingMetadata('failure_reason', $reason);
    }

    public function retryProcessing(): void
    {
        if (!$this->status->canTransitionTo(ProcessingStatus::PENDING)) {
            throw new InvalidArgumentException(
                "Cannot retry processing for document in {$this->status->getValue()} status"
            );
        }

        $this->status = ProcessingStatus::pending();
        $this->sections = new Collection();
        $this->hierarchy = null;
        $this->overallQualityScore = null;
        $this->processedAt = null;
        
        $retryCount = ($this->processingMetadata['retry_count'] ?? 0) + 1;
        $this->addProcessingMetadata('retry_count', $retryCount);
        $this->addProcessingMetadata('last_retry_at', new \DateTimeImmutable());
    }

    public function addProcessingMetadata(string $key, mixed $value): void
    {
        $this->processingMetadata[$key] = $value;
    }

    public function getProcessingDuration(): ?\DateInterval
    {
        if ($this->processedAt === null) {
            return null;
        }

        $startTime = $this->processingMetadata['processing_started_at'] ?? $this->uploadedAt;
        return $startTime->diff($this->processedAt);
    }

    public function isProcessed(): bool
    {
        return $this->status->isCompleted();
    }

    public function hasQualityIssues(): bool
    {
        return $this->overallQualityScore !== null && !$this->overallQualityScore->isGood();
    }

    private function recordEvent(object $event): void
    {
        $this->events->push($event);
    }

    public function clearEvents(): void
    {
        $this->events = new Collection();
    }

    public function toArray(): array
    {
        return [
            'id' => $this->id,
            'file_name' => $this->fileName,
            'type' => $this->type->toArray(),
            'status' => $this->status->getValue(),
            'uploaded_at' => $this->uploadedAt->format('c'),
            'processed_at' => $this->processedAt?->format('c'),
            'sections_count' => $this->sections->count(),
            'overall_quality_score' => $this->overallQualityScore?->toArray(),
            'processing_metadata' => $this->processingMetadata,
        ];
    }
}