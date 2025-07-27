<?php

namespace App\Infrastructure\DocumentParsing\DTOs;

/**
 * Extraction Options DTO
 * Configuration options for PDF text extraction
 */
final readonly class ExtractionOptions
{
    public function __construct(
        private bool $preserveLayout = true,
        private bool $extractImages = false,
        private bool $extractMetadata = true,
        private bool $useOcr = false,
        private array $ocrLanguages = ['eng'],
        private int $timeoutSeconds = 300,
        private int $maxMemoryMb = 512,
        private bool $enableQualityAnalysis = true,
        private float $qualityThreshold = 0.7,
        private array $customOptions = []
    ) {}

    public static function default(): self
    {
        return new self();
    }

    public static function withOcr(array $languages = ['eng']): self
    {
        return new self(
            useOcr: true,
            ocrLanguages: $languages
        );
    }

    public static function fastExtraction(): self
    {
        return new self(
            preserveLayout: false,
            extractImages: false,
            extractMetadata: false,
            enableQualityAnalysis: false
        );
    }

    public static function highQuality(): self
    {
        return new self(
            preserveLayout: true,
            extractImages: true,
            extractMetadata: true,
            enableQualityAnalysis: true,
            qualityThreshold: 0.85
        );
    }

    public function preserveLayout(): bool
    {
        return $this->preserveLayout;
    }

    public function extractImages(): bool
    {
        return $this->extractImages;
    }

    public function extractMetadata(): bool
    {
        return $this->extractMetadata;
    }

    public function useOcr(): bool
    {
        return $this->useOcr;
    }

    public function getOcrLanguages(): array
    {
        return $this->ocrLanguages;
    }

    public function getTimeoutSeconds(): int
    {
        return $this->timeoutSeconds;
    }

    public function getMaxMemoryMb(): int
    {
        return $this->maxMemoryMb;
    }

    public function enableQualityAnalysis(): bool
    {
        return $this->enableQualityAnalysis;
    }

    public function getQualityThreshold(): float
    {
        return $this->qualityThreshold;
    }

    public function getCustomOptions(): array
    {
        return $this->customOptions;
    }

    public function getCustomOption(string $key, mixed $default = null): mixed
    {
        return $this->customOptions[$key] ?? $default;
    }

    public function withCustomOption(string $key, mixed $value): self
    {
        $newOptions = $this->customOptions;
        $newOptions[$key] = $value;

        return new self(
            preserveLayout: $this->preserveLayout,
            extractImages: $this->extractImages,
            extractMetadata: $this->extractMetadata,
            useOcr: $this->useOcr,
            ocrLanguages: $this->ocrLanguages,
            timeoutSeconds: $this->timeoutSeconds,
            maxMemoryMb: $this->maxMemoryMb,
            enableQualityAnalysis: $this->enableQualityAnalysis,
            qualityThreshold: $this->qualityThreshold,
            customOptions: $newOptions
        );
    }

    public function withTimeout(int $seconds): self
    {
        return new self(
            preserveLayout: $this->preserveLayout,
            extractImages: $this->extractImages,
            extractMetadata: $this->extractMetadata,
            useOcr: $this->useOcr,
            ocrLanguages: $this->ocrLanguages,
            timeoutSeconds: $seconds,
            maxMemoryMb: $this->maxMemoryMb,
            enableQualityAnalysis: $this->enableQualityAnalysis,
            qualityThreshold: $this->qualityThreshold,
            customOptions: $this->customOptions
        );
    }

    public function withQualityThreshold(float $threshold): self
    {
        return new self(
            preserveLayout: $this->preserveLayout,
            extractImages: $this->extractImages,
            extractMetadata: $this->extractMetadata,
            useOcr: $this->useOcr,
            ocrLanguages: $this->ocrLanguages,
            timeoutSeconds: $this->timeoutSeconds,
            maxMemoryMb: $this->maxMemoryMb,
            enableQualityAnalysis: $this->enableQualityAnalysis,
            qualityThreshold: $threshold,
            customOptions: $this->customOptions
        );
    }

    public function toArray(): array
    {
        return [
            'preserve_layout' => $this->preserveLayout,
            'extract_images' => $this->extractImages,
            'extract_metadata' => $this->extractMetadata,
            'use_ocr' => $this->useOcr,
            'ocr_languages' => $this->ocrLanguages,
            'timeout_seconds' => $this->timeoutSeconds,
            'max_memory_mb' => $this->maxMemoryMb,
            'enable_quality_analysis' => $this->enableQualityAnalysis,
            'quality_threshold' => $this->qualityThreshold,
            'custom_options' => $this->customOptions,
        ];
    }
}