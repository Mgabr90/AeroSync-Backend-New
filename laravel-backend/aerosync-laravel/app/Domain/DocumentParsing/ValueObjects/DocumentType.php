<?php

namespace App\Domain\DocumentParsing\ValueObjects;

use InvalidArgumentException;

/**
 * Document Type Value Object
 * Represents the type of aviation regulatory document being processed
 */
final readonly class DocumentType
{
    public const IOSA = 'iosa';
    public const GACAR = 'gacar';
    public const ECAR = 'ecar';
    public const ICAO = 'icao';
    public const FAA = 'faa';
    public const EASA = 'easa';
    public const UNKNOWN = 'unknown';

    private const VALID_TYPES = [
        self::IOSA,
        self::GACAR,
        self::ECAR,
        self::ICAO,
        self::FAA,
        self::EASA,
        self::UNKNOWN,
    ];

    private const TYPE_METADATA = [
        self::IOSA => [
            'display_name' => 'IOSA Standards Manual',
            'full_name' => 'IATA Operational Safety Audit',
            'requires_special_handling' => true,
            'complexity_level' => 'high',
            'typical_sections' => ['ISM', 'ORG', 'FLT', 'DSP', 'MEX', 'TRG', 'OPS', 'SEC']
        ],
        self::GACAR => [
            'display_name' => 'GACAR Regulations',
            'full_name' => 'General Authority of Civil Aviation Regulations',
            'requires_special_handling' => true,
            'complexity_level' => 'high',
            'typical_sections' => ['Part 1', 'Part 61', 'Part 91', 'Part 121', 'Part 135']
        ],
        self::ECAR => [
            'display_name' => 'ECAR Standards',
            'full_name' => 'Egyptian Civil Aviation Regulations',
            'requires_special_handling' => true,
            'complexity_level' => 'medium',
            'typical_sections' => ['Part A', 'Part B', 'Part C']
        ],
        self::ICAO => [
            'display_name' => 'ICAO Documents',
            'full_name' => 'International Civil Aviation Organization',
            'requires_special_handling' => false,
            'complexity_level' => 'medium',
            'typical_sections' => ['Annex', 'Doc', 'Chapter']
        ],
        self::FAA => [
            'display_name' => 'FAA Regulations',
            'full_name' => 'Federal Aviation Administration',
            'requires_special_handling' => false,
            'complexity_level' => 'medium',
            'typical_sections' => ['CFR', 'Part', 'Section']
        ],
        self::EASA => [
            'display_name' => 'EASA Standards',
            'full_name' => 'European Aviation Safety Agency',
            'requires_special_handling' => false,
            'complexity_level' => 'medium',
            'typical_sections' => ['Part', 'AMC', 'GM']
        ],
        self::UNKNOWN => [
            'display_name' => 'Unknown Document Type',
            'full_name' => 'Unidentified Aviation Document',
            'requires_special_handling' => false,
            'complexity_level' => 'low',
            'typical_sections' => []
        ],
    ];

    public function __construct(
        private string $value
    ) {
        if (!in_array($value, self::VALID_TYPES, true)) {
            throw new InvalidArgumentException("Invalid document type: {$value}");
        }
    }

    public static function iosa(): self
    {
        return new self(self::IOSA);
    }

    public static function gacar(): self
    {
        return new self(self::GACAR);
    }

    public static function ecar(): self
    {
        return new self(self::ECAR);
    }

    public static function icao(): self
    {
        return new self(self::ICAO);
    }

    public static function faa(): self
    {
        return new self(self::FAA);
    }

    public static function easa(): self
    {
        return new self(self::EASA);
    }

    public static function unknown(): self
    {
        return new self(self::UNKNOWN);
    }

    public static function fromString(string $value): self
    {
        return new self(strtolower(trim($value)));
    }

    public static function getAllTypes(): array
    {
        return self::VALID_TYPES;
    }

    public function getValue(): string
    {
        return $this->value;
    }

    public function getDisplayName(): string
    {
        return self::TYPE_METADATA[$this->value]['display_name'];
    }

    public function getFullName(): string
    {
        return self::TYPE_METADATA[$this->value]['full_name'];
    }

    public function getComplexityLevel(): string
    {
        return self::TYPE_METADATA[$this->value]['complexity_level'];
    }

    public function getTypicalSections(): array
    {
        return self::TYPE_METADATA[$this->value]['typical_sections'];
    }

    public function isIosa(): bool
    {
        return $this->value === self::IOSA;
    }

    public function isGacar(): bool
    {
        return $this->value === self::GACAR;
    }

    public function isEcar(): bool
    {
        return $this->value === self::ECAR;
    }

    public function isUnknown(): bool
    {
        return $this->value === self::UNKNOWN;
    }

    public function requiresSpecialHandling(): bool
    {
        return self::TYPE_METADATA[$this->value]['requires_special_handling'];
    }

    public function isHighComplexity(): bool
    {
        return $this->getComplexityLevel() === 'high';
    }

    public function equals(DocumentType $other): bool
    {
        return $this->value === $other->value;
    }

    public function toArray(): array
    {
        return [
            'value' => $this->value,
            'display_name' => $this->getDisplayName(),
            'full_name' => $this->getFullName(),
            'complexity_level' => $this->getComplexityLevel(),
            'requires_special_handling' => $this->requiresSpecialHandling(),
            'typical_sections' => $this->getTypicalSections(),
        ];
    }

    public function __toString(): string
    {
        return $this->value;
    }
}