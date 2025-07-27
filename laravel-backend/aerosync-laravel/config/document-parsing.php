<?php

return [
    
    /*
    |--------------------------------------------------------------------------
    | PDF Extraction Configuration
    |--------------------------------------------------------------------------
    |
    | Configuration for PDF text extraction methods and options
    |
    */
    
    'extraction' => [
        'methods' => [
            'spatie' => [
                'enabled' => true,
                'priority' => 80,
                'timeout_seconds' => 120,
                'max_file_size_mb' => 100,
                'binary_paths' => [
                    '/usr/bin/pdftotext',
                    '/usr/local/bin/pdftotext',
                    '/opt/homebrew/bin/pdftotext',
                    'pdftotext', // System PATH
                ],
            ],
            
            'poppler' => [
                'enabled' => env('POPPLER_ENABLED', false),
                'priority' => 85,
                'timeout_seconds' => 180,
                'max_file_size_mb' => 150,
                'binary_path' => env('POPPLER_PATH', '/usr/bin/pdftotext'),
                'options' => [
                    'layout' => true,
                    'raw' => false,
                    'encoding' => 'UTF-8',
                ],
            ],
            
            'ocr' => [
                'enabled' => env('OCR_ENABLED', false),
                'priority' => 70,
                'timeout_seconds' => 600,
                'max_file_size_mb' => 50,
                'languages' => ['eng', 'ara'],
                'tesseract_path' => env('TESSERACT_PATH', '/usr/bin/tesseract'),
                'temp_image_format' => 'png',
                'dpi' => 300,
            ],
            
            'hybrid' => [
                'enabled' => true,
                'priority' => 100,
                'selection_strategy' => 'best_quality',
                'quality_weights' => [
                    'quality_score' => 0.5,
                    'content_length' => 0.2,
                    'processing_speed' => 0.15,
                    'extractor_reliability' => 0.15,
                ],
            ],
        ],
        
        'default_options' => [
            'preserve_layout' => true,
            'extract_images' => false,
            'extract_metadata' => true,
            'use_ocr' => false,
            'ocr_languages' => ['eng'],
            'timeout_seconds' => 300,
            'max_memory_mb' => 512,
            'enable_quality_analysis' => true,
            'quality_threshold' => 0.7,
        ],
        
        'file_validation' => [
            'max_file_size_mb' => env('MAX_PDF_SIZE_MB', 50),
            'allowed_mime_types' => ['application/pdf'],
            'check_file_integrity' => true,
            'scan_for_malware' => false,
        ],
        
        'storage' => [
            'temp_directory' => storage_path('app/temp/pdf-processing'),
            'cleanup_after_hours' => 24,
            'enable_compression' => false,
        ],
    ],

    /*
    |--------------------------------------------------------------------------
    | Document Classification Configuration
    |--------------------------------------------------------------------------
    |
    | Settings for document type classification
    |
    */
    
    'classification' => [
        'confidence_threshold' => 0.7,
        'enable_ai_classification' => env('AI_CLASSIFICATION_ENABLED', false),
        'fallback_to_unknown' => true,
        'enable_pattern_caching' => true,
        
        'pattern_classifier' => [
            'enabled' => true,
            'priority' => 90,
            'pattern_weights' => [
                'title_patterns' => 0.4,
                'content_patterns' => 0.3,
                'filename_patterns' => 0.2,
                'keywords' => 0.1,
            ],
        ],
        
        'ai_classifier' => [
            'enabled' => env('AI_CLASSIFICATION_ENABLED', false),
            'priority' => 95,
            'provider' => env('AI_PROVIDER', 'openai'),
            'model' => env('AI_CLASSIFICATION_MODEL', 'gpt-3.5-turbo'),
            'max_tokens' => 1000,
            'temperature' => 0.1,
            'timeout_seconds' => 30,
        ],
        
        'supported_types' => [
            'iosa' => [
                'display_name' => 'IOSA Standards Manual',
                'full_name' => 'IATA Operational Safety Audit',
                'complexity_level' => 'high',
                'requires_special_handling' => true,
                'typical_sections' => ['ISM', 'ORG', 'FLT', 'DSP', 'MEX', 'TRG', 'OPS', 'SEC'],
            ],
            'gacar' => [
                'display_name' => 'GACAR Regulations',
                'full_name' => 'General Authority of Civil Aviation Regulations',
                'complexity_level' => 'high',
                'requires_special_handling' => true,
                'typical_sections' => ['Part 1', 'Part 61', 'Part 91', 'Part 121', 'Part 135'],
            ],
            'ecar' => [
                'display_name' => 'ECAR Standards',
                'full_name' => 'Egyptian Civil Aviation Regulations',
                'complexity_level' => 'medium',
                'requires_special_handling' => true,
                'typical_sections' => ['Part A', 'Part B', 'Part C'],
            ],
            'icao' => [
                'display_name' => 'ICAO Documents',
                'full_name' => 'International Civil Aviation Organization',
                'complexity_level' => 'medium',
                'requires_special_handling' => false,
                'typical_sections' => ['Annex', 'Doc', 'Chapter'],
            ],
            'faa' => [
                'display_name' => 'FAA Regulations',
                'full_name' => 'Federal Aviation Administration',
                'complexity_level' => 'medium',
                'requires_special_handling' => false,
                'typical_sections' => ['CFR', 'Part', 'Section'],
            ],
            'easa' => [
                'display_name' => 'EASA Standards',
                'full_name' => 'European Aviation Safety Agency',
                'complexity_level' => 'medium',
                'requires_special_handling' => false,
                'typical_sections' => ['Part', 'AMC', 'GM'],
            ],
        ],
    ],

    /*
    |--------------------------------------------------------------------------
    | Quality Assessment Configuration
    |--------------------------------------------------------------------------
    |
    | Settings for document and section quality assessment
    |
    */
    
    'quality' => [
        'thresholds' => [
            'minimum_overall_score' => 0.85,
            'minimum_text_quality' => 0.8,
            'minimum_structure_quality' => 0.7,
            'minimum_hierarchy_quality' => 0.75,
            'excellent_threshold' => 0.95,
            'good_threshold' => 0.85,
            'acceptable_threshold' => 0.70,
            'poor_threshold' => 0.50,
        ],
        
        'scoring_weights' => [
            'content_quality' => 0.4,
            'title_quality' => 0.2,
            'structure_quality' => 0.25,
            'completeness' => 0.15,
        ],
        
        'content_validation' => [
            'min_word_count' => 10,
            'max_word_count' => 100000,
            'min_character_count' => 50,
            'check_encoding_issues' => true,
            'check_extraction_artifacts' => true,
            'check_suspicious_patterns' => true,
        ],
        
        'enable_detailed_logging' => env('QUALITY_LOGGING_ENABLED', true),
    ],

    /*
    |--------------------------------------------------------------------------
    | Performance and Caching Configuration
    |--------------------------------------------------------------------------
    |
    | Settings for performance optimization and caching
    |
    */
    
    'performance' => [
        'caching' => [
            'enabled' => env('DOCUMENT_CACHING_ENABLED', true),
            'default_ttl_hours' => 24,
            'extraction_results_ttl_hours' => 6,
            'classification_results_ttl_hours' => 48,
            'quality_scores_ttl_hours' => 12,
            'cache_driver' => env('CACHE_DRIVER', 'redis'),
        ],
        
        'processing' => [
            'max_concurrent_jobs' => 5,
            'job_timeout_seconds' => 3600,
            'enable_queue' => env('QUEUE_ENABLED', true),
            'queue_connection' => env('QUEUE_CONNECTION', 'redis'),
            'queue_name' => 'document-processing',
            'max_retries' => 3,
            'retry_delay_seconds' => 60,
        ],
        
        'memory' => [
            'max_memory_mb' => 1024,
            'enable_memory_monitoring' => true,
            'cleanup_threshold_mb' => 800,
        ],
        
        'monitoring' => [
            'enable_metrics' => env('METRICS_ENABLED', false),
            'metrics_driver' => env('METRICS_DRIVER', 'prometheus'),
            'enable_performance_tracking' => true,
            'slow_query_threshold_ms' => 1000,
        ],
    ],

    /*
    |--------------------------------------------------------------------------
    | Logging Configuration
    |--------------------------------------------------------------------------
    |
    | Document processing specific logging settings
    |
    */
    
    'logging' => [
        'level' => env('LOG_LEVEL', 'info'),
        'channels' => ['single'],
        'enable_structured_logging' => true,
        'enable_performance_logging' => true,
        'enable_quality_logging' => true,
        'enable_extraction_logging' => true,
        'enable_classification_logging' => true,
        'log_file_retention_days' => 30,
        
        'contexts' => [
            'include_user_id' => true,
            'include_organization_id' => true,
            'include_request_id' => true,
            'include_processing_metadata' => true,
        ],
    ],

    /*
    |--------------------------------------------------------------------------
    | AI Integration Configuration
    |--------------------------------------------------------------------------
    |
    | Settings for AI-powered features
    |
    */
    
    'ai' => [
        'providers' => [
            'openai' => [
                'enabled' => env('OPENAI_ENABLED', false),
                'api_key' => env('OPENAI_API_KEY'),
                'organization' => env('OPENAI_ORGANIZATION'),
                'default_model' => 'gpt-3.5-turbo',
                'max_tokens' => 2000,
                'temperature' => 0.1,
                'timeout_seconds' => 60,
            ],
            
            'anthropic' => [
                'enabled' => env('ANTHROPIC_ENABLED', false),
                'api_key' => env('ANTHROPIC_API_KEY'),
                'default_model' => 'claude-3-sonnet-20240229',
                'max_tokens' => 2000,
                'timeout_seconds' => 60,
            ],
        ],
        
        'features' => [
            'document_classification' => env('AI_CLASSIFICATION_ENABLED', false),
            'content_enhancement' => env('AI_ENHANCEMENT_ENABLED', false),
            'section_summarization' => env('AI_SUMMARIZATION_ENABLED', false),
            'quality_assessment' => env('AI_QUALITY_ASSESSMENT_ENABLED', false),
        ],
        
        'cost_limits' => [
            'max_cost_per_document' => 5.0,
            'daily_cost_limit' => 100.0,
            'monthly_cost_limit' => 1000.0,
        ],
    ],

    /*
    |--------------------------------------------------------------------------
    | Security Configuration
    |--------------------------------------------------------------------------
    |
    | Security settings for document processing
    |
    */
    
    'security' => [
        'file_validation' => [
            'scan_uploads' => env('SCAN_UPLOADS', false),
            'max_file_size_mb' => 50,
            'allowed_extensions' => ['pdf'],
            'quarantine_suspicious_files' => true,
        ],
        
        'access_control' => [
            'require_authentication' => true,
            'require_organization_context' => false,
            'enable_rate_limiting' => true,
            'rate_limit_per_minute' => 60,
        ],
        
        'data_protection' => [
            'encrypt_stored_content' => false,
            'anonymize_logs' => true,
            'auto_delete_temp_files' => true,
            'temp_file_retention_hours' => 24,
        ],
    ],
];