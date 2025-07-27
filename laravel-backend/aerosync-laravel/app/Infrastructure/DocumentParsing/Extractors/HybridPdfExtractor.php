<?php

namespace App\Infrastructure\DocumentParsing\Extractors;

use App\Domain\DocumentParsing\ValueObjects\Content;
use App\Domain\DocumentParsing\ValueObjects\QualityScore;
use App\Infrastructure\DocumentParsing\DTOs\ExtractionResult;
use App\Infrastructure\DocumentParsing\DTOs\ExtractionOptions;
use App\Infrastructure\DocumentParsing\Exceptions\ExtractionException;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\Log;

/**
 * Hybrid PDF Extractor
 * Uses multiple extraction methods and selects the best result
 */
class HybridPdfExtractor implements PdfExtractor
{
    private const NAME = 'hybrid';
    private const PRIORITY = 100; // Highest priority
    private const SUPPORTED_FEATURES = [
        'multi_method_extraction',
        'quality_comparison',
        'automatic_fallback',
        'best_result_selection',
    ];

    /** @var Collection<PdfExtractor> */
    private Collection $extractors;

    public function __construct(
        private SpatieTextExtractor $spatieExtractor,
        private ?PopplerExtractor $popplerExtractor = null,
        private ?TesseractOcrExtractor $ocrExtractor = null
    ) {
        $this->extractors = new Collection();
        
        // Add available extractors in priority order
        $this->extractors->push($this->spatieExtractor);
        
        if ($this->popplerExtractor !== null) {
            $this->extractors->push($this->popplerExtractor);
        }
        
        if ($this->ocrExtractor !== null) {
            $this->extractors->push($this->ocrExtractor);
        }
    }

    public function extract(string $filePath, ExtractionOptions $options): ExtractionResult
    {
        $startTime = microtime(true);
        
        try {
            $this->validateFile($filePath);
            
            $results = $this->extractWithAllMethods($filePath, $options);
            $bestResult = $this->selectBestResult($results, $options);
            
            if ($bestResult === null) {
                throw new ExtractionException("All extraction methods failed");
            }
            
            $processingTime = (microtime(true) - $startTime) * 1000;
            
            // Enhance metadata with comparison data
            $metadata = array_merge($bestResult->getMetadata(), [
                'hybrid_extraction' => true,
                'methods_attempted' => $results->keys()->toArray(),
                'total_processing_time_ms' => $processingTime,
                'best_method' => $bestResult->getExtractorName(),
                'quality_comparison' => $this->generateQualityComparison($results),
            ]);
            
            return ExtractionResult::success(
                content: $bestResult->getContent(),
                qualityScore: $bestResult->getQualityScore(),
                extractorName: self::NAME,
                metadata: $metadata,
                processingTimeMs: $processingTime
            );
            
        } catch (ExtractionException $e) {
            throw $e;
        } catch (\Throwable $e) {
            $processingTime = (microtime(true) - $startTime) * 1000;
            
            return ExtractionResult::failure(
                extractorName: self::NAME,
                errorMessage: $e->getMessage(),
                metadata: ['file_path' => $filePath],
                processingTimeMs: $processingTime
            );
        }
    }

    private function extractWithAllMethods(string $filePath, ExtractionOptions $options): Collection
    {
        $results = new Collection();
        $availableExtractors = $this->getAvailableExtractors($filePath);
        
        foreach ($availableExtractors as $extractor) {
            try {
                Log::info("Attempting extraction with {$extractor->getName()}", [
                    'file_path' => $filePath,
                    'extractor' => $extractor->getName(),
                ]);
                
                $result = $extractor->extract($filePath, $options);
                
                if ($result->isSuccessful() && $result->hasContent()) {
                    $results->put($extractor->getName(), $result);
                    
                    Log::info("Extraction successful with {$extractor->getName()}", [
                        'quality_score' => $result->getQualityScore()->getValue(),
                        'content_length' => strlen($result->getContent()->getCleanedContent()),
                        'processing_time_ms' => $result->getProcessingTimeMs(),
                    ]);
                } else {
                    Log::warning("Extraction failed with {$extractor->getName()}", [
                        'error' => $result->getErrorMessage(),
                    ]);
                }
                
            } catch (\Throwable $e) {
                Log::error("Extraction exception with {$extractor->getName()}", [
                    'file_path' => $filePath,
                    'error' => $e->getMessage(),
                    'extractor' => $extractor->getName(),
                ]);
            }
        }
        
        return $results;
    }

