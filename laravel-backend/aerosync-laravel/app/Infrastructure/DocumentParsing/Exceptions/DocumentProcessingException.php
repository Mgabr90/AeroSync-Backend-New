<?php

namespace App\Infrastructure\DocumentParsing\Exceptions;

use Exception;
use Throwable;

/**
 * Document Processing Exception
 * Base exception for all document processing related errors
 */
class DocumentProcessingException extends Exception
{
    public function __construct(
        string $message = '',
        int $code = 0,
        ?Throwable $previous = null,
        private ?string $documentId = null,
        private ?string $phase = null,
        private array $context = []
    ) {
        parent::__construct($message, $code, $previous);
    }

    public static function extractionFailed(
        string $documentId,
        string $reason,
        ?Throwable $previous = null
    ): self {
        return new self(
            message: "Document extraction failed: {$reason}",
            previous: $previous,
            documentId: $documentId,
            phase: 'extraction'
        );
    }

    public static function classificationFailed(
        string $documentId,
        string $reason,
        ?Throwable $previous = null
    ): self {
        return new self(
            message: "Document classification failed: {$reason}",
            previous: $previous,
            documentId: $documentId,
            phase: 'classification'
        );
    }

    public static function sectionParsingFailed(
        string $documentId,
        string $reason,
        ?Throwable $previous = null
    ): self {
        return new self(
            message: "Section parsing failed: {$reason}",
            previous: $previous,
            documentId: $documentId,
            phase: 'section_parsing'
        );
    }

    public static function qualityValidationFailed(
        string $documentId,
        float $actualScore,
        float $requiredScore
    ): self {
        return new self(
            message: "Quality validation failed. Score: {$actualScore}, Required: {$requiredScore}",
            documentId: $documentId,
            phase: 'quality_validation',
            context: [
                'actual_score' => $actualScore,
                'required_score' => $requiredScore,
            ]
        );
    }

    public static function storageFailed(
        string $documentId,
        string $reason,
        ?Throwable $previous = null
    ): self {
        return new self(
            message: "Document storage failed: {$reason}",
            previous: $previous,
            documentId: $documentId,
            phase: 'storage'
        );
    }

    public static function fileNotFound(string $filePath): self
    {
        return new self(
            message: "File not found: {$filePath}",
            phase: 'file_validation',
            context: ['file_path' => $filePath]
        );
    }

    public static function invalidFileFormat(string $filePath, string $expectedFormat): self
    {
        return new self(
            message: "Invalid file format. Expected: {$expectedFormat}",
            phase: 'file_validation',
            context: [
                'file_path' => $filePath,
                'expected_format' => $expectedFormat,
            ]
        );
    }

    public static function processingTimeout(
        string $documentId,
        int $timeoutSeconds
    ): self {
        return new self(
            message: "Processing timeout after {$timeoutSeconds} seconds",
            documentId: $documentId,
            phase: 'processing_timeout',
            context: ['timeout_seconds' => $timeoutSeconds]
        );
    }

    public function getDocumentId(): ?string
    {
        return $this->documentId;
    }

    public function getPhase(): ?string
    {
        return $this->phase;
    }

    public function getContext(): array
    {
        return $this->context;
    }

    public function withContext(array $context): self
    {
        $this->context = array_merge($this->context, $context);
        return $this;
    }

    public function toArray(): array
    {
        return [
            'message' => $this->getMessage(),
            'code' => $this->getCode(),
            'document_id' => $this->documentId,
            'phase' => $this->phase,
            'context' => $this->context,
            'file' => $this->getFile(),
            'line' => $this->getLine(),
            'trace' => $this->getTraceAsString(),
        ];
    }

    public function toLogContext(): array
    {
        return [
            'exception_type' => static::class,
            'message' => $this->getMessage(),
            'document_id' => $this->documentId,
            'phase' => $this->phase,
            'context' => $this->context,
            'file' => $this->getFile(),
            'line' => $this->getLine(),
        ];
    }
}