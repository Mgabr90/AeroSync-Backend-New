<?php

namespace App\Providers;

use App\Domain\DocumentParsing\Repositories\DocumentRepository;
use App\Infrastructure\DocumentParsing\Persistence\EloquentDocumentRepository;
use App\Infrastructure\DocumentParsing\Extractors\PdfExtractor;
use App\Infrastructure\DocumentParsing\Extractors\SpatieTextExtractor;
use App\Infrastructure\DocumentParsing\Extractors\HybridPdfExtractor;
use App\Infrastructure\DocumentParsing\Classifiers\DocumentClassifier;
use App\Infrastructure\DocumentParsing\Classifiers\PatternBasedClassifier;
use Illuminate\Support\ServiceProvider;
use Illuminate\Contracts\Foundation\Application;

/**
 * Document Parsing Service Provider
 * Binds document parsing related services to the Laravel service container
 */
class DocumentParsingServiceProvider extends ServiceProvider
{
    /**
     * Register services.
     */
    public function register(): void
    {
        // Bind repository implementation
        $this->app->bind(DocumentRepository::class, EloquentDocumentRepository::class);

        // Bind PDF extractors
        $this->app->bind(SpatieTextExtractor::class, function (Application $app) {
            return new SpatieTextExtractor();
        });

        $this->app->bind(HybridPdfExtractor::class, function (Application $app) {
            return new HybridPdfExtractor(
                spatieExtractor: $app->make(SpatieTextExtractor::class),
                // Additional extractors would be injected here when implemented
                popplerExtractor: null,
                ocrExtractor: null
            );
        });

        // Bind the main PDF extractor interface to hybrid extractor
        $this->app->bind(PdfExtractor::class, HybridPdfExtractor::class);

        // Bind document classifier
        $this->app->bind(DocumentClassifier::class, PatternBasedClassifier::class);
        $this->app->bind(PatternBasedClassifier::class, function (Application $app) {
            return new PatternBasedClassifier();
        });

        // Register configuration
        $this->registerConfiguration();
    }

    /**
     * Bootstrap services.
     */
    public function boot(): void
    {
        // Publish configuration files if running as a package
        if ($this->app->runningInConsole()) {
            $this->publishes([
                __DIR__.'/../../config/document-parsing.php' => config_path('document-parsing.php'),
            ], 'document-parsing-config');
        }
    }

    /**
     * Register configuration for document parsing
     */
    private function registerConfiguration(): void
    {
        // Register default configuration
        $this->app->singleton('document-parsing.config', function () {
            return [
                'extraction' => [
                    'default_timeout_seconds' => 300,
                    'max_file_size_mb' => 50,
                    'supported_mime_types' => ['application/pdf'],
                    'temp_storage_path' => storage_path('app/temp/pdf-processing'),
                    'cleanup_after_processing' => true,
                ],
                
                'classification' => [
                    'confidence_threshold' => 0.7,
                    'enable_ai_classification' => false,
                    'fallback_to_unknown' => true,
                ],
                
                'quality' => [
                    'minimum_score' => 0.85,
                    'enable_quality_checks' => true,
                    'quality_weights' => [
                        'content_quality' => 0.4,
                        'title_quality' => 0.2,
                        'structure_quality' => 0.25,
                        'completeness' => 0.15,
                    ],
                ],
                
                'performance' => [
                    'enable_caching' => true,
                    'cache_ttl_hours' => 24,
                    'max_concurrent_jobs' => 5,
                    'enable_queue' => true,
                ],
                
                'logging' => [
                    'level' => 'info',
                    'channels' => ['single'],
                    'enable_performance_logging' => true,
                    'enable_quality_logging' => true,
                ],
            ];
        });
    }

    /**
     * Get the services provided by the provider.
     */
    public function provides(): array
    {
        return [
            DocumentRepository::class,
            PdfExtractor::class,
            SpatieTextExtractor::class,
            HybridPdfExtractor::class,
            DocumentClassifier::class,
            PatternBasedClassifier::class,
            'document-parsing.config',
        ];
    }
}