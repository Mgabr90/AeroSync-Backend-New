<?php

namespace App\Infrastructure\DocumentParsing\Classifiers;

use App\Domain\DocumentParsing\ValueObjects\DocumentType;
use App\Domain\DocumentParsing\ValueObjects\Content;
use Illuminate\Support\Facades\Log;

/**
 * Pattern-Based Document Classifier
 * Uses regex patterns and keywords to classify aviation documents
 */
class PatternBasedClassifier implements DocumentClassifier
{
    private const NAME = 'pattern_based';
    private const CONFIDENCE_THRESHOLD = 0.7;

    // Document type patterns with weights
    private const CLASSIFICATION_PATTERNS = [
        DocumentType::IOSA => [
            'title_patterns' => [
                '/IOSA\s+Standards?\s+Manual/i' => 0.9,
                '/IATA\s+Operational\s+Safety\s+Audit/i' => 0.85,
                '/International\s+Air\s+Transport\s+Association.*IOSA/i' => 0.8,
                '/ISM\s*-?\s*\d+/i' => 0.7,
            ],
            'content_patterns' => [
                '/IOSA\s+Edition\s+\d+/i' => 0.8,
                '/ISM\s+\d+\.\d+/i' => 0.75,
                '/Operational\s+Safety\s+Audit\s+Programme/i' => 0.7,
                '/ORG\s+\d+\.\d+/i' => 0.65,
                '/FLT\s+\d+\.\d+/i' => 0.65,
                '/DSP\s+\d+\.\d+/i' => 0.65,
                '/MEX\s+\d+\.\d+/i' => 0.65,
                '/TRG\s+\d+\.\d+/i' => 0.65,
                '/OPS\s+\d+\.\d+/i' => 0.65,
                '/SEC\s+\d+\.\d+/i' => 0.65,
            ],
            'filename_patterns' => [
                '/iosa/i' => 0.8,
                '/ism/i' => 0.7,
                '/operational.?safety/i' => 0.6,
            ],
            'keywords' => [
                'IOSA' => 0.8,
                'IATA' => 0.6,
                'operational safety audit' => 0.75,
                'standards manual' => 0.5,
            ],
        ],
        
        DocumentType::GACAR => [
            'title_patterns' => [
                '/GACAR|General.*Authority.*Civil.*Aviation/i' => 0.9,
                '/Kingdom.*Saudi.*Arabia.*Civil.*Aviation/i' => 0.85,
                '/General.*Authority.*Civil.*Aviation.*Regulations/i' => 0.9,
            ],
            'content_patterns' => [
                '/GACAR\s+Part\s+\d+/i' => 0.8,
                '/Part\s+\d+\s*[-–]\s*[A-Z]/i' => 0.6,
                '/General\s+Authority\s+of\s+Civil\s+Aviation/i' => 0.75,
                '/Kingdom\s+of\s+Saudi\s+Arabia/i' => 0.7,
                '/Civil\s+Aviation\s+Regulations/i' => 0.65,
            ],
            'filename_patterns' => [
                '/gacar/i' => 0.9,
                '/saudi/i' => 0.6,
                '/part.?\d+/i' => 0.5,
            ],
            'keywords' => [
                'GACAR' => 0.9,
                'General Authority' => 0.7,
                'Saudi Arabia' => 0.6,
                'Part 61' => 0.5,
                'Part 91' => 0.5,
                'Part 121' => 0.5,
                'Part 135' => 0.5,
            ],
        ],
        
        DocumentType::ECAR => [
            'title_patterns' => [
                '/ECAR|Egyptian.*Civil.*Aviation/i' => 0.9,
                '/Egyptian.*Civil.*Aviation.*Regulations/i' => 0.9,
                '/Arab.*Republic.*Egypt.*Civil.*Aviation/i' => 0.85,
            ],
            'content_patterns' => [
                '/ECAR\s+Part\s+[A-Z]/i' => 0.8,
                '/Egyptian\s+Civil\s+Aviation/i' => 0.75,
                '/Arab\s+Republic\s+of\s+Egypt/i' => 0.7,
                '/Ministry\s+of\s+Civil\s+Aviation/i' => 0.65,
            ],
            'filename_patterns' => [
                '/ecar/i' => 0.9,
                '/egyptian/i' => 0.7,
                '/egypt/i' => 0.6,
            ],
            'keywords' => [
                'ECAR' => 0.9,
                'Egyptian Civil Aviation' => 0.8,
                'Arab Republic of Egypt' => 0.6,
                'Part A' => 0.4,
                'Part B' => 0.4,
                'Part C' => 0.4,
            ],
        ],
        
        DocumentType::ICAO => [
            'title_patterns' => [
                '/ICAO|International.*Civil.*Aviation.*Organization/i' => 0.9,
                '/Annex\s+\d+.*ICAO/i' => 0.85,
                '/Doc\s+\d+.*ICAO/i' => 0.8,
            ],
            'content_patterns' => [
                '/ICAO\s+Annex\s+\d+/i' => 0.8,
                '/ICAO\s+Doc\s+\d+/i' => 0.75,
                '/International\s+Civil\s+Aviation\s+Organization/i' => 0.7,
                '/Standards\s+and\s+Recommended\s+Practices/i' => 0.65,
                '/SARPs/i' => 0.6,
            ],
            'filename_patterns' => [
                '/icao/i' => 0.9,
                '/annex/i' => 0.7,
                '/doc\s*\d+/i' => 0.6,
            ],
            'keywords' => [
                'ICAO' => 0.9,
                'International Civil Aviation Organization' => 0.8,
                'Annex' => 0.5,
                'SARPs' => 0.6,
                'Standards and Recommended Practices' => 0.6,
            ],
        ],
        
        DocumentType::FAA => [
            'title_patterns' => [
                '/FAA|Federal.*Aviation.*Administration/i' => 0.9,
                '/CFR.*Part\s+\d+/i' => 0.8,
                '/Federal.*Aviation.*Regulations/i' => 0.85,
            ],
            'content_patterns' => [
                '/FAA\s+Part\s+\d+/i' => 0.8,
                '/CFR\s+Part\s+\d+/i' => 0.75,
                '/Federal\s+Aviation\s+Administration/i' => 0.7,
                '/Code\s+of\s+Federal\s+Regulations/i' => 0.65,
                '/§\s*\d+\.\d+/i' => 0.6, // Section symbol
            ],
            'filename_patterns' => [
                '/faa/i' => 0.9,
                '/cfr/i' => 0.8,
                '/part\s*\d+/i' => 0.6,
                '/federal/i' => 0.5,
            ],
            'keywords' => [
                'FAA' => 0.9,
                'Federal Aviation Administration' => 0.8,
                'CFR' => 0.7,
                'Code of Federal Regulations' => 0.6,
            ],
        ],
        
        DocumentType::EASA => [
            'title_patterns' => [
                '/EASA|European.*Aviation.*Safety.*Agency/i' => 0.9,
                '/CS-\d+/i' => 0.8, // Certification Specifications
                '/AMC.*GM/i' => 0.7, // Acceptable Means of Compliance and Guidance Material
            ],
            'content_patterns' => [
                '/European\s+Aviation\s+Safety\s+Agency/i' => 0.8,
                '/CS-\d+/i' => 0.75,
                '/AMC\s+\d+/i' => 0.7,
                '/GM\s+\d+/i' => 0.7,
                '/Acceptable\s+Means\s+of\s+Compliance/i' => 0.65,
                '/Guidance\s+Material/i' => 0.6,
            ],
            'filename_patterns' => [
                '/easa/i' => 0.9,
                '/cs-\d+/i' => 0.8,
                '/amc/i' => 0.7,
                '/european/i' => 0.5,
            ],
            'keywords' => [
                'EASA' => 0.9,
                'European Aviation Safety Agency' => 0.8,
                'AMC' => 0.6,
                'Guidance Material' => 0.5,
                'Certification Specifications' => 0.6,
            ],
        ],
    ];

