<?php

namespace App\Domain\DocumentParsing\Repositories;

use App\Domain\DocumentParsing\Entities\RegulatoryDocument;
use App\Domain\DocumentParsing\ValueObjects\DocumentType;
use App\Domain\DocumentParsing\ValueObjects\ProcessingStatus;
use Illuminate\Support\Collection;

/**
 * Document Repository Interface
 * Contract for regulatory document persistence operations
 */
interface DocumentRepository
{
    /**
     * Save a regulatory document
     *
     * @param RegulatoryDocument $document
     * @return void
     */
    public function save(RegulatoryDocument $document): void;

    /**
     * Find a document by its ID
     *
     * @param string $id
     * @return RegulatoryDocument|null
     */
    public function findById(string $id): ?RegulatoryDocument;

    /**
     * Find documents by type
     *
     * @param DocumentType $type
     * @param int $limit
     * @param int $offset
     * @return Collection<RegulatoryDocument>
     */
    public function findByType(DocumentType $type, int $limit = 20, int $offset = 0): Collection;

    /**
     * Find documents by status
     *
     * @param ProcessingStatus $status
     * @param int $limit
     * @param int $offset
     * @return Collection<RegulatoryDocument>
     */
    public function findByStatus(ProcessingStatus $status, int $limit = 20, int $offset = 0): Collection;

    /**
     * Find documents by organization
     *
     * @param string $organizationId
     * @param int $limit
     * @param int $offset
     * @return Collection<RegulatoryDocument>
     */
    public function findByOrganization(string $organizationId, int $limit = 20, int $offset = 0): Collection;

    /**
     * Find documents uploaded within date range
     *
     * @param \DateTimeInterface $startDate
     * @param \DateTimeInterface $endDate
     * @param int $limit
     * @param int $offset
     * @return Collection<RegulatoryDocument>
     */
    public function findByDateRange(
        \DateTimeInterface $startDate,
        \DateTimeInterface $endDate,
        int $limit = 20,
        int $offset = 0
    ): Collection;

    /**
     * Search documents by filename or content
     *
     * @param string $query
     * @param int $limit
     * @param int $offset
     * @return Collection<RegulatoryDocument>
     */
    public function search(string $query, int $limit = 20, int $offset = 0): Collection;

    /**
     * Delete a document by ID
     *
     * @param string $id
     * @return bool
     */
    public function deleteById(string $id): bool;

    /**
     * Get document statistics
     *
     * @param string|null $organizationId
     * @return array
     */
    public function getStatistics(?string $organizationId = null): array;

    /**
     * Find documents requiring reprocessing
     *
     * @param int $limit
     * @return Collection<RegulatoryDocument>
     */
    public function findPendingReprocessing(int $limit = 10): Collection;

    /**
     * Update document status
     *
     * @param string $id
     * @param ProcessingStatus $status
     * @return bool
     */
    public function updateStatus(string $id, ProcessingStatus $status): bool;

    /**
     * Bulk delete documents
     *
     * @param array $ids
     * @return int Number of deleted documents
     */
    public function bulkDelete(array $ids): int;

    /**
     * Check if document exists
     *
     * @param string $id
     * @return bool
     */
    public function exists(string $id): bool;

    /**
     * Get total count of documents
     *
     * @param array $filters
     * @return int
     */
    public function count(array $filters = []): int;
}