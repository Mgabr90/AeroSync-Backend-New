<?php

namespace App\Infrastructure\DocumentParsing\Persistence;

use App\Domain\DocumentParsing\Entities\RegulatoryDocument;
use App\Domain\DocumentParsing\Entities\DocumentSection;
use App\Domain\DocumentParsing\ValueObjects\DocumentType;
use App\Domain\DocumentParsing\ValueObjects\ProcessingStatus;
use App\Domain\DocumentParsing\ValueObjects\SectionNumber;
use App\Domain\DocumentParsing\ValueObjects\Content;
use App\Domain\DocumentParsing\ValueObjects\QualityScore;
use App\Domain\DocumentParsing\Repositories\DocumentRepository;
use App\Infrastructure\DocumentParsing\Persistence\Models\Document;
use App\Infrastructure\DocumentParsing\Persistence\Models\DocumentSectionModel;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

/**
 * Eloquent Document Repository
 * Implementation of DocumentRepository using Eloquent ORM and existing Supabase schema
 */
class EloquentDocumentRepository implements DocumentRepository
{
    public function save(RegulatoryDocument $document): void
    {
        DB::transaction(function () use ($document) {
            // Save or update the main document
            $documentModel = Document::findOrNew($document->getId());
            
            $documentModel->fill([
                'id' => $document->getId(),
                'title' => $document->getFileName(),
                'filename' => $document->getFileName(),
                'document_type' => $document->getType()->getValue(),
                'status' => $this->mapProcessingStatusToDbStatus($document->getStatus()),
                'file_url' => $document->getFilePath(),
                'metadata' => [
                    'processing_metadata' => $document->getProcessingMetadata(),
                    'overall_quality_score' => $document->getOverallQualityScore()?->getValue(),
                    'uploaded_at' => $document->getUploadedAt()->format('c'),
                    'processed_at' => $document->getProcessedAt()?->format('c'),
                    'domain_events' => $document->getDomainEvents()->count(),
                ],
                'parsed_content' => $this->serializeSectionsForStorage($document->getSections()),
                'created_at' => $document->getUploadedAt(),
                'updated_at' => $document->getProcessedAt() ?? $document->getUploadedAt(),
            ]);
            
            $documentModel->save();
            
            // Save sections
            $this->saveSections($document);
            
            Log::info('Document saved successfully', [
                'document_id' => $document->getId(),
                'type' => $document->getType()->getValue(),
                'sections_count' => $document->getSections()->count(),
            ]);
        });
    }

    public function findById(string $id): ?RegulatoryDocument
    {
        $documentModel = Document::with(['sections'])->find($id);
        
        if (!$documentModel) {
            return null;
        }
        
        return $this->mapToEntity($documentModel);
    }

    public function findByType(DocumentType $type, int $limit = 20, int $offset = 0): Collection
    {
        $documents = Document::where('document_type', $type->getValue())
            ->orderBy('created_at', 'desc')
            ->limit($limit)
            ->offset($offset)
            ->get();
        
        return $documents->map(fn($doc) => $this->mapToEntity($doc));
    }

    public function findByStatus(ProcessingStatus $status, int $limit = 20, int $offset = 0): Collection
    {
        $dbStatus = $this->mapProcessingStatusToDbStatus($status);
        
        $documents = Document::where('status', $dbStatus)
            ->orderBy('created_at', 'desc')
            ->limit($limit)
            ->offset($offset)
            ->get();
        
        return $documents->map(fn($doc) => $this->mapToEntity($doc));
    }

    public function findByOrganization(string $organizationId, int $limit = 20, int $offset = 0): Collection
    {
        $documents = Document::where('organization_id', $organizationId)
            ->orderBy('created_at', 'desc')
            ->limit($limit)
            ->offset($offset)
            ->get();
        
        return $documents->map(fn($doc) => $this->mapToEntity($doc));
    }

