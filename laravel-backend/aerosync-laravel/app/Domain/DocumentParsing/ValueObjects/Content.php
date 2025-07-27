<?php

namespace App\Domain\DocumentParsing\ValueObjects;

use InvalidArgumentException;

/**
 * Content Value Object
 * Represents validated and cleaned content extracted from PDF documents
 */
final readonly class Content
{
    private const MIN_LENGTH = 1;
    private const MAX_LENGTH = 100000; // 100KB of text
    private const SUSPICIOUS_PATTERNS = [
        '/[\x00-\x08\x0B\x0C\x0E-\x1F\x7F]/', // Control characters except \t, \n, \r
        '/�+/',                                // Replacement characters
        '/\uFFFD+/',                          // Unicode replacement characters
    ];

    public function __construct(
        private string $rawContent,
        private string $cleanedContent,
        private array $metadata = []
    ) {
        $this->validateContent($rawContent);
        $this->validateContent($cleanedContent);
    }

    public static function fromRaw(string $content): self
    {
        $cleaned = self::cleanContent($content);
        $metadata = self::generateMetadata($content, $cleaned);
        
        return new self($content, $cleaned, $metadata);
    }

    public static function fromCleaned(string $cleanedContent): self
    {
        $metadata = self::generateMetadata($cleanedContent, $cleanedContent);
        
        return new self($cleanedContent, $cleanedContent, $metadata);
    }

    private function validateContent(string $content): void
    {
        $length = strlen($content);
        
        if ($length < self::MIN_LENGTH) {
            throw new InvalidArgumentException('Content cannot be empty');
        }
        
        if ($length > self::MAX_LENGTH) {
            throw new InvalidArgumentException("Content too long: {$length} characters (max: " . self::MAX_LENGTH . ")");
        }
    }

    private static function cleanContent(string $content): string
    {
        // Remove control characters except \t, \n, \r
        $cleaned = preg_replace('/[\x00-\x08\x0B\x0C\x0E-\x1F\x7F]/', '', $content);
        
        // Remove replacement characters
        $cleaned = preg_replace('/�+/', '', $cleaned);
        
        // Normalize whitespace
        $cleaned = preg_replace('/\s+/', ' ', $cleaned);
        
        // Remove leading/trailing whitespace
        $cleaned = trim($cleaned);
        
        // Remove excessive line breaks
        $cleaned = preg_replace('/\n{3,}/', "\n\n", $cleaned);
        
        return $cleaned;
    }

    private static function generateMetadata(string $original, string $cleaned): array
    {
        $originalLength = strlen($original);
        $cleanedLength = strlen($cleaned);
        
        return [
            'original_length' => $originalLength,
            'cleaned_length' => $cleanedLength,
            'compression_ratio' => $originalLength > 0 ? $cleanedLength / $originalLength : 0,
            'word_count' => str_word_count($cleaned),
            'line_count' => substr_count($cleaned, "\n") + 1,
            'paragraph_count' => count(array_filter(explode("\n\n", $cleaned))),
            'has_suspicious_patterns' => self::hasSuspiciousPatterns($original),
            'extracted_at' => time(),
        ];
    }

    private static function hasSuspiciousPatterns(string $content): bool
    {
        foreach (self::SUSPICIOUS_PATTERNS as $pattern) {
            if (preg_match($pattern, $content)) {
                return true;
            }
        }
        
        return false;
    }

    public function getRawContent(): string
    {
        return $this->rawContent;
    }

    public function getCleanedContent(): string
    {
        return $this->cleanedContent;
    }

    public function getContent(): string
    {
        return $this->cleanedContent;
    }

    public function getMetadata(): array
    {
        return $this->metadata;
    }

    public function getWordCount(): int
    {
        return $this->metadata['word_count'] ?? 0;
    }

    public function getLineCount(): int
    {
        return $this->metadata['line_count'] ?? 0;
    }

    public function getParagraphCount(): int
    {
        return $this->metadata['paragraph_count'] ?? 0;
    }

    public function getCompressionRatio(): float
    {
        return $this->metadata['compression_ratio'] ?? 0.0;
    }

    public function hasSignificantCleaning(): bool
    {
        return $this->getCompressionRatio() < 0.95;
    }

    public function hasSuspiciousPatterns(): bool
    {
        return $this->metadata['has_suspicious_patterns'] ?? false;
    }

    public function isEmpty(): bool
    {
        return empty(trim($this->cleanedContent));
    }

    public function isSubstantial(): bool
    {
        return $this->getWordCount() >= 10;
    }

    public function containsText(string $needle, bool $caseSensitive = false): bool
    {
        if ($caseSensitive) {
            return str_contains($this->cleanedContent, $needle);
        }
        
        return str_contains(strtolower($this->cleanedContent), strtolower($needle));
    }

    public function startsWith(string $prefix, bool $caseSensitive = false): bool
    {
        if ($caseSensitive) {
            return str_starts_with($this->cleanedContent, $prefix);
        }
        
        return str_starts_with(strtolower($this->cleanedContent), strtolower($prefix));
    }

    public function endsWith(string $suffix, bool $caseSensitive = false): bool
    {
        if ($caseSensitive) {
            return str_ends_with($this->cleanedContent, $suffix);
        }
        
        return str_ends_with(strtolower($this->cleanedContent), strtolower($suffix));
    }

    public function matches(string $pattern): bool
    {
        return preg_match($pattern, $this->cleanedContent) === 1;
    }

    public function getPreview(int $length = 200): string
    {
        if (strlen($this->cleanedContent) <= $length) {
            return $this->cleanedContent;
        }
        
        return substr($this->cleanedContent, 0, $length - 3) . '...';
    }

    public function getSentences(): array
    {
        return preg_split('/[.!?]+/', $this->cleanedContent, -1, PREG_SPLIT_NO_EMPTY);
    }

    public function getWords(): array
    {
        return array_filter(preg_split('/\s+/', $this->cleanedContent));
    }

    public function equals(Content $other): bool
    {
        return $this->cleanedContent === $other->cleanedContent;
    }

    public function toArray(): array
    {
        return [
            'content' => $this->cleanedContent,
            'preview' => $this->getPreview(),
            'metadata' => $this->metadata,
        ];
    }

    public function __toString(): string
    {
        return $this->cleanedContent;
    }
}