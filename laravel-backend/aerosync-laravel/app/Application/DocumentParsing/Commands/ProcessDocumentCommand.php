<?php

namespace App\Application\DocumentParsing\Commands;

use App\Domain\DocumentParsing\ValueObjects\DocumentType;
use App\Infrastructure\DocumentParsing\DTOs\ExtractionOptions;

/**
 * Process Document Command
 * Command to initiate document processing workflow
 */
final readonly class ProcessDocumentCommand
{
    public function __construct(
        private string $documentId,
        private string $filePath,
        private string $fileName,
        private ?DocumentType $expectedType = null,
        private ?ExtractionOptions $extractionOptions = null,
        private array $processingOptions = [],
        private ?string $organizationId = null,
        private ?string $userId = null
    ) {}

    public static function create(
        string $documentId,
        string $filePath,
        string $fileName,
        ?DocumentType $expectedType = null
    ): self {
        return new self(
            documentId: $documentId,
            filePath: $filePath,
            fileName: $fileName,
            expectedType: $expectedType
        );
    }

    public function getDocumentId(): string
    {
        return $this->documentId;
    }

    public function getFilePath(): string
    {
        return $this->filePath;
    }

    public function getFileName(): string
    {
        return $this->fileName;
    }

    public function getExpectedType(): ?DocumentType
    {
        return $this->expectedType;
    }

    public function getExtractionOptions(): ExtractionOptions
    {
        return $this->extractionOptions ?? ExtractionOptions::default();
    }

    public function getProcessingOptions(): array
    {
        return $this->processingOptions;
    }

    public function getOrganizationId(): ?string
    {
        return $this->organizationId;
    }

    public function getUserId(): ?string
    {
        return $this->userId;
    }

    public function withExtractionOptions(ExtractionOptions $options): self
    {
        return new self(
            documentId: $this->documentId,
            filePath: $this->filePath,
            fileName: $this->fileName,
            expectedType: $this->expectedType,
            extractionOptions: $options,
            processingOptions: $this->processingOptions,
            organizationId: $this->organizationId,
            userId: $this->userId
        );
    }

    public function withProcessingOptions(array $options): self
    {
        return new self(
            documentId: $this->documentId,
            filePath: $this->filePath,
            fileName: $this->fileName,
            expectedType: $this->expectedType,
            extractionOptions: $this->extractionOptions,
            processingOptions: array_merge($this->processingOptions, $options),
            organizationId: $this->organizationId,
            userId: $this->userId
        );
    }

    public function withUserContext(string $userId, ?string $organizationId = null): self
    {
        return new self(
            documentId: $this->documentId,
            filePath: $this->filePath,
            fileName: $this->fileName,
            expectedType: $this->expectedType,
            extractionOptions: $this->extractionOptions,
            processingOptions: $this->processingOptions,
            organizationId: $organizationId,
            userId: $userId
        );
    }

    public function getProcessingOption(string $key, mixed $default = null): mixed
    {
        return $this->processingOptions[$key] ?? $default;
    }

    public function hasProcessingOption(string $key): bool
    {
        return array_key_exists($key, $this->processingOptions);
    }

    public function shouldUseAi(): bool
    {
        return $this->getProcessingOption('use_ai', false);
    }

    public function shouldSkipClassification(): bool
    {
        return $this->getProcessingOption('skip_classification', false);
    }

    public function getQualityThreshold(): float
    {
        return $this->getProcessingOption('quality_threshold', 0.85);
    }

    public function toArray(): array
    {
        return [
            'document_id' => $this->documentId,
            'file_path' => $this->filePath,
            'file_name' => $this->fileName,
            'expected_type' => $this->expectedType?->toArray(),
            'extraction_options' => $this->extractionOptions?->toArray(),
            'processing_options' => $this->processingOptions,
            'organization_id' => $this->organizationId,
            'user_id' => $this->userId,
        ];
    }
}