<?php

namespace App\Infrastructure\DocumentParsing\Classifiers;

use App\Domain\DocumentParsing\ValueObjects\DocumentType;
use App\Domain\DocumentParsing\ValueObjects\Content;

/**
 * Document Classifier Interface
 * Contract for document type classification implementations
 */
interface DocumentClassifier
{
    /**
     * Classify the document type based on content and filename
     *
     * @param Content $content The extracted document content
     * @param string $fileName The original filename
     * @return ClassificationResult The classification result with confidence scores
     */
    public function classify(Content $content, string $fileName): ClassificationResult;

    /**
     * Get the classifier name/identifier
     *
     * @return string Classifier name
     */
    public function getName(): string;

    /**
     * Get the confidence threshold for this classifier
     *
     * @return float Minimum confidence score (0.0 - 1.0)
     */
    public function getConfidenceThreshold(): float;

    /**
     * Get supported document types
     *
     * @return array List of DocumentType constants this classifier can detect
     */
    public function getSupportedTypes(): array;
}