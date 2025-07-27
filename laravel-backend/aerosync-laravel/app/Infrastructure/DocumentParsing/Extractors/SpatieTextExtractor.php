<?php

namespace App\Infrastructure\DocumentParsing\Extractors;

use App\Domain\DocumentParsing\ValueObjects\Content;
use App\Domain\DocumentParsing\ValueObjects\QualityScore;
use App\Infrastructure\DocumentParsing\DTOs\ExtractionResult;
use App\Infrastructure\DocumentParsing\DTOs\ExtractionOptions;
use App\Infrastructure\DocumentParsing\Exceptions\ExtractionException;
use Spatie\PdfToText\Pdf;
use Throwable;

/**
 * Spatie PDF to Text Extractor
 * Fast PDF text extraction using spatie/pdf-to-text package
 */
class SpatieTextExtractor implements PdfExtractor
{
    private const NAME = 'spatie_text';
    private const PRIORITY = 80; // High priority for text-based PDFs
    private const SUPPORTED_FEATURES = [
        'fast_extraction',
        'basic_layout_preservation',
        'encoding_detection',
    ];

    public function extract(string $filePath, ExtractionOptions $options): ExtractionResult
    {
        $startTime = microtime(true);
        
        try {
            $this->validateFile($filePath);
            
            $text = $this->performExtraction($filePath, $options);
            $content = Content::fromRaw($text);
            
            $qualityScore = $options->enableQualityAnalysis() 
                ? $this->assessQuality($content, $options)
                : QualityScore::good();
            
            $processingTime = (microtime(true) - $startTime) * 1000;
            
            $metadata = [
                'file_size' => filesize($filePath),
                'extraction_method' => 'pdftotext',
                'layout_preserved' => $options->preserveLayout(),
                'character_count' => strlen($text),
                'word_count' => $content->getWordCount(),
                'line_count' => $content->getLineCount(),
            ];
            
            return ExtractionResult::success(
                content: $content,
                qualityScore: $qualityScore,
                extractorName: self::NAME,
                metadata: $metadata,
                processingTimeMs: $processingTime
            );
            
        } catch (Throwable $e) {
            $processingTime = (microtime(true) - $startTime) * 1000;
            
            return ExtractionResult::failure(
                extractorName: self::NAME,
                errorMessage: $e->getMessage(),
                metadata: ['file_path' => $filePath],
                processingTimeMs: $processingTime
            );
        }
    }

    private function validateFile(string $filePath): void
    {
        if (!file_exists($filePath)) {
            throw new ExtractionException("File not found: {$filePath}");
        }
        
        if (!is_readable($filePath)) {
            throw new ExtractionException("File not readable: {$filePath}");
        }
        
        $fileInfo = pathinfo($filePath);
        if (strtolower($fileInfo['extension'] ?? '') !== 'pdf') {
            throw new ExtractionException("File is not a PDF: {$filePath}");
        }
        
        $fileSize = filesize($filePath);
        if ($fileSize === false || $fileSize === 0) {
            throw new ExtractionException("Invalid or empty file: {$filePath}");
        }
        
        // Check if file is too large (>100MB)
        if ($fileSize > 100 * 1024 * 1024) {
            throw new ExtractionException("File too large for Spatie extractor: " . number_format($fileSize / 1024 / 1024, 1) . "MB");
        }
    }

    private function performExtraction(string $filePath, ExtractionOptions $options): string
    {
        $pdf = new Pdf($this->getBinaryPath());
        
        // Configure extraction options
        if (!$options->preserveLayout()) {
            $pdf->setOptions(['-layout']);
        }
        
        // Set timeout
        $pdf->setTimeout($options->getTimeoutSeconds());
        
        try {
            $text = $pdf->setPdf($filePath)->text();
            
            if (empty($text)) {
                throw new ExtractionException("No text extracted from PDF");
            }
            
            return $text;
            
        } catch (Throwable $e) {
            throw new ExtractionException("Spatie extraction failed: " . $e->getMessage(), 0, $e);
        }
    }

    private function getBinaryPath(): ?string
    {
        // Try to find pdftotext binary
        $possiblePaths = [
            '/usr/bin/pdftotext',
            '/usr/local/bin/pdftotext',
            '/opt/homebrew/bin/pdftotext',
            'pdftotext', // System PATH
        ];
        
        foreach ($possiblePaths as $path) {
            if ($this->isBinaryAvailable($path)) {
                return $path;
            }
        }
        
        return null; // Let Spatie auto-detect
    }

    private function isBinaryAvailable(string $path): bool
    {
        try {
            $output = [];
            $returnVar = 0;
            exec("which $path 2>/dev/null", $output, $returnVar);
            return $returnVar === 0;
        } catch (Throwable) {
            return false;
        }
    }

