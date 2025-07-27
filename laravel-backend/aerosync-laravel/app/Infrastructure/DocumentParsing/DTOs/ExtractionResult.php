<?php

namespace App\Infrastructure\DocumentParsing\DTOs;

use App\Domain\DocumentParsing\ValueObjects\Content;
use App\Domain\DocumentParsing\ValueObjects\QualityScore;

/**
 * Extraction Result DTO
 * Contains the results of PDF text extraction
 */
final readonly class ExtractionResult
{
    public function __construct(
        private Content $content,
        private QualityScore $qualityScore,
        private string $extractorName,
        private array $metadata = [],
        private bool $successful = true,
        private ?string $errorMessage = null,
        private float $processingTimeMs = 0.0
    ) {}

    public static function success(
        Content $content,
        QualityScore $qualityScore,
        string $extractorName,
        array $metadata = [],
        float $processingTimeMs = 0.0
    ): self {
        return new self(
            content: $content,
            qualityScore: $qualityScore,
            extractorName: $extractorName,
            metadata: $metadata,
            successful: true,
            processingTimeMs: $processingTimeMs
        );
    }

    public static function failure(
        string $extractorName,
        string $errorMessage,
        array $metadata = [],
        float $processingTimeMs = 0.0
    ): self {
        return new self(
            content: Content::fromCleaned(''),
            qualityScore: QualityScore::zero(),
            extractorName: $extractorName,
            metadata: $metadata,
            successful: false,
            errorMessage: $errorMessage,
            processingTimeMs: $processingTimeMs
        );
    }

    public function getContent(): Content
    {
        return $this->content;
    }

    public function getQualityScore(): QualityScore
    {
        return $this->qualityScore;
    }

    public function getExtractorName(): string
    {
        return $this->extractorName;
    }

    public function getMetadata(): array
    {
        return $this->metadata;
    }

    public function isSuccessful(): bool
    {
        return $this->successful;
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

    public function hasContent(): bool
    {
        return $this->successful && !$this->content->isEmpty();
    }

    public function hasHighQuality(): bool
    {
        return $this->qualityScore->isGood();
    }

    public function toArray(): array
    {
        return [
            'content' => $this->content->toArray(),
            'quality_score' => $this->qualityScore->toArray(),
            'extractor_name' => $this->extractorName,
            'metadata' => $this->metadata,
            'successful' => $this->successful,
            'error_message' => $this->errorMessage,
            'processing_time_ms' => $this->processingTimeMs,
        ];
    }
}