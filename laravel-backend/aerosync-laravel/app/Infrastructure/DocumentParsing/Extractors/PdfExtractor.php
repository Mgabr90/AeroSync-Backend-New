<?php

namespace App\Infrastructure\DocumentParsing\Extractors;

use App\Domain\DocumentParsing\ValueObjects\Content;
use App\Infrastructure\DocumentParsing\DTOs\ExtractionResult;
use App\Infrastructure\DocumentParsing\DTOs\ExtractionOptions;

/**
 * PDF Extractor Interface
 * Contract for all PDF text extraction implementations
 */
interface PdfExtractor
{
    /**
     * Extract text content from a PDF file
     *
     * @param string $filePath Path to the PDF file
     * @param ExtractionOptions $options Extraction configuration options
     * @return ExtractionResult The extraction result with content and metadata
     * @throws ExtractionException If extraction fails
     */
    public function extract(string $filePath, ExtractionOptions $options): ExtractionResult;

    /**
     * Check if this extractor can handle the given file
     *
     * @param string $filePath Path to the PDF file
     * @return bool True if the extractor can process this file
     */
    public function canHandle(string $filePath): bool;

    /**
     * Get the priority of this extractor (higher = preferred)
     *
     * @return int Priority value (0-100)
     */
    public function getPriority(): int;

    /**
     * Get the name/identifier of this extractor
     *
     * @return string Extractor name
     */
    public function getName(): string;

    /**
     * Get supported features of this extractor
     *
     * @return array List of supported features
     */
    public function getSupportedFeatures(): array;
}