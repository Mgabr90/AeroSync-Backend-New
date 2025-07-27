<?php

namespace App\Infrastructure\DocumentParsing\Exceptions;

use Exception;

/**
 * PDF Extraction Exception
 * Thrown when PDF text extraction fails
 */
class ExtractionException extends Exception
{
    public function __construct(
        string $message = '',
        int $code = 0,
        ?\Throwable $previous = null,
        private ?string $filePath = null,
        private ?string $extractorName = null
    ) {
        parent::__construct($message, $code, $previous);
    }

    public static function fileNotFound(string $filePath): self
    {
        return new self(
            message: "PDF file not found: {$filePath}",
            filePath: $filePath
        );
    }

    public static function fileNotReadable(string $filePath): self
    {
        return new self(
            message: "PDF file not readable: {$filePath}",
            filePath: $filePath
        );
    }

    public static function invalidFileFormat(string $filePath): self
    {
        return new self(
            message: "File is not a valid PDF: {$filePath}",
            filePath: $filePath
        );
    }

    public static function extractorFailed(string $extractorName, string $reason, string $filePath = null): self
    {
        return new self(
            message: "PDF extraction failed with {$extractorName}: {$reason}",
            extractorName: $extractorName,
            filePath: $filePath
        );
    }

    public static function timeout(string $extractorName, int $timeoutSeconds, string $filePath = null): self
    {
        return new self(
            message: "PDF extraction timed out after {$timeoutSeconds} seconds using {$extractorName}",
            extractorName: $extractorName,
            filePath: $filePath
        );
    }

    public static function memoryExceeded(string $extractorName, string $filePath = null): self
    {
        return new self(
            message: "PDF extraction exceeded memory limit using {$extractorName}",
            extractorName: $extractorName,
            filePath: $filePath
        );
    }

    public function getFilePath(): ?string
    {
        return $this->filePath;
    }

    public function getExtractorName(): ?string
    {
        return $this->extractorName;
    }

    public function toArray(): array
    {
        return [
            'message' => $this->getMessage(),
            'code' => $this->getCode(),
            'file_path' => $this->filePath,
            'extractor_name' => $this->extractorName,
            'trace' => $this->getTraceAsString(),
        ];
    }
}