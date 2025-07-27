<?php

namespace App\Infrastructure\DocumentParsing\Persistence\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\SoftDeletes;

/**
 * Document Eloquent Model
 * Maps to the existing 'documents' table in Supabase
 */
class Document extends Model
{
    use SoftDeletes;

    protected $table = 'documents';
    
    protected $keyType = 'string';
    public $incrementing = false;

    protected $fillable = [
        'id',
        'title',
        'description',
        'document_type',
        'status',
        'category_id',
        'file_url',
        'file_type',
        'parsed_content',
        'metadata',
        'created_by',
        'organization_id',
        'authority_id',
        'user_id',
        'document_name',
        'version',
        'filename',
        'file_size',
        'manual_type',
        'effective_date',
        'parser_type',
        'volume_path',
    ];

    protected $casts = [
        'id' => 'string',
        'metadata' => 'array',
        'created_at' => 'datetime',
        'updated_at' => 'datetime',
        'deleted_at' => 'datetime',
        'effective_date' => 'datetime',
        'is_deleted' => 'boolean',
        'file_size' => 'integer',
    ];

    protected $dates = [
        'created_at',
        'updated_at',
        'deleted_at',
        'effective_date',
    ];

    // Use the existing soft delete column name
    const DELETED_AT = 'deleted_at';

    /**
     * Get the document sections
     */
    public function sections(): HasMany
    {
        return $this->hasMany(DocumentSectionModel::class, 'document_id');
    }

    /**
     * Get document sections ordered by hierarchy
     */
    public function sectionsOrdered(): HasMany
    {
        return $this->sections()
            ->orderBy('hierarchy_level')
            ->orderBy('order_index')
            ->orderBy('section_number');
    }

    /**
     * Scope to filter by document type
     */
    public function scopeOfType($query, string $type)
    {
        return $query->where('document_type', $type);
    }

    /**
     * Scope to filter by status
     */
    public function scopeWithStatus($query, string $status)
    {
        return $query->where('status', $status);
    }

    /**
     * Scope to filter by organization
     */
    public function scopeForOrganization($query, string $organizationId)
    {
        return $query->where('organization_id', $organizationId);
    }

    /**
     * Scope to exclude deleted documents
     */
    public function scopeNotDeleted($query)
    {
        return $query->where('is_deleted', false);
    }

    /**
     * Get the document type display name
     */
    public function getTypeDisplayNameAttribute(): string
    {
        return match ($this->document_type) {
            'iosa' => 'IOSA Standards Manual',
            'gacar' => 'GACAR Regulations',
            'ecar' => 'ECAR Standards',
            'icao' => 'ICAO Documents',
            'faa' => 'FAA Regulations',
            'easa' => 'EASA Standards',
            default => 'Unknown Document Type'
        };
    }

    /**
     * Get the processing metadata
     */
    public function getProcessingMetadataAttribute(): array
    {
        return $this->metadata['processing_metadata'] ?? [];
    }

    /**
     * Get the overall quality score
     */
    public function getOverallQualityScoreAttribute(): ?float
    {
        return $this->metadata['overall_quality_score'] ?? null;
    }

    /**
     * Check if document is processed
     */
    public function getIsProcessedAttribute(): bool
    {
        return in_array($this->status, ['published', 'completed']);
    }

    /**
     * Get file size in human readable format
     */
    public function getFileSizeHumanAttribute(): string
    {
        if (!$this->file_size) {
            return 'Unknown';
        }

        $bytes = $this->file_size;
        $units = ['B', 'KB', 'MB', 'GB'];
        
        for ($i = 0; $bytes > 1024 && $i < count($units) - 1; $i++) {
            $bytes /= 1024;
        }
        
        return round($bytes, 2) . ' ' . $units[$i];
    }

    /**
     * Get sections count
     */
    public function getSectionsCountAttribute(): int
    {
        return $this->sections()->count();
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
            
            // Set default values
            if (empty($model->status)) {
                $model->status = 'draft';
            }
            
            if (empty($model->parser_type)) {
                $model->parser_type = 'unified';
            }
            
            if (empty($model->version)) {
                $model->version = '1.0';
            }
        });

        // Update timestamp on save
        static::saving(function ($model) {
            $model->updated_at = now();
        });
    }
}