    public function classify(Content $content, string $fileName): ClassificationResult
    {
        $startTime = microtime(true);
        
        try {
            $scores = [];
            $evidence = [];
            
            foreach (self::CLASSIFICATION_PATTERNS as $type => $patterns) {
                $typeScore = $this->calculateTypeScore($content, $fileName, $patterns);
                $scores[$type] = $typeScore['score'];
                
                if ($typeScore['score'] > 0) {
                    $evidence[$type] = $typeScore['evidence'];
                }
            }
            
            // Find the best match
            arsort($scores);
            $bestType = array_key_first($scores);
            $bestScore = $scores[$bestType];
            
            $processingTime = (microtime(true) - $startTime) * 1000;
            
            $metadata = [
                'processing_time_ms' => $processingTime,
                'total_patterns_checked' => $this->countTotalPatterns(),
                'content_length' => strlen($content->getCleanedContent()),
                'filename' => basename($fileName),
            ];
            
            Log::info('Pattern-based classification completed', [
                'best_type' => $bestType,
                'confidence' => $bestScore,
                'all_scores' => $scores,
                'processing_time_ms' => $processingTime,
            ]);
            
            if ($bestScore >= self::CONFIDENCE_THRESHOLD) {
                return ClassificationResult::create(
                    documentType: DocumentType::fromString($bestType),
                    confidence: $bestScore,
                    classifierName: self::NAME,
                    allScores: $scores,
                    evidence: $evidence[$bestType] ?? [],
                    metadata: $metadata
                );
            } else {
                return ClassificationResult::unknown(self::NAME, $scores);
            }
            
        } catch (\Throwable $e) {
            Log::error('Pattern classification failed', [
                'error' => $e->getMessage(),
                'file_name' => $fileName,
            ]);
            
            return ClassificationResult::unknown(self::NAME, []);
        }
    }

