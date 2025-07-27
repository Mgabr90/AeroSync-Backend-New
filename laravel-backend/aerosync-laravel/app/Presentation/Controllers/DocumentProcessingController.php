<?php

namespace App\Presentation\Controllers;

use App\Application\DocumentParsing\Commands\ProcessDocumentCommand;
use App\Application\DocumentParsing\UseCases\ProcessRegulatoryDocument;
use App\Domain\DocumentParsing\ValueObjects\DocumentType;
use App\Infrastructure\DocumentParsing\DTOs\ExtractionOptions;
use App\Infrastructure\DocumentParsing\Exceptions\DocumentProcessingException;
use App\Infrastructure\DocumentParsing\Exceptions\ExtractionException;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;
use Illuminate\Validation\Rule;

/**
 * Document Processing Controller
 * RESTful API for document processing operations
 */
class DocumentProcessingController
{
    public function __construct(
        private ProcessRegulatoryDocument $processDocumentUseCase
    ) {}

    /**
     * Upload and process a document
     * 
     * @param Request $request
     * @return JsonResponse
     */
    public function process(Request $request): JsonResponse
    {
        try {
            // Validate request
            $validated = $request->validate([
                'file' => 'required|file|mimes:pdf|max:51200', // 50MB max
                'document_type' => ['nullable', Rule::in(DocumentType::getAllTypes())],
                'organization_id' => 'nullable|uuid',
                'use_ai' => 'boolean',
                'skip_classification' => 'boolean',
                'quality_threshold' => 'numeric|min:0|max:1',
                'extraction_options' => 'array',
                'extraction_options.use_ocr' => 'boolean',
                'extraction_options.ocr_languages' => 'array',
                'extraction_options.preserve_layout' => 'boolean',
                'extraction_options.timeout_seconds' => 'integer|min:30|max:600',
            ]);

            /** @var UploadedFile $file */
            $file = $request->file('file');
            
            // Store the uploaded file
            $filePath = $this->storeUploadedFile($file);
            
            // Generate document ID
            $documentId = (string) Str::uuid();
            
            // Create extraction options
            $extractionOptions = $this->createExtractionOptions($validated['extraction_options'] ?? []);
            
            // Create processing command
            $command = ProcessDocumentCommand::create(
                documentId: $documentId,
                filePath: $filePath,
                fileName: $file->getClientOriginalName()
            )
            ->withExtractionOptions($extractionOptions)
            ->withProcessingOptions([
                'use_ai' => $validated['use_ai'] ?? false,
                'skip_classification' => $validated['skip_classification'] ?? false,
                'quality_threshold' => $validated['quality_threshold'] ?? 0.85,
            ])
            ->withUserContext(
                userId: $request->user()?->id ?? 'anonymous',
                organizationId: $validated['organization_id'] ?? null
            );

            // Add expected type if provided
            if (!empty($validated['document_type'])) {
                $command = $command->withProcessingOptions([
                    'expected_type' => DocumentType::fromString($validated['document_type']),
                ]);
            }

            Log::info('Starting document processing', [
                'document_id' => $documentId,
                'filename' => $file->getClientOriginalName(),
                'file_size' => $file->getSize(),
                'user_id' => $request->user()?->id,
                'organization_id' => $validated['organization_id'] ?? null,
            ]);

            // Process the document
            $result = $this->processDocumentUseCase->execute($command);

            if ($result->isSuccessful()) {
                // Clean up temporary file
                $this->cleanupTemporaryFile($filePath);

                return response()->json([
                    'success' => true,
                    'data' => [
                        'document_id' => $result->getDocument()->getId(),
                        'document_type' => $result->getDocument()->getType()->toArray(),
                        'status' => $result->getDocument()->getStatus()->toArray(),
                        'sections_count' => $result->getDocument()->getSections()->count(),
                        'quality_score' => $result->getDocument()->getOverallQualityScore()?->toArray(),
                        'processing_time_ms' => $result->getProcessingTimeMs(),
                        'extraction_result' => [
                            'extractor_used' => $result->getExtractionResult()?->getExtractorName(),
                            'extraction_quality' => $result->getExtractionResult()?->getQualityScore()->toArray(),
                        ],
                    ],
                    'message' => 'Document processed successfully',
                ], 201);
            } else {
                // Clean up temporary file
                $this->cleanupTemporaryFile($filePath);

                return response()->json([
                    'success' => false,
                    'error' => 'Document processing failed',
                    'details' => $result->getErrorMessage(),
                    'processing_time_ms' => $result->getProcessingTimeMs(),
                ], 422);
            }

        } catch (DocumentProcessingException $e) {
            Log::error('Document processing exception', $e->toLogContext());

            return response()->json([
                'success' => false,
                'error' => 'Document processing failed',
                'details' => $e->getMessage(),
                'phase' => $e->getPhase(),
                'document_id' => $e->getDocumentId(),
            ], 422);

        } catch (ExtractionException $e) {
            Log::error('PDF extraction failed', [
                'error' => $e->getMessage(),
                'file_path' => $e->getFilePath(),
                'extractor' => $e->getExtractorName(),
            ]);

            return response()->json([
                'success' => false,
                'error' => 'PDF extraction failed',
                'details' => $e->getMessage(),
            ], 422);

        } catch (\Throwable $e) {
            Log::error('Unexpected error during document processing', [
                'error' => $e->getMessage(),
                'file' => $e->getFile(),
                'line' => $e->getLine(),
                'trace' => $e->getTraceAsString(),
            ]);

            return response()->json([
                'success' => false,
                'error' => 'Internal server error',
                'details' => 'An unexpected error occurred during processing',
            ], 500);
        }
    }

