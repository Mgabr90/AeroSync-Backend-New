<?php

namespace App\Domain\DocumentParsing\ValueObjects;

use InvalidArgumentException;

/**
 * Section Number Value Object
 * Represents the hierarchical numbering system used in aviation documents
 */
final readonly class SectionNumber
{
    public function __construct(
        private string $value,
        private array $hierarchy = []
    ) {
        if (empty(trim($value))) {
            throw new InvalidArgumentException('Section number cannot be empty');
        }

        $this->validateSectionNumber($value);
    }

    public static function fromString(string $value): self
    {
        $trimmed = trim($value);
        $hierarchy = self::parseHierarchy($trimmed);
        
        return new self($trimmed, $hierarchy);
    }

    public static function fromHierarchy(array $levels): self
    {
        if (empty($levels)) {
            throw new InvalidArgumentException('Hierarchy cannot be empty');
        }

        $value = implode('.', $levels);
        return new self($value, $levels);
    }

    private function validateSectionNumber(string $value): void
    {
        // Allow various common aviation document numbering patterns
        $patterns = [
            '/^\d+(\.\d+)*$/',                    // 1.2.3
            '/^[A-Z]+(\.\d+)*$/',                 // ISM.1.2
            '/^[A-Z]+\-\d+(\.\d+)*$/',           // ISM-1.2
            '/^\d+\.\d+\.[A-Z]+$/',              // 1.2.A
            '/^Part\s+\d+(\.\d+)*$/i',           // Part 61.1
            '/^Annex\s+\d+(\.\d+)*$/i',          // Annex 1.2
            '/^[A-Z]{2,}\s*\d+(\.\d+)*$/',       // ORG 1.2.3
        ];

        foreach ($patterns as $pattern) {
            if (preg_match($pattern, $value)) {
                return;
            }
        }

        throw new InvalidArgumentException("Invalid section number format: {$value}");
    }

    private static function parseHierarchy(string $value): array
    {
        // Handle different numbering patterns
        if (preg_match('/^([A-Z]+)[\-\s]*(.+)$/', $value, $matches)) {
            // ISM-1.2.3 or ISM 1.2.3
            $prefix = $matches[1];
            $numbers = explode('.', $matches[2]);
            return array_merge([$prefix], $numbers);
        }

        if (preg_match('/^(Part|Annex)\s+(.+)$/i', $value, $matches)) {
            // Part 61.1.2
            $type = $matches[1];
            $numbers = explode('.', $matches[2]);
            return array_merge([$type], $numbers);
        }

        // Default: split by dots
        return explode('.', $value);
    }

    public function getValue(): string
    {
        return $this->value;
    }

    public function getHierarchy(): array
    {
        return $this->hierarchy;
    }

    public function getDepth(): int
    {
        return count($this->hierarchy);
    }

    public function getLevel(int $level): ?string
    {
        return $this->hierarchy[$level] ?? null;
    }

    public function getPrefix(): ?string
    {
        if (empty($this->hierarchy)) {
            return null;
        }

        $first = $this->hierarchy[0];
        return preg_match('/^[A-Z]+$/', $first) ? $first : null;
    }

    public function hasPrefix(): bool
    {
        return $this->getPrefix() !== null;
    }

    public function isParentOf(SectionNumber $other): bool
    {
        if ($this->getDepth() >= $other->getDepth()) {
            return false;
        }

        $thisHierarchy = $this->hierarchy;
        $otherHierarchy = array_slice($other->hierarchy, 0, count($thisHierarchy));

        return $thisHierarchy === $otherHierarchy;
    }

    public function isChildOf(SectionNumber $other): bool
    {
        return $other->isParentOf($this);
    }

    public function isDirectChildOf(SectionNumber $other): bool
    {
        return $this->isChildOf($other) && ($this->getDepth() - $other->getDepth()) === 1;
    }

    public function isSiblingOf(SectionNumber $other): bool
    {
        if ($this->getDepth() !== $other->getDepth()) {
            return false;
        }

        if ($this->getDepth() <= 1) {
            return false;
        }

        $thisParent = array_slice($this->hierarchy, 0, -1);
        $otherParent = array_slice($other->hierarchy, 0, -1);

        return $thisParent === $otherParent;
    }

    public function getParent(): ?self
    {
        if ($this->getDepth() <= 1) {
            return null;
        }

        $parentHierarchy = array_slice($this->hierarchy, 0, -1);
        return self::fromHierarchy($parentHierarchy);
    }

    public function compare(SectionNumber $other): int
    {
        return $this->compareHierarchies($this->hierarchy, $other->hierarchy);
    }

    private function compareHierarchies(array $a, array $b): int
    {
        $minLength = min(count($a), count($b));

        for ($i = 0; $i < $minLength; $i++) {
            $comparison = $this->compareLevel($a[$i], $b[$i]);
            if ($comparison !== 0) {
                return $comparison;
            }
        }

        return count($a) <=> count($b);
    }

    private function compareLevel(string $a, string $b): int
    {
        // If both are numeric, compare as numbers
        if (is_numeric($a) && is_numeric($b)) {
            return (int)$a <=> (int)$b;
        }

        // Otherwise, compare as strings
        return strcmp($a, $b);
    }

    public function equals(SectionNumber $other): bool
    {
        return $this->value === $other->value;
    }

    public function toArray(): array
    {
        return [
            'value' => $this->value,
            'hierarchy' => $this->hierarchy,
            'depth' => $this->getDepth(),
            'prefix' => $this->getPrefix(),
        ];
    }

    public function __toString(): string
    {
        return $this->value;
    }
}