    private function assessQuality(Content $content, ExtractionOptions $options): QualityScore
    {
        $scores = [];
        $weights = [];
        
        // Text completeness (40% weight)
        $completenessScore = $this->assessCompleteness($content);
        $scores[] = $completenessScore;
        $weights[] = 0.4;
        
        // Character encoding quality (25% weight)
        $encodingScore = $this->assessEncoding($content);
        $scores[] = $encodingScore;
        $weights[] = 0.25;
        
        // Structure preservation (20% weight)
        $structureScore = $this->assessStructure($content);
        $scores[] = $structureScore;
        $weights[] = 0.2;
        
        // Content coherence (15% weight)
        $coherenceScore = $this->assessCoherence($content);
        $scores[] = $coherenceScore;
        $weights[] = 0.15;
        
        // Calculate weighted average
        $totalWeight = array_sum($weights);
        $weightedSum = 0;
        
        for ($i = 0; $i < count($scores); $i++) {
            $weightedSum += $scores[$i] * $weights[$i];
        }
        
        return new QualityScore($weightedSum / $totalWeight);
    }

    private function assessCompleteness(Content $content): float
    {
        $text = $content->getCleanedContent();
        $score = 1.0;
        
        // Check minimum content requirements
        if ($content->getWordCount() < 10) {
            $score -= 0.5;
        }
        
        if ($content->getParagraphCount() < 2) {
            $score -= 0.2;
        }
        
        // Check for truncation indicators
        $truncationMarkers = ['...', '[truncated]', '(continued)', '...continued'];
        foreach ($truncationMarkers as $marker) {
            if (str_contains(strtolower($text), strtolower($marker))) {
                $score -= 0.3;
                break;
            }
        }
        
        return max(0.0, $score);
    }

    private function assessEncoding(Content $content): float
    {
        $text = $content->getRawContent();
        $score = 1.0;
        
        // Check for encoding issues
        if ($content->hasSuspiciousPatterns()) {
            $score -= 0.4;
        }
        
        // Check compression ratio (indicates cleaning was needed)
        if ($content->getCompressionRatio() < 0.8) {
            $score -= 0.3;
        }
        
        // Check for common encoding artifacts
        $artifacts = ['Ã', 'â€', 'Â', 'Ãº', 'Ã¡'];
        foreach ($artifacts as $artifact) {
            if (str_contains($text, $artifact)) {
                $score -= 0.2;
                break;
            }
        }
        
        return max(0.0, $score);
    }

    private function assessStructure(Content $content): float
    {
        $text = $content->getCleanedContent();
        $score = 1.0;
        
        // Check for basic document structure
        $hasHeaders = preg_match('/^\d+\.?\s+[A-Z]/', $text, $matches, PREG_MULTILINE);
        if (!$hasHeaders) {
            $score -= 0.3;
        }
        
        // Check line length variation (indicates layout preservation)
        $lines = explode("\n", $text);
        $lineLengths = array_map('strlen', $lines);
        $avgLength = array_sum($lineLengths) / count($lineLengths);
        $variance = 0;
        
        foreach ($lineLengths as $length) {
            $variance += pow($length - $avgLength, 2);
        }
        $variance = $variance / count($lineLengths);
        
        // Good structure should have varied line lengths
        if ($variance < 100) {
            $score -= 0.2;
        }
        
        return max(0.0, $score);
    }

    private function assessCoherence(Content $content): float
    {
        $text = $content->getCleanedContent();
        $score = 1.0;
        
        // Check for excessive whitespace (indicates extraction issues)
        if (preg_match('/\s{5,}/', $text)) {
            $score -= 0.2;
        }
        
        // Check for repeated characters (extraction artifacts)
        if (preg_match('/(.)\1{10,}/', $text)) {
            $score -= 0.3;
        }
        
        // Check word-to-character ratio
        $charCount = strlen(preg_replace('/\s/', '', $text));
        $wordCount = $content->getWordCount();
        
        if ($wordCount > 0) {
            $avgWordLength = $charCount / $wordCount;
            // Average English word length is about 4-5 characters
            if ($avgWordLength < 2 || $avgWordLength > 15) {
                $score -= 0.2;
            }
        }
        
        return max(0.0, $score);
    }

    public function canHandle(string $filePath): bool
    {
        if (!file_exists($filePath)) {
            return false;
        }
        
        $fileInfo = pathinfo($filePath);
        if (strtolower($fileInfo['extension'] ?? '') !== 'pdf') {
            return false;
        }
        
        $fileSize = filesize($filePath);
        return $fileSize !== false && $fileSize > 0 && $fileSize <= 100 * 1024 * 1024;
    }

    public function getPriority(): int
    {
        return self::PRIORITY;
    }

    public function getName(): string
    {
        return self::NAME;
    }

    public function getSupportedFeatures(): array
    {
        return self::SUPPORTED_FEATURES;
    }
}