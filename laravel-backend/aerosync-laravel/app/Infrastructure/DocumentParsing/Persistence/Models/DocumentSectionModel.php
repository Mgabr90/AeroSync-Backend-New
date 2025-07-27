<?php

namespace App\Infrastructure\DocumentParsing\Persistence\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

/**
 * Document Section Eloquent Model
 * Maps to the existing 'document_sections' table in Supabase
 */
class DocumentSectionModel extends Model
{
    protected $table = 'document_sections';
    
    protected $keyType = 'string';
    public $incrementing = false;

    protected $fillable = [
        'id',
        'section_id',
        'section_name',
        'section_number',
        'parent_section_id',
        'full_text',
        'summary',
        'keywords',
        'vector_embedding',
        'category',
        'subcategory',
        'original_title',
        'level',
        'page_number',
        'order_index',
        'document_id',
        'confidence',
        'extraction_confidence',
        'quality_score',
        'extraction_method',
        'is_generated',
        'generated_reason',
        'generated_from',
        'generated_at',
        'hierarchy_level',
    ];

    protected $casts = [
        'id' => 'string',
        'document_id' => 'string',
        'parent_section_id' => 'string',
        'section_id' => 'integer',
        'level' => 'integer',
        'page_number' => 'integer',
        'order_index' => 'integer',
        'hierarchy_level' => 'integer',
        'confidence' => 'decimal:4',
        'extraction_confidence' => 'decimal:4',
        'quality_score' => 'decimal:4',
        'is_generated' => 'boolean',
        'keywords' => 'array',
        'created_at' => 'datetime',
        'updated_at' => 'datetime',
        'generated_at' => 'datetime',
    ];

    protected $dates = [
        'created_at',
        'updated_at',
        'generated_at',
    ];

    /**
     * Get the parent document
     */
    public function document(): BelongsTo
    {
        return $this->belongsTo(Document::class, 'document_id');
    }

    /**
     * Get the parent section
     */
    public function parentSection(): BelongsTo
    {
        return $this->belongsTo(self::class, 'parent_section_id');
    }

    /**
     * Get child sections
     */
    public function childSections(): HasMany
    {
        return $this->hasMany(self::class, 'parent_section_id')
            ->orderBy('order_index')
            ->orderBy('section_number');
    }

    /**
     * Scope to filter by document
     */
    public function scopeForDocument($query, string $documentId)
    {
        return $query->where('document_id', $documentId);
    }

    /**
     * Scope to filter by hierarchy level
     */
    public function scopeAtLevel($query, int $level)
    {
        return $query->where('hierarchy_level', $level);
    }

    /**
     * Scope to filter root sections (no parent)
     */
    public function scopeRootSections($query)
    {
        return $query->whereNull('parent_section_id')
            ->orWhere('hierarchy_level', 1);
    }

    /**
     * Scope to order by hierarchy
     */
    public function scopeOrderedByHierarchy($query)
    {
        return $query->orderBy('hierarchy_level')
            ->orderBy('order_index')
            ->orderBy('section_number');
    }

    /**
     * Scope to filter by quality threshold
     */
    public function scopeAboveQualityThreshold($query, float $threshold = 0.7)
    {
        return $query->where('quality_score', '>=', $threshold);
    }

    /**
     * Get section depth in hierarchy
     */
    public function getDepthAttribute(): int
    {
        return $this->hierarchy_level ?? 1;
    }

    /**
     * Check if section has children
     */
    public function getHasChildrenAttribute(): bool
    {
        return $this->childSections()->exists();
    }

    /**
     * Check if section is root level
     */
    public function getIsRootAttribute(): bool
    {
        return empty($this->parent_section_id) || $this->hierarchy_level === 1;
    }

    /**
     * Get word count from full text
     */
    public function getWordCountAttribute(): int
    {
        return str_word_count($this->full_text ?? '');
    }

    /**
     * Get character count from full text
     */
    public function getCharacterCountAttribute(): int
    {
        return strlen($this->full_text ?? '');
    }

    /**
     * Get quality level based on score
     */
    public function getQualityLevelAttribute(): string
    {
        if ($this->quality_score === null) {
            return 'unknown';
        }

        return match (true) {
            $this->quality_score >= 0.9 => 'excellent',
            $this->quality_score >= 0.8 => 'good',
            $this->quality_score >= 0.7 => 'acceptable',
            $this->quality_score >= 0.5 => 'poor',
            default => 'unacceptable'
        };
    }

    /**
     * Get content preview
     */
    public function getContentPreviewAttribute(): string
    {
        $text = $this->full_text ?? '';
        return strlen($text) > 200 ? substr($text, 0, 197) . '...' : $text;
    }

    /**
     * Check if section was AI generated
     */
    public function getIsAiGeneratedAttribute(): bool
    {
        return $this->is_generated || str_contains($this->generated_reason ?? '', 'ai');
    }

    /**
     * Get section hierarchy path
     */
    public function getHierarchyPathAttribute(): array
    {
        $path = [];
        $current = $this;
        
        while ($current && !$current->is_root) {
            array_unshift($path, [
                'id' => $current->id,
                'section_number' => $current->section_number,
                'section_name' => $current->section_name,
            ]);
            
            $current = $current->parentSection;
        }
        
        return $path;
    }

    /**
     * Boot method
     */
    protected static function boot()
    {
        parent::boot();

        // Auto-generate UUID if not provided
        static::creating(function ($model) {
            if (empty($model->id)) {
                $model->id = (string) \Illuminate\Support\Str::uuid();
            }
            
            // Set default hierarchy level
            if (empty($model->hierarchy_level)) {
                $model->hierarchy_level = 1;
            }
            
            // Set default extraction method
            if (empty($model->extraction_method)) {
                $model->extraction_method = 'hybrid_extractor';
            }
        });

        // Update timestamp on save
        static::saving(function ($model) {
            $model->updated_at = now();
        });
    }
}