    private function getAvailableExtractors(string $filePath): Collection
    {
        return $this->extractors
            ->filter(fn(PdfExtractor $extractor) => $extractor->canHandle($filePath))
            ->sortByDesc(fn(PdfExtractor $extractor) => $extractor->getPriority());
    }

    private function selectBestResult(Collection $results, ExtractionOptions $options): ?ExtractionResult
    {
        if ($results->isEmpty()) {
            return null;
        }
        
        // If only one result, return it
        if ($results->count() === 1) {
            return $results->first();
        }
        
        // Score each result based on multiple criteria
        $scoredResults = $results->map(function (ExtractionResult $result, string $extractorName) use ($options) {
            $score = $this->calculateOverallScore($result, $options);
            
            return [
                'result' => $result,
                'score' => $score,
                'extractor' => $extractorName,
            ];
        });
        
        // Sort by score (highest first)
        $best = $scoredResults->sortByDesc('score')->first();
        
        Log::info("Selected best extraction result", [
            'winner' => $best['extractor'],
            'score' => $best['score'],
            'quality_score' => $best['result']->getQualityScore()->getValue(),
        ]);
        
        return $best['result'];
    }

    private function calculateOverallScore(ExtractionResult $result, ExtractionOptions $options): float
    {
        $scores = [];
        $weights = [];
        
        // Quality score (50% weight)
        $scores[] = $result->getQualityScore()->getValue();
        $weights[] = 0.5;
        
        // Content length score (20% weight)
        $contentScore = $this->scoreContentLength($result->getContent());
        $scores[] = $contentScore;
        $weights[] = 0.2;
        
        // Processing speed score (15% weight)
        $speedScore = $this->scoreProcessingSpeed($result->getProcessingTimeMs());
        $scores[] = $speedScore;
        $weights[] = 0.15;
        
        // Extractor reliability score (15% weight)
        $reliabilityScore = $this->scoreExtractorReliability($result->getExtractorName());
        $scores[] = $reliabilityScore;
        $weights[] = 0.15;
        
        // Calculate weighted average
        $totalWeight = array_sum($weights);
        $weightedSum = 0;
        
        for ($i = 0; $i < count($scores); $i++) {
            $weightedSum += $scores[$i] * $weights[$i];
        }
        
        return $weightedSum / $totalWeight;
    }

    private function scoreContentLength(Content $content): float
    {
        $wordCount = $content->getWordCount();
        
        // Score based on reasonable content length
        if ($wordCount < 10) {
            return 0.2; // Very low score for minimal content
        } elseif ($wordCount < 50) {
            return 0.5;
        } elseif ($wordCount < 200) {
            return 0.8;
        } else {
            return 1.0; // Full score for substantial content
        }
    }

    private function scoreProcessingSpeed(float $processingTimeMs): float
    {
        // Score based on processing speed (faster = better)
        if ($processingTimeMs < 1000) { // < 1 second
            return 1.0;
        } elseif ($processingTimeMs < 5000) { // < 5 seconds
            return 0.8;
        } elseif ($processingTimeMs < 15000) { // < 15 seconds
            return 0.6;
        } elseif ($processingTimeMs < 30000) { // < 30 seconds
            return 0.4;
        } else {
            return 0.2; // Slow processing
        }
    }

    private function scoreExtractorReliability(string $extractorName): float
    {
        // Score based on known extractor reliability
        return match ($extractorName) {
            'spatie_text' => 0.9,      // Very reliable for text PDFs
            'poppler' => 0.8,          // Good reliability, better structure
            'tesseract_ocr' => 0.6,    // Lower reliability, but handles scanned docs
            default => 0.5
        };
    }

    private function generateQualityComparison(Collection $results): array
    {
        return $results->map(function (ExtractionResult $result, string $extractorName) {
            return [
                'extractor' => $extractorName,
                'quality_score' => $result->getQualityScore()->getValue(),
                'content_length' => strlen($result->getContent()->getCleanedContent()),
                'word_count' => $result->getContent()->getWordCount(),
                'processing_time_ms' => $result->getProcessingTimeMs(),
                'successful' => $result->isSuccessful(),
            ];
        })->toArray();
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
    }

    public function canHandle(string $filePath): bool
    {
        if (!file_exists($filePath)) {
            return false;
        }
        
        $fileInfo = pathinfo($filePath);
        return strtolower($fileInfo['extension'] ?? '') === 'pdf';
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

    public function getAvailableExtractorNames(): array
    {
        return $this->extractors->map(fn(PdfExtractor $extractor) => $extractor->getName())->toArray();
    }
}