    private function calculateTypeScore(Content $content, string $fileName, array $patterns): array
    {
        $totalScore = 0.0;
        $evidence = [];
        $text = $content->getCleanedContent();
        
        // Check title patterns
        foreach ($patterns['title_patterns'] ?? [] as $pattern => $weight) {
            if (preg_match($pattern, $text)) {
                $totalScore += $weight * 0.4; // Title patterns have 40% weight
                $evidence['title_matches'][] = [
                    'pattern' => $pattern,
                    'weight' => $weight,
                    'contribution' => $weight * 0.4,
                ];
            }
        }
        
        // Check content patterns
        foreach ($patterns['content_patterns'] ?? [] as $pattern => $weight) {
            $matches = preg_match_all($pattern, $text);
            if ($matches > 0) {
                $score = $weight * 0.3 * min(1.0, $matches / 3); // Diminishing returns for multiple matches
                $totalScore += $score;
                $evidence['content_matches'][] = [
                    'pattern' => $pattern,
                    'weight' => $weight,
                    'matches' => $matches,
                    'contribution' => $score,
                ];
            }
        }
        
        // Check filename patterns
        foreach ($patterns['filename_patterns'] ?? [] as $pattern => $weight) {
            if (preg_match($pattern, $fileName)) {
                $totalScore += $weight * 0.2; // Filename patterns have 20% weight
                $evidence['filename_matches'][] = [
                    'pattern' => $pattern,
                    'weight' => $weight,
                    'contribution' => $weight * 0.2,
                ];
            }
        }
        
        // Check keywords
        foreach ($patterns['keywords'] ?? [] as $keyword => $weight) {
            $keywordCount = substr_count(strtolower($text), strtolower($keyword));
            if ($keywordCount > 0) {
                $score = $weight * 0.1 * min(1.0, $keywordCount / 5); // Diminishing returns
                $totalScore += $score;
                $evidence['keyword_matches'][] = [
                    'keyword' => $keyword,
                    'weight' => $weight,
                    'count' => $keywordCount,
                    'contribution' => $score,
                ];
            }
        }
        
        // Normalize score to 0-1 range
        $normalizedScore = min(1.0, $totalScore);
        
        return [
            'score' => $normalizedScore,
            'evidence' => $evidence,
        ];
    }

    private function countTotalPatterns(): int
    {
        $total = 0;
        foreach (self::CLASSIFICATION_PATTERNS as $patterns) {
            $total += count($patterns['title_patterns'] ?? []);
            $total += count($patterns['content_patterns'] ?? []);
            $total += count($patterns['filename_patterns'] ?? []);
            $total += count($patterns['keywords'] ?? []);
        }
        return $total;
    }

    public function getName(): string
    {
        return self::NAME;
    }

    public function getConfidenceThreshold(): float
    {
        return self::CONFIDENCE_THRESHOLD;
    }

    public function getSupportedTypes(): array
    {
        return array_keys(self::CLASSIFICATION_PATTERNS);
    }
}