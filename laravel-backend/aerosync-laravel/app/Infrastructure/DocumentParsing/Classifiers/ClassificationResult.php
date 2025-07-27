<?php

namespace App\Infrastructure\DocumentParsing\Classifiers;

use App\Domain\DocumentParsing\ValueObjects\DocumentType;

/**
 * Classification Result DTO
 * Contains the results of document type classification
 */
final readonly class ClassificationResult
{
    public function __construct(
        private DocumentType $documentType,
        private float $confidence,
        private array $allScores = [],
        private string $classifierName = '',
        private array $evidence = [],
        private array $metadata = []
    ) {}

    public static function create(
        DocumentType $documentType,
        float $confidence,
        string $classifierName,
        array $allScores = [],
        array $evidence = [],
        array $metadata = []
    ): self {
        return new self(
            documentType: $documentType,
            confidence: $confidence,
            allScores: $allScores,
            classifierName: $classifierName,
            evidence: $evidence,
            metadata: $metadata
        );
    }

    public static function unknown(string $classifierName, array $allScores = []): self
    {
        return new self(
            documentType: DocumentType::unknown(),
            confidence: 0.0,
            allScores: $allScores,
            classifierName: $classifierName,
            evidence: ['reason' => 'No matching patterns found'],
            metadata: ['classification_failed' => true]
        );
    }

    public function getDocumentType(): DocumentType
    {
        return $this->documentType;
    }

    public function getConfidence(): float
    {
        return $this->confidence;
    }

    public function getAllScores(): array
    {
        return $this->allScores;
    }

    public function getClassifierName(): string
    {
        return $this->classifierName;
    }

    public function getEvidence(): array
    {
        return $this->evidence;
    }

    public function getMetadata(): array
    {
        return $this->metadata;
    }

    public function getScoreForType(string $type): float
    {
        return $this->allScores[$type] ?? 0.0;
    }

    public function isConfident(float $threshold = 0.8): bool
    {
        return $this->confidence >= $threshold;
    }

    public function isHighlyConfident(): bool
    {
        return $this->confidence >= 0.9;
    }

    public function hasAlternatives(): bool
    {
        if (empty($this->allScores)) {
            return false;
        }

        // Sort scores to find second highest
        $sortedScores = $this->allScores;
        arsort($sortedScores);
        $scores = array_values($sortedScores);

        // Check if there's a close second
        return count($scores) > 1 && ($scores[0] - $scores[1]) < 0.2;
    }

    public function getAlternativeTypes(): array
    {
        $alternatives = [];
        $threshold = max(0.3, $this->confidence - 0.3); // Within 30% of best score

        foreach ($this->allScores as $type => $score) {
            if ($type !== $this->documentType->getValue() && $score >= $threshold) {
                $alternatives[$type] = $score;
            }
        }

        arsort($alternatives);
        return $alternatives;
    }

    public function merge(ClassificationResult $other, float $weight = 0.5): self
    {
        // Merge scores with weighted average
        $mergedScores = [];
        $allTypes = array_unique(array_merge(
            array_keys($this->allScores),
            array_keys($other->allScores)
        ));

        foreach ($allTypes as $type) {
            $thisScore = $this->allScores[$type] ?? 0.0;
            $otherScore = $other->allScores[$type] ?? 0.0;
            $mergedScores[$type] = ($thisScore * (1 - $weight)) + ($otherScore * $weight);
        }

        // Find best type from merged scores
        arsort($mergedScores);
        $bestType = array_key_first($mergedScores);
        $bestScore = $mergedScores[$bestType];

        // Merge evidence and metadata
        $mergedEvidence = array_merge($this->evidence, $other->evidence);
        $mergedMetadata = array_merge($this->metadata, $other->metadata, [
            'merged_from' => [$this->classifierName, $other->classifierName],
            'merge_weight' => $weight,
        ]);

        return new self(
            documentType: DocumentType::fromString($bestType),
            confidence: $bestScore,
            allScores: $mergedScores,
            classifierName: "merged_{$this->classifierName}_{$other->classifierName}",
            evidence: $mergedEvidence,
            metadata: $mergedMetadata
        );
    }

    public function toArray(): array
    {
        return [
            'document_type' => $this->documentType->toArray(),
            'confidence' => $this->confidence,
            'all_scores' => $this->allScores,
            'classifier_name' => $this->classifierName,
            'evidence' => $this->evidence,
            'metadata' => $this->metadata,
            'is_confident' => $this->isConfident(),
            'has_alternatives' => $this->hasAlternatives(),
            'alternative_types' => $this->getAlternativeTypes(),
        ];
    }
}