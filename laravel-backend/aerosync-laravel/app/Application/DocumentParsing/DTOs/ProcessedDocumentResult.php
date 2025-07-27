<?php

namespace App\Application\DocumentParsing\DTOs;

use App\Application\DocumentParsing\Commands\ProcessDocumentCommand;
use App\Domain\DocumentParsing\Entities\RegulatoryDocument;
use App\Infrastructure\DocumentParsing\DTOs\ExtractionResult;

/**
 * Processed Document Result DTO
 * Contains the complete result of document processing workflow
 */
final readonly class ProcessedDocumentResult
{
    public function __construct(
        private bool $successful,
        private ?RegulatoryDocument $document = null,
        private ?ExtractionResult $extractionResult = null,
        private ?string $errorMessage = null,
        private float $processingTimeMs = 0.0,
        private array $metadata = []
    ) {}

    public static function success(
        RegulatoryDocument $document,
        ExtractionResult $extractionResult,
        float $processingTimeMs = 0.0,
        array $metadata = []
    ): self {
        return new self(
            successful: true,
            document: $document,
            extractionResult: $extractionResult,
            processingTimeMs: $processingTimeMs,
            metadata: $metadata
        );
    }

    public static function failure(
        ProcessDocumentCommand $command,
        string $error,
        float $processingTimeMs = 0.0,
        array $metadata = []
    ): self {
        $metadata = array_merge($metadata, [
            'failed_command' => $command->toArray(),
            'failure_timestamp' => now()->toISOString(),
        ]);

        return new self(
            successful: false,
            errorMessage: $error,
            processingTimeMs: $processingTimeMs,
            metadata: $metadata
        );
    }

    public function isSuccessful(): bool
    {
        return $this->successful;
    }

    public function getDocument(): ?RegulatoryDocument
    {
        return $this->document;
    }

    public function getExtractionResult(): ?ExtractionResult
    {
        return $this->extractionResult;
    }

    public function getErrorMessage(): ?string
    {
        return $this->errorMessage;
    }

    public function getProcessingTimeMs(): float
    {
        return $this->processingTimeMs;
    }

    public function getProcessingTimeSeconds(): float
    {
        return $this->processingTimeMs / 1000;
    }

    public function getMetadata(): array
    {
        return $this->metadata;
    }

    public function hasDocument(): bool
    {
        return $this->document !== null;
    }

    public function hasExtractionResult(): bool
    {
        return $this->extractionResult !== null;
    }

    public function isQualityAcceptable(): bool
    {
        if (!$this->successful || !$this->document) {
            return false;
        }

        $qualityScore = $this->document->getOverallQualityScore();
        return $qualityScore !== null && $qualityScore->isGood();
    }

    public function getProcessingSummary(): array
    {
        $summary = [
            'successful' => $this->successful,
            'processing_time_ms' => $this->processingTimeMs,
            'processing_time_seconds' => $this->getProcessingTimeSeconds(),
        ];

        if ($this->document) {
            $summary['document'] = [
                'id' => $this->document->getId(),
                'type' => $this->document->getType()->getValue(),
                'status' => $this->document->getStatus()->getValue(),
                'sections_count' => $this->document->getSections()->count(),
                'quality_score' => $this->document->getOverallQualityScore()?->getValue(),
            ];
        }

        if ($this->extractionResult) {
            $summary['extraction'] = [
                'extractor' => $this->extractionResult->getExtractorName(),
                'quality_score' => $this->extractionResult->getQualityScore()->getValue(),
                'content_length' => strlen($this->extractionResult->getContent()->getCleanedContent()),
                'word_count' => $this->extractionResult->getContent()->getWordCount(),
            ];
        }

        if ($this->errorMessage) {
            $summary['error'] = $this->errorMessage;
        }

        return $summary;
    }

    public function toArray(): array
    {
        return [
            'successful' => $this->successful,
            'document' => $this->document?->toArray(),
            'extraction_result' => $this->extractionResult?->toArray(),
            'error_message' => $this->errorMessage,
            'processing_time_ms' => $this->processingTimeMs,
            'processing_time_seconds' => $this->getProcessingTimeSeconds(),
            'metadata' => $this->metadata,
            'summary' => $this->getProcessingSummary(),
        ];
    }
}