<?php

namespace App\Domain\DocumentParsing\ValueObjects;

use InvalidArgumentException;

/**
 * Processing Status Value Object
 * Represents the current state of document processing
 */
final readonly class ProcessingStatus
{
    public const PENDING = 'pending';
    public const PROCESSING = 'processing';
    public const COMPLETED = 'completed';
    public const FAILED = 'failed';
    public const CANCELLED = 'cancelled';

    private const VALID_STATUSES = [
        self::PENDING,
        self::PROCESSING,
        self::COMPLETED,
        self::FAILED,
        self::CANCELLED,
    ];

    private const STATUS_TRANSITIONS = [
        self::PENDING => [self::PROCESSING, self::CANCELLED],
        self::PROCESSING => [self::COMPLETED, self::FAILED, self::CANCELLED],
        self::COMPLETED => [self::PENDING], // Allow reprocessing
        self::FAILED => [self::PENDING], // Allow retry
        self::CANCELLED => [self::PENDING], // Allow restart
    ];

    public function __construct(
        private string $value
    ) {
        if (!in_array($value, self::VALID_STATUSES, true)) {
            throw new InvalidArgumentException("Invalid processing status: {$value}");
        }
    }

    public static function pending(): self
    {
        return new self(self::PENDING);
    }

    public static function processing(): self
    {
        return new self(self::PROCESSING);
    }

    public static function completed(): self
    {
        return new self(self::COMPLETED);
    }

    public static function failed(): self
    {
        return new self(self::FAILED);
    }

    public static function cancelled(): self
    {
        return new self(self::CANCELLED);
    }

    public static function fromString(string $value): self
    {
        return new self(strtolower(trim($value)));
    }

    public function getValue(): string
    {
        return $this->value;
    }

    public function isPending(): bool
    {
        return $this->value === self::PENDING;
    }

    public function isProcessing(): bool
    {
        return $this->value === self::PROCESSING;
    }

    public function isCompleted(): bool
    {
        return $this->value === self::COMPLETED;
    }

    public function isFailed(): bool
    {
        return $this->value === self::FAILED;
    }

    public function isCancelled(): bool
    {
        return $this->value === self::CANCELLED;
    }

    public function isFinished(): bool
    {
        return in_array($this->value, [self::COMPLETED, self::FAILED, self::CANCELLED], true);
    }

    public function canTransitionTo(ProcessingStatus $newStatus): bool
    {
        $allowedTransitions = self::STATUS_TRANSITIONS[$this->value] ?? [];
        return in_array($newStatus->value, $allowedTransitions, true);
    }

    public function getDisplayName(): string
    {
        return match ($this->value) {
            self::PENDING => 'Pending',
            self::PROCESSING => 'Processing',
            self::COMPLETED => 'Completed',
            self::FAILED => 'Failed',
            self::CANCELLED => 'Cancelled',
        };
    }

    public function getDescription(): string
    {
        return match ($this->value) {
            self::PENDING => 'Document is queued for processing',
            self::PROCESSING => 'Document is currently being processed',
            self::COMPLETED => 'Document processing completed successfully',
            self::FAILED => 'Document processing failed',
            self::CANCELLED => 'Document processing was cancelled',
        };
    }

    public function getColor(): string
    {
        return match ($this->value) {
            self::PENDING => 'yellow',
            self::PROCESSING => 'blue',
            self::COMPLETED => 'green',
            self::FAILED => 'red',
            self::CANCELLED => 'gray',
        };
    }

    public function equals(ProcessingStatus $other): bool
    {
        return $this->value === $other->value;
    }

    public function toArray(): array
    {
        return [
            'value' => $this->value,
            'display_name' => $this->getDisplayName(),
            'description' => $this->getDescription(),
            'color' => $this->getColor(),
            'is_finished' => $this->isFinished(),
        ];
    }

    public function __toString(): string
    {
        return $this->value;
    }
}