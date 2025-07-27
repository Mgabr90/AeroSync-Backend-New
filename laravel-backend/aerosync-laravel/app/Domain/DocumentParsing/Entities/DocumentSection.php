<?php

namespace App\Domain\DocumentParsing\Entities;

use App\Domain\DocumentParsing\ValueObjects\SectionNumber;
use App\Domain\DocumentParsing\ValueObjects\Content;
use App\Domain\DocumentParsing\ValueObjects\QualityScore;
use InvalidArgumentException;

/**
 * Document Section Entity
 * Represents a single section within a regulatory document
 */
class DocumentSection
{
    private ?QualityScore $qualityScore = null;
    private array $extractionMetadata = [];

    public function __construct(
        private string $id,
        private string $documentId,
        private SectionNumber $sectionNumber,
        private string $title,
        private Content $content,
        private int $pageNumber = 0,
        private ?string $parentSectionId = null,
        private ?\DateTimeImmutable $extractedAt = null
    ) {
        if (empty(trim($id))) {
            throw new InvalidArgumentException('Section ID cannot be empty');
        }

        if (empty(trim($documentId))) {
            throw new InvalidArgumentException('Document ID cannot be empty');
        }

        if (empty(trim($title))) {
            throw new InvalidArgumentException('Section title cannot be empty');
        }

        $this->extractedAt = $extractedAt ?? new \DateTimeImmutable();
    }

    public static function create(
        string $id,
        string $documentId,
        SectionNumber $sectionNumber,
        string $title,
        Content $content,
        int $pageNumber = 0,
        ?string $parentSectionId = null
    ): self {
        return new self($id, $documentId, $sectionNumber, $title, $content, $pageNumber, $parentSectionId);
    }

    public function getId(): string
    {
        return $this->id;
    }

    public function getDocumentId(): string
    {
        return $this->documentId;
    }

    public function getSectionNumber(): SectionNumber
    {
        return $this->sectionNumber;
    }

    public function getTitle(): string
    {
        return $this->title;
    }

    public function getContent(): Content
    {
        return $this->content;
    }

    public function getPageNumber(): int
    {
        return $this->pageNumber;
    }

    public function getParentSectionId(): ?string
    {
        return $this->parentSectionId;
    }

    public function getExtractedAt(): \DateTimeImmutable
    {
        return $this->extractedAt;
    }

    public function getQualityScore(): ?QualityScore
    {
        return $this->qualityScore;
    }

    public function getExtractionMetadata(): array
    {
        return $this->extractionMetadata;
    }

    public function updateTitle(string $newTitle): void
    {
        if (empty(trim($newTitle))) {
            throw new InvalidArgumentException('Section title cannot be empty');
        }

        $this->title = trim($newTitle);
        $this->addExtractionMetadata('title_updated_at', new \DateTimeImmutable());
    }

    public function updateContent(Content $newContent): void
    {
        $this->content = $newContent;
        $this->addExtractionMetadata('content_updated_at', new \DateTimeImmutable());
        
        // Recalculate quality score if it was previously set
        if ($this->qualityScore !== null) {
            $this->calculateQualityScore();
        }
    }

    public function setParentSection(?string $parentSectionId): void
    {
        $this->parentSectionId = $parentSectionId;
    }

    public function calculateQualityScore(): QualityScore
    {
        $scores = [];
        
        // Content quality (40% weight)
        $contentScore = $this->assessContentQuality();
        $scores[] = ['score' => $contentScore, 'weight' => 0.4];
        
        // Title quality (20% weight)
        $titleScore = $this->assessTitleQuality();
        $scores[] = ['score' => $titleScore, 'weight' => 0.2];
        
        // Structure quality (25% weight)
        $structureScore = $this->assessStructureQuality();
        $scores[] = ['score' => $structureScore, 'weight' => 0.25];
        
        // Completeness (15% weight)
        $completenessScore = $this->assessCompleteness();
        $scores[] = ['score' => $completenessScore, 'weight' => 0.15];
        
        // Calculate weighted average
        $totalWeight = array_sum(array_column($scores, 'weight'));
        $weightedSum = array_sum(array_map(
            fn($item) => $item['score'] * $item['weight'],
            $scores
        ));
        
        $this->qualityScore = new QualityScore($weightedSum / $totalWeight);
        
        $this->addExtractionMetadata('quality_calculated_at', new \DateTimeImmutable());
        $this->addExtractionMetadata('quality_components', [
            'content' => $contentScore,
            'title' => $titleScore,
            'structure' => $structureScore,
            'completeness' => $completenessScore,
        ]);
        
        return $this->qualityScore;
    }

