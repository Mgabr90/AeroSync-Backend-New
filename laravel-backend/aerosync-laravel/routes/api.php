<?php

use App\Presentation\Controllers\DocumentProcessingController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

/*
|--------------------------------------------------------------------------
| Document Processing API Routes
|--------------------------------------------------------------------------
|
| RESTful API for aviation document processing with advanced PDF parsing
| and classification capabilities.
|
*/

Route::prefix('v1')->group(function () {
    
    // Health check endpoint
    Route::get('/health', function () {
        return response()->json([
            'success' => true,
            'message' => 'AeroSync Laravel Backend API',
            'version' => '1.0.0',
            'timestamp' => now()->toISOString(),
            'system' => [
                'php_version' => PHP_VERSION,
                'laravel_version' => app()->version(),
                'environment' => config('app.env'),
            ],
            'services' => [
                'pdf_extraction' => 'operational',
                'document_classification' => 'operational',
                'quality_assessment' => 'operational',
                'database' => 'operational',
            ],
        ]);
    });

    // Document processing endpoints
    Route::prefix('documents')->group(function () {
        
        // Process a new document
        Route::post('/process', [DocumentProcessingController::class, 'process'])
            ->name('documents.process');
        
        // Get document processing status
        Route::get('/{documentId}/status', [DocumentProcessingController::class, 'status'])
            ->name('documents.status')
            ->where('documentId', '[0-9a-f-]{36}'); // UUID pattern
        
        // Get document details
        Route::get('/{documentId}', [DocumentProcessingController::class, 'show'])
            ->name('documents.show')
            ->where('documentId', '[0-9a-f-]{36}');
        
        // List documents with filtering
        Route::get('/', [DocumentProcessingController::class, 'index'])
            ->name('documents.index');
        
        // Document sections (nested resource)
        Route::get('/{documentId}/sections', function (string $documentId) {
            return response()->json([
                'success' => true,
                'data' => [
                    'document_id' => $documentId,
                    'sections' => [],
                    'message' => 'Document sections endpoint not yet implemented',
                ],
            ]);
        })->name('documents.sections')
          ->where('documentId', '[0-9a-f-]{36}');
        
        // Get specific section
        Route::get('/{documentId}/sections/{sectionId}', function (string $documentId, string $sectionId) {
            return response()->json([
                'success' => true,
                'data' => [
                    'document_id' => $documentId,
                    'section_id' => $sectionId,
                    'message' => 'Document section detail endpoint not yet implemented',
                ],
            ]);
        })->name('documents.sections.show')
          ->where(['documentId' => '[0-9a-f-]{36}', 'sectionId' => '[0-9a-f-]{36}']);
    });

    // Document type management
    Route::prefix('document-types')->group(function () {
        
        // Get supported document types
        Route::get('/', function () {
            return response()->json([
                'success' => true,
                'data' => [
                    'supported_types' => [
                        [
                            'value' => 'iosa',
                            'display_name' => 'IOSA Standards Manual',
                            'full_name' => 'IATA Operational Safety Audit',
                            'complexity_level' => 'high',
                            'requires_special_handling' => true,
                        ],
                        [
                            'value' => 'gacar',
                            'display_name' => 'GACAR Regulations',
                            'full_name' => 'General Authority of Civil Aviation Regulations',
                            'complexity_level' => 'high',
                            'requires_special_handling' => true,
                        ],
                        [
                            'value' => 'ecar',
                            'display_name' => 'ECAR Standards',
                            'full_name' => 'Egyptian Civil Aviation Regulations',
                            'complexity_level' => 'medium',
                            'requires_special_handling' => true,
                        ],
                        [
                            'value' => 'icao',
                            'display_name' => 'ICAO Documents',
                            'full_name' => 'International Civil Aviation Organization',
                            'complexity_level' => 'medium',
                            'requires_special_handling' => false,
                        ],
                        [
                            'value' => 'faa',
                            'display_name' => 'FAA Regulations',
                            'full_name' => 'Federal Aviation Administration',
                            'complexity_level' => 'medium',
                            'requires_special_handling' => false,
                        ],
                        [
                            'value' => 'easa',
                            'display_name' => 'EASA Standards',
                            'full_name' => 'European Aviation Safety Agency',
                            'complexity_level' => 'medium',
                            'requires_special_handling' => false,
                        ],
                    ],
                ],
            ]);
        })->name('document-types.index');
        
        // Classify document type from content
        Route::post('/classify', function (Request $request) {
            // This would use the classification service
            return response()->json([
                'success' => true,
                'data' => [
                    'message' => 'Document type classification endpoint not yet implemented',
                ],
            ]);
        })->name('document-types.classify');
    });

    // System information and statistics
    Route::prefix('system')->group(function () {
        
        // Get processing statistics
        Route::get('/stats', function () {
            return response()->json([
                'success' => true,
                'data' => [
                    'documents_processed' => 0,
                    'success_rate' => 0.0,
                    'average_processing_time_ms' => 0.0,
                    'supported_extractors' => [
                        'spatie_text',
                        'hybrid',
                    ],
                    'supported_classifiers' => [
                        'pattern_based',
                    ],
                    'message' => 'System statistics endpoint not yet implemented',
                ],
            ]);
        })->name('system.stats');
        
        // Get available extractors and their capabilities
        Route::get('/extractors', function () {
            return response()->json([
                'success' => true,
                'data' => [
                    'extractors' => [
                        [
                            'name' => 'spatie_text',
                            'priority' => 80,
                            'supported_features' => [
                                'fast_extraction',
                                'basic_layout_preservation',
                                'encoding_detection',
                            ],
                        ],
                        [
                            'name' => 'hybrid',
                            'priority' => 100,
                            'supported_features' => [
                                'multi_method_extraction',
                                'quality_comparison',
                                'automatic_fallback',
                                'best_result_selection',
                            ],
                        ],
                    ],
                ],
            ]);
        })->name('system.extractors');
    });
});

/*
|--------------------------------------------------------------------------
| Legacy API Compatibility Routes
|--------------------------------------------------------------------------
|
| These routes provide compatibility with the existing Node.js API
| to ensure seamless migration.
|
*/

Route::prefix('api')->group(function () {
    
    // Health check (compatible with Node.js version)
    Route::get('/health', function () {
        return response()->json([
            'success' => true,
            'message' => 'AeroSync Backend API',
            'version' => '3.0.0-laravel',
            'timestamp' => now()->toISOString(),
            'endpoints' => [
                '/api/v1/health',
                '/api/v1/documents/process',
                '/api/v1/documents/{id}/status',
                '/api/v1/documents',
                '/api/v1/document-types',
            ],
            'services' => [
                'total' => 4,
                'status' => 'operational',
            ],
        ]);
    });

    // Enhanced jobs compatibility endpoint
    Route::any('/enhanced-jobs', function (Request $request) {
        $action = $request->query('action', $request->input('action'));
        
        return match ($action) {
            'upload', 'process', 'ai-process' => response()->json([
                'success' => false,
                'error' => 'Legacy endpoint - use /api/v1/documents/process instead',
                'redirect_to' => '/api/v1/documents/process',
            ], 301),
            
            'status' => response()->json([
                'success' => false,
                'error' => 'Legacy endpoint - use /api/v1/documents/{id}/status instead',
                'redirect_to' => '/api/v1/documents/{id}/status',
            ], 301),
            
            default => response()->json([
                'success' => false,
                'error' => 'Unknown action or legacy endpoint',
                'available_endpoints' => [
                    '/api/v1/documents/process',
                    '/api/v1/documents/{id}/status',
                    '/api/v1/documents',
                ],
            ], 400)
        };
    });
});

/*
|--------------------------------------------------------------------------
| Error Handling Routes
|--------------------------------------------------------------------------
|
| Catch-all routes for proper error responses
|
*/

// API 404 handler
Route::fallback(function () {
    return response()->json([
        'success' => false,
        'error' => 'API endpoint not found',
        'message' => 'The requested API endpoint does not exist',
        'available_endpoints' => [
            'GET /api/v1/health',
            'POST /api/v1/documents/process',
            'GET /api/v1/documents/{id}/status',
            'GET /api/v1/documents/{id}',
            'GET /api/v1/documents',
            'GET /api/v1/document-types',
            'GET /api/v1/system/stats',
        ],
    ], 404);
});