<?php

namespace App\Domain\DocumentParsing\ValueObjects;

use InvalidArgumentException;

/**
 * Quality Score Value Object
 * Represents the quality assessment score for PDF parsing results
 */
final readonly class QualityScore
{
    private const MIN_SCORE = 0.0;
    private const MAX_SCORE = 1.0;
    private const EXCELLENT_THRESHOLD = 0.95;
    private const GOOD_THRESHOLD = 0.85;
    private const ACCEPTABLE_THRESHOLD = 0.70;
    private const POOR_THRESHOLD = 0.50;

    public function __construct(
        private float $value
    ) {
        if ($value < self::MIN_SCORE || $value > self::MAX_SCORE) {
            throw new InvalidArgumentException(
                "Quality score must be between " . self::MIN_SCORE . " and " . self::MAX_SCORE . ", got: {$value}"
            );
        }
    }

    public static function fromPercentage(float $percentage): self
    {
        return new self($percentage / 100);
    }

    public static function excellent(): self
    {
        return new self(self::EXCELLENT_THRESHOLD);
    }

    public static function good(): self
    {
        return new self(self::GOOD_THRESHOLD);
    }

    public static function acceptable(): self
    {
        return new self(self::ACCEPTABLE_THRESHOLD);
    }

    public static function poor(): self
    {
        return new self(self::POOR_THRESHOLD);
    }

    public static function zero(): self
    {
        return new self(0.0);
    }

    public static function perfect(): self
    {
        return new self(1.0);
    }

    public function getValue(): float
    {
        return $this->value;
    }

    public function getPercentage(): float
    {
        return $this->value * 100;
    }

    public function getRoundedPercentage(): int
    {
        return (int) round($this->getPercentage());
    }

    public function isExcellent(): bool
    {
        return $this->value >= self::EXCELLENT_THRESHOLD;
    }

    public function isGood(): bool
    {
        return $this->value >= self::GOOD_THRESHOLD && $this->value < self::EXCELLENT_THRESHOLD;
    }

    public function isAcceptable(): bool
    {
        return $this->value >= self::ACCEPTABLE_THRESHOLD && $this->value < self::GOOD_THRESHOLD;
    }

    public function isPoor(): bool
    {
        return $this->value >= self::POOR_THRESHOLD && $this->value < self::ACCEPTABLE_THRESHOLD;
    }

    public function isUnacceptable(): bool
    {
        return $this->value < self::POOR_THRESHOLD;
    }

    public function getQualityLevel(): string
    {
        return match (true) {
            $this->isExcellent() => 'excellent',
            $this->isGood() => 'good',
            $this->isAcceptable() => 'acceptable',
            $this->isPoor() => 'poor',
            default => 'unacceptable'
        };
    }

    public function getQualityDescription(): string
    {
        return match (true) {
            $this->isExcellent() => 'Excellent quality - minimal manual review needed',
            $this->isGood() => 'Good quality - minor manual review recommended',
            $this->isAcceptable() => 'Acceptable quality - moderate manual review required',
            $this->isPoor() => 'Poor quality - significant manual review required',
            default => 'Unacceptable quality - complete manual review necessary'
        };
    }

    public function passesThreshold(QualityScore $threshold): bool
    {
        return $this->value >= $threshold->value;
    }

    public function isGreaterThan(QualityScore $other): bool
    {
        return $this->value > $other->value;
    }

    public function isLessThan(QualityScore $other): bool
    {
        return $this->value < $other->value;
    }

    public function equals(QualityScore $other): bool
    {
        return abs($this->value - $other->value) < 0.001; // Allow for floating point precision
    }

    public function add(QualityScore $other): self
    {
        return new self(min(self::MAX_SCORE, $this->value + $other->value));
    }

    public function subtract(QualityScore $other): self
    {
        return new self(max(self::MIN_SCORE, $this->value - $other->value));
    }

    public function multiply(float $factor): self
    {
        return new self(max(self::MIN_SCORE, min(self::MAX_SCORE, $this->value * $factor)));
    }

    public function average(QualityScore ...$scores): self
    {
        if (empty($scores)) {
            return $this;
        }

        $sum = $this->value;
        $count = 1;

        foreach ($scores as $score) {
            $sum += $score->value;
            $count++;
        }

        return new self($sum / $count);
    }

    public function toArray(): array
    {
        return [
            'value' => $this->value,
            'percentage' => $this->getPercentage(),
            'level' => $this->getQualityLevel(),
            'description' => $this->getQualityDescription(),
        ];
    }

    public function __toString(): string
    {
        return number_format($this->getPercentage(), 1) . '%';
    }
}