    private function assessContentQuality(): float
    {
        $content = $this->content->getCleanedContent();
        $score = 1.0;
        
        // Penalize very short content
        if ($this->content->getWordCount() < 5) {
            $score -= 0.4;
        } elseif ($this->content->getWordCount() < 15) {
            $score -= 0.2;
        }
        
        // Penalize if suspicious patterns were found
        if ($this->content->hasSuspiciousPatterns()) {
            $score -= 0.3;
        }
        
        // Penalize if significant cleaning was needed
        if ($this->content->hasSignificantCleaning()) {
            $score -= 0.1;
        }
        
        // Check for common extraction artifacts
        $artifacts = ['...', '###', '***', '???'];
        foreach ($artifacts as $artifact) {
            if (str_contains($content, $artifact)) {
                $score -= 0.1;
                break;
            }
        }
        
        return max(0.0, $score);
    }

    private function assessTitleQuality(): float
    {
        $title = trim($this->title);
        $score = 1.0;
        
        // Penalize very short or very long titles
        $titleLength = strlen($title);
        if ($titleLength < 3) {
            $score -= 0.5;
        } elseif ($titleLength > 200) {
            $score -= 0.3;
        }
        
        // Penalize titles with excessive whitespace or special characters
        if (preg_match('/\s{3,}/', $title) || preg_match('/[^\w\s\-\.\(\)]+/', $title)) {
            $score -= 0.2;
        }
        
        // Bonus for titles that match section number
        $sectionValue = $this->sectionNumber->getValue();
        if (str_contains(strtolower($title), strtolower($sectionValue))) {
            $score += 0.1;
        }
        
        return max(0.0, min(1.0, $score));
    }

    private function assessStructureQuality(): float
    {
        $score = 1.0;
        
        // Check if section number makes sense
        if ($this->sectionNumber->getDepth() > 6) {
            $score -= 0.2; // Very deep nesting might indicate parsing issues
        }
        
        // Check page number validity
        if ($this->pageNumber <= 0) {
            $score -= 0.1;
        }
        
        // Check parent-child relationship consistency
        if ($this->parentSectionId !== null) {
            // This would need access to other sections to validate properly
            // For now, just check if we have a parent ID for non-root sections
            if ($this->sectionNumber->getDepth() <= 1) {
                $score -= 0.1; // Root sections shouldn't have parents
            }
        } else {
            if ($this->sectionNumber->getDepth() > 1) {
                $score -= 0.1; // Non-root sections should have parents
            }
        }
        
        return max(0.0, $score);
    }

    private function assessCompleteness(): float
    {
        $score = 1.0;
        
        // Check if content seems complete (not truncated)
        $content = $this->content->getCleanedContent();
        $lastChar = substr($content, -1);
        
        if (!in_array($lastChar, ['.', '!', '?', ':', ';', ')'])) {
            $score -= 0.2; // Content might be truncated
        }
        
        // Check for minimum content requirements
        if ($this->content->getParagraphCount() === 0) {
            $score -= 0.3;
        }
        
        // Check if title seems complete
        if (!preg_match('/^[A-Z0-9]/', $this->title)) {
            $score -= 0.1; // Title should start with capital letter or number
        }
        
        return max(0.0, $score);
    }

    public function addExtractionMetadata(string $key, mixed $value): void
    {
        $this->extractionMetadata[$key] = $value;
    }

    public function isRootSection(): bool
    {
        return $this->parentSectionId === null && $this->sectionNumber->getDepth() === 1;
    }

    public function hasParent(): bool
    {
        return $this->parentSectionId !== null;
    }

    public function getDepth(): int
    {
        return $this->sectionNumber->getDepth();
    }

    public function isSubstantial(): bool
    {
        return $this->content->isSubstantial();
    }

    public function containsKeyword(string $keyword): bool
    {
        return $this->content->containsText($keyword) || 
               str_contains(strtolower($this->title), strtolower($keyword));
    }

    public function toArray(): array
    {
        return [
            'id' => $this->id,
            'document_id' => $this->documentId,
            'section_number' => $this->sectionNumber->toArray(),
            'title' => $this->title,
            'content' => $this->content->toArray(),
            'page_number' => $this->pageNumber,
            'parent_section_id' => $this->parentSectionId,
            'quality_score' => $this->qualityScore?->toArray(),
            'extracted_at' => $this->extractedAt->format('c'),
            'extraction_metadata' => $this->extractionMetadata,
        ];
    }
}