    public function findByDateRange(
        \DateTimeInterface $startDate,
        \DateTimeInterface $endDate,
        int $limit = 20,
        int $offset = 0
    ): Collection {
        $documents = Document::whereBetween('created_at', [$startDate, $endDate])
            ->orderBy('created_at', 'desc')
            ->limit($limit)
            ->offset($offset)
            ->get();
        
        return $documents->map(fn($doc) => $this->mapToEntity($doc));
    }

    public function search(string $query, int $limit = 20, int $offset = 0): Collection
    {
        $documents = Document::where(function ($q) use ($query) {
            $q->where('title', 'ILIKE', "%{$query}%")
              ->orWhere('filename', 'ILIKE', "%{$query}%")
              ->orWhere('parsed_content', 'ILIKE', "%{$query}%");
        })
        ->orderBy('created_at', 'desc')
        ->limit($limit)
        ->offset($offset)
        ->get();
        
        return $documents->map(fn($doc) => $this->mapToEntity($doc));
    }

    public function deleteById(string $id): bool
    {
        return DB::transaction(function () use ($id) {
            // Soft delete sections
            DocumentSectionModel::where('document_id', $id)->delete();
            
            // Soft delete document
            $document = Document::find($id);
            if ($document) {
                $document->update([
                    'is_deleted' => true,
                    'deleted_at' => now(),
                ]);
                return true;
            }
            
            return false;
        });
    }

    public function getStatistics(?string $organizationId = null): array
    {
        $query = Document::where('is_deleted', false);
        
        if ($organizationId) {
            $query->where('organization_id', $organizationId);
        }
        
        $total = $query->count();
        $byType = $query->groupBy('document_type')
            ->selectRaw('document_type, count(*) as count')
            ->pluck('count', 'document_type');
        
        $byStatus = $query->groupBy('status')
            ->selectRaw('status, count(*) as count')
            ->pluck('count', 'status');
        
        return [
            'total_documents' => $total,
            'by_type' => $byType->toArray(),
            'by_status' => $byStatus->toArray(),
            'organization_id' => $organizationId,
        ];
    }

    public function findPendingReprocessing(int $limit = 10): Collection
    {
        // Find documents that failed processing or need reprocessing
        $documents = Document::where('status', 'failed')
            ->orWhere('status', 'pending')
            ->orderBy('updated_at', 'asc')
            ->limit($limit)
            ->get();
        
        return $documents->map(fn($doc) => $this->mapToEntity($doc));
    }

    public function updateStatus(string $id, ProcessingStatus $status): bool
    {
        $dbStatus = $this->mapProcessingStatusToDbStatus($status);
        
        return Document::where('id', $id)
            ->update([
                'status' => $dbStatus,
                'updated_at' => now(),
            ]) > 0;
    }

    public function bulkDelete(array $ids): int
    {
        return DB::transaction(function () use ($ids) {
            // Soft delete sections
            DocumentSectionModel::whereIn('document_id', $ids)->delete();
            
            // Soft delete documents
            return Document::whereIn('id', $ids)
                ->update([
                    'is_deleted' => true,
                    'deleted_at' => now(),
                ]);
        });
    }

    public function exists(string $id): bool
    {
        return Document::where('id', $id)
            ->where('is_deleted', false)
            ->exists();
    }

    public function count(array $filters = []): int
    {
        $query = Document::where('is_deleted', false);
        
        foreach ($filters as $field => $value) {
            $query->where($field, $value);
        }
        
        return $query->count();
    }

    private function saveSections(RegulatoryDocument $document): void
    {
        // Delete existing sections for this document
        DocumentSectionModel::where('document_id', $document->getId())->delete();
        
        // Save new sections
        foreach ($document->getSections() as $section) {
            $sectionModel = new DocumentSectionModel([
                'id' => $section->getId(),
                'document_id' => $document->getId(),
                'section_number' => $section->getSectionNumber()->getValue(),
                'section_name' => $section->getTitle(),
                'full_text' => $section->getContent()->getCleanedContent(),
                'page_number' => $section->getPageNumber(),
                'parent_section_id' => $section->getParentSectionId(),
                'level' => $section->getSectionNumber()->getDepth(),
                'hierarchy_level' => $section->getSectionNumber()->getDepth(),
                'quality_score' => $section->getQualityScore()?->getValue(),
                'extraction_method' => 'hybrid_extractor',
                'confidence' => $section->getQualityScore()?->getValue(),
                'extraction_confidence' => $section->getQualityScore()?->getValue(),
                'created_at' => $section->getExtractedAt(),
                'updated_at' => $section->getExtractedAt(),
            ]);
            
            $sectionModel->save();
        }
    }

    private function mapToEntity(Document $documentModel): RegulatoryDocument
    {
        $documentType = DocumentType::fromString($documentModel->document_type);
        $status = $this->mapDbStatusToProcessingStatus($documentModel->status);
        
        $document = new RegulatoryDocument(
            id: $documentModel->id,
            fileName: $documentModel->filename ?? $documentModel->title,
            filePath: $documentModel->file_url ?? '',
            type: $documentType,
            status: $status,
            uploadedAt: $documentModel->created_at,
            processedAt: $documentModel->updated_at !== $documentModel->created_at 
                ? $documentModel->updated_at 
                : null
        );
        
        // Add metadata
        if ($documentModel->metadata && is_array($documentModel->metadata)) {
            $metadata = $documentModel->metadata['processing_metadata'] ?? [];
            foreach ($metadata as $key => $value) {
                $document->addProcessingMetadata($key, $value);
            }
        }
        
        // Add sections
        if ($documentModel->relationLoaded('sections')) {
            foreach ($documentModel->sections as $sectionModel) {
                $section = $this->mapSectionToEntity($sectionModel);
                $document->addSection($section);
            }
        }
        
        return $document;
    }

    private function mapSectionToEntity(DocumentSectionModel $sectionModel): DocumentSection
    {
        $sectionNumber = SectionNumber::fromString($sectionModel->section_number ?? '1');
        $content = Content::fromCleaned($sectionModel->full_text ?? '');
        
        $section = DocumentSection::create(
            id: $sectionModel->id,
            documentId: $sectionModel->document_id,
            sectionNumber: $sectionNumber,
            title: $sectionModel->section_name ?? 'Untitled Section',
            content: $content,
            pageNumber: $sectionModel->page_number ?? 0,
            parentSectionId: $sectionModel->parent_section_id
        );
        
        // Set quality score if available
        if ($sectionModel->quality_score !== null) {
            $qualityScore = new QualityScore($sectionModel->quality_score);
            $section->addExtractionMetadata('quality_score_value', $qualityScore->getValue());
        }
        
        return $section;
    }

    private function mapProcessingStatusToDbStatus(ProcessingStatus $status): string
    {
        return match ($status->getValue()) {
            ProcessingStatus::PENDING => 'pending',
            ProcessingStatus::PROCESSING => 'processing',
            ProcessingStatus::COMPLETED => 'published', // Map completed to published
            ProcessingStatus::FAILED => 'failed',
            ProcessingStatus::CANCELLED => 'draft',
            default => 'draft'
        };
    }

    private function mapDbStatusToProcessingStatus(string $dbStatus): ProcessingStatus
    {
        return match ($dbStatus) {
            'pending' => ProcessingStatus::pending(),
            'processing' => ProcessingStatus::processing(),
            'published' => ProcessingStatus::completed(),
            'failed' => ProcessingStatus::failed(),
            'draft' => ProcessingStatus::pending(),
            default => ProcessingStatus::pending()
        };
    }

    private function serializeSectionsForStorage(Collection $sections): string
    {
        return $sections->map(function ($section) {
            return [
                'id' => $section->getId(),
                'section_number' => $section->getSectionNumber()->getValue(),
                'title' => $section->getTitle(),
                'content_preview' => $section->getContent()->getPreview(500),
                'word_count' => $section->getContent()->getWordCount(),
                'quality_score' => $section->getQualityScore()?->getValue(),
            ];
        })->toJson();
    }
}