    /**
     * Get document processing status
     * 
     * @param string $documentId
     * @return JsonResponse
     */
    public function status(string $documentId): JsonResponse
    {
        try {
            // This would typically use a query use case
            // For now, we'll implement a simple status check
            
            return response()->json([
                'success' => true,
                'data' => [
                    'document_id' => $documentId,
                    'status' => 'completed', // Placeholder
                    'message' => 'Status check not yet implemented',
                ],
            ]);

        } catch (\Throwable $e) {
            Log::error('Error checking document status', [
                'document_id' => $documentId,
                'error' => $e->getMessage(),
            ]);

            return response()->json([
                'success' => false,
                'error' => 'Failed to check document status',
                'details' => $e->getMessage(),
            ], 500);
        }
    }

    /**
     * Get document details
     * 
     * @param string $documentId
     * @return JsonResponse
     */
    public function show(string $documentId): JsonResponse
    {
        try {
            // This would use a query use case to get document details
            
            return response()->json([
                'success' => true,
                'data' => [
                    'document_id' => $documentId,
                    'message' => 'Document details endpoint not yet implemented',
                ],
            ]);

        } catch (\Throwable $e) {
            Log::error('Error retrieving document', [
                'document_id' => $documentId,
                'error' => $e->getMessage(),
            ]);

            return response()->json([
                'success' => false,
                'error' => 'Failed to retrieve document',
                'details' => $e->getMessage(),
            ], 500);
        }
    }

    /**
     * List documents with filtering
     * 
     * @param Request $request
     * @return JsonResponse
     */
    public function index(Request $request): JsonResponse
    {
        try {
            $validated = $request->validate([
                'page' => 'integer|min:1',
                'per_page' => 'integer|min:1|max:100',
                'document_type' => ['nullable', Rule::in(DocumentType::getAllTypes())],
                'status' => 'nullable|string',
                'organization_id' => 'nullable|uuid',
                'search' => 'nullable|string|max:255',
            ]);

            // This would use a query use case to list documents
            
            return response()->json([
                'success' => true,
                'data' => [
                    'documents' => [],
                    'pagination' => [
                        'current_page' => $validated['page'] ?? 1,
                        'per_page' => $validated['per_page'] ?? 20,
                        'total' => 0,
                    ],
                    'message' => 'Document listing endpoint not yet implemented',
                ],
            ]);

        } catch (\Throwable $e) {
            Log::error('Error listing documents', [
                'error' => $e->getMessage(),
            ]);

            return response()->json([
                'success' => false,
                'error' => 'Failed to list documents',
                'details' => $e->getMessage(),
            ], 500);
        }
    }

    private function storeUploadedFile(UploadedFile $file): string
    {
        $filename = Str::uuid() . '.' . $file->getClientOriginalExtension();
        $directory = 'temp/pdf-processing/' . date('Y/m/d');
        
        $path = $file->storeAs($directory, $filename, 'local');
        
        return Storage::disk('local')->path($path);
    }

    private function createExtractionOptions(array $options): ExtractionOptions
    {
        $extractionOptions = ExtractionOptions::default();

        if (isset($options['use_ocr']) && $options['use_ocr']) {
            $languages = $options['ocr_languages'] ?? ['eng'];
            $extractionOptions = ExtractionOptions::withOcr($languages);
        }

        if (isset($options['preserve_layout'])) {
            $extractionOptions = $extractionOptions->withCustomOption('preserve_layout', $options['preserve_layout']);
        }

        if (isset($options['timeout_seconds'])) {
            $extractionOptions = $extractionOptions->withTimeout($options['timeout_seconds']);
        }

        return $extractionOptions;
    }

    private function cleanupTemporaryFile(string $filePath): void
    {
        try {
            if (file_exists($filePath)) {
                unlink($filePath);
                Log::debug('Temporary file cleaned up', ['file_path' => $filePath]);
            }
        } catch (\Throwable $e) {
            Log::warning('Failed to cleanup temporary file', [
                'file_path' => $filePath,
                'error' => $e->getMessage(),
            ]);
        }
    }
}