<?php

namespace App\Application\DocumentParsing\UseCases;

use App\Application\DocumentParsing\Commands\ProcessDocumentCommand;
use App\Application\DocumentParsing\DTOs\ProcessedDocumentResult;
use App\Domain\DocumentParsing\Entities\RegulatoryDocument;
use App\Domain\DocumentParsing\Entities\DocumentSection;
use App\Domain\DocumentParsing\ValueObjects\DocumentType;
use App\Domain\DocumentParsing\ValueObjects\QualityScore;
use App\Domain\DocumentParsing\ValueObjects\SectionNumber;
use App\Domain\DocumentParsing\ValueObjects\Content;
use App\Domain\DocumentParsing\Repositories\DocumentRepository;
use App\Infrastructure\DocumentParsing\Extractors\HybridPdfExtractor;
use App\Infrastructure\DocumentParsing\Classifiers\PatternBasedClassifier;
use App\Infrastructure\DocumentParsing\Exceptions\ExtractionException;
use Illuminate\Support\Facades\Log;
use Throwable;

/**
 * Process Regulatory Document Use Case
 * Main orchestrator for document processing workflow
 */
class ProcessRegulatoryDocument
{
    public function __construct(
        private HybridPdfExtractor $pdfExtractor,
        private PatternBasedClassifier $documentClassifier,
        private DocumentRepository $documentRepository
    ) {}

    public function execute(ProcessDocumentCommand $command): ProcessedDocumentResult
    {
        $startTime = microtime(true);
        
        try {
            Log::info('Starting document processing', [
                'document_id' => $command->getDocumentId(),
                'file_name' => $command->getFileName(),
                'expected_type' => $command->getExpectedType()?->getValue(),
            ]);

            // Step 1: Create document entity
            $document = $this->createDocument($command);
            
            // Step 2: Extract text content
            $extractionResult = $this->extractContent($command);
            
            // Step 3: Classify document type (if not provided)
            $documentType = $this->classifyDocument($command, $extractionResult->getContent());
            
            // Step 4: Update document with classified type
            $document = RegulatoryDocument::create(
                $command->getDocumentId(),
                $command->getFileName(),
                $command->getFilePath(),
                $documentType
            );
            
            // Step 5: Start processing
            $document->startProcessing();
            
            // Step 6: Parse sections (simplified for now)
            $sections = $this->parseSections($extractionResult->getContent(), $document->getId());
            
            // Step 7: Add sections to document
            foreach ($sections as $section) {
                $document->addSection($section);
            }
            
            // Step 8: Validate quality
            $qualityThreshold = new QualityScore($command->getQualityThreshold());
            $qualityPassed = $document->validateQuality($qualityThreshold);
            
            // Step 9: Complete processing
            if ($qualityPassed) {
                $document->completeProcessing();
            } else {
                $document->failProcessing('Quality threshold not met');
            }
            
            // Step 10: Save document
            $this->documentRepository->save($document);
            
            $processingTime = (microtime(true) - $startTime) * 1000;
            
            Log::info('Document processing completed', [
                'document_id' => $document->getId(),
                'type' => $documentType->getValue(),
                'sections_count' => $sections->count(),
                'quality_score' => $document->getOverallQualityScore()?->getValue(),
                'processing_time_ms' => $processingTime,
                'status' => $document->getStatus()->getValue(),
            ]);
            
            return ProcessedDocumentResult::success(
                document: $document,
                extractionResult: $extractionResult,
                processingTimeMs: $processingTime
            );
            
        } catch (ExtractionException $e) {
            Log::error('Document extraction failed', [
                'document_id' => $command->getDocumentId(),
                'error' => $e->getMessage(),
                'file_path' => $command->getFilePath(),
            ]);
            
            return ProcessedDocumentResult::failure(
                command: $command,
                error: $e->getMessage(),
                processingTimeMs: (microtime(true) - $startTime) * 1000
            );
            
        } catch (Throwable $e) {
            Log::error('Document processing failed', [
                'document_id' => $command->getDocumentId(),
                'error' => $e->getMessage(),
                'trace' => $e->getTraceAsString(),
            ]);
            
            return ProcessedDocumentResult::failure(
                command: $command,
                error: 'Unexpected error: ' . $e->getMessage(),
                processingTimeMs: (microtime(true) - $startTime) * 1000
            );
        }
    }

    private function createDocument(ProcessDocumentCommand $command): RegulatoryDocument
    {
        $documentType = $command->getExpectedType() ?? DocumentType::unknown();
        
        return RegulatoryDocument::create(
            $command->getDocumentId(),
            $command->getFileName(),
            $command->getFilePath(),
            $documentType
        );
    }

    private function extractContent(ProcessDocumentCommand $command): \App\Infrastructure\DocumentParsing\DTOs\ExtractionResult
    {
        Log::info('Extracting content from PDF', [
            'file_path' => $command->getFilePath(),
            'extraction_options' => $command->getExtractionOptions()->toArray(),
        ]);
        
        $result = $this->pdfExtractor->extract(
            $command->getFilePath(),
            $command->getExtractionOptions()
        );
        
        if (!$result->isSuccessful()) {
            throw new ExtractionException(
                "PDF extraction failed: " . $result->getErrorMessage()
            );
        }
        
        Log::info('Content extraction completed', [
            'extractor' => $result->getExtractorName(),
            'quality_score' => $result->getQualityScore()->getValue(),
            'content_length' => strlen($result->getContent()->getCleanedContent()),
            'processing_time_ms' => $result->getProcessingTimeMs(),
        ]);
        
        return $result;
    }

    private function classifyDocument(ProcessDocumentCommand $command, Content $content): DocumentType
    {
        // If type is already provided and we should skip classification
        if ($command->getExpectedType() !== null && $command->shouldSkipClassification()) {
            Log::info('Skipping classification, using provided type', [
                'type' => $command->getExpectedType()->getValue(),
            ]);
            return $command->getExpectedType();
        }
        
        Log::info('Classifying document type', [
            'file_name' => $command->getFileName(),
            'content_length' => strlen($content->getCleanedContent()),
        ]);
        
        $classificationResult = $this->documentClassifier->classify(
            $content,
            $command->getFileName()
        );
        
        $detectedType = $classificationResult->getDocumentType();
        
        Log::info('Document classification completed', [
            'detected_type' => $detectedType->getValue(),
            'confidence' => $classificationResult->getConfidence(),
            'classifier' => $classificationResult->getClassifierName(),
            'all_scores' => $classificationResult->getAllScores(),
        ]);
        
        // If we have an expected type, validate against detected type
        if ($command->getExpectedType() !== null) {
            if (!$detectedType->equals($command->getExpectedType())) {
                Log::warning('Detected type differs from expected type', [
                    'expected' => $command->getExpectedType()->getValue(),
                    'detected' => $detectedType->getValue(),
                    'confidence' => $classificationResult->getConfidence(),
                ]);
                
                // Use expected type if classification confidence is low
                if ($classificationResult->getConfidence() < 0.8) {
                    return $command->getExpectedType();
                }
            }
        }
        
        return $detectedType;
    }

    private function parseSections(Content $content, string $documentId): \Illuminate\Support\Collection
    {
        // Simplified section parsing - in reality, this would use sophisticated parsing logic
        $sections = collect();
        $text = $content->getCleanedContent();
        
        // Split content into rough sections based on numbering patterns
        $sectionMatches = [];
        preg_match_all('/^(\d+(?:\.\d+)*)\s+(.+?)$/m', $text, $sectionMatches, PREG_SET_ORDER | PREG_OFFSET_CAPTURE);
        
        $sectionId = 1;
        foreach ($sectionMatches as $i => $match) {
            try {
                $sectionNumber = SectionNumber::fromString($match[1][0]);
                $title = trim($match[2][0]);
                
                // Extract content between this section and the next
                $startOffset = $match[0][1];
                $endOffset = isset($sectionMatches[$i + 1]) 
                    ? $sectionMatches[$i + 1][0][1] 
                    : strlen($text);
                
                $sectionText = substr($text, $startOffset, $endOffset - $startOffset);
                $sectionContent = Content::fromRaw(trim($sectionText));
                
                // Skip very short sections
                if ($sectionContent->getWordCount() < 5) {
                    continue;
                }
                
                $section = DocumentSection::create(
                    id: $documentId . '_section_' . $sectionId++,
                    documentId: $documentId,
                    sectionNumber: $sectionNumber,
                    title: $title,
                    content: $sectionContent,
                    pageNumber: 0 // Would be calculated from PDF structure
                );
                
                // Calculate quality score for this section
                $section->calculateQualityScore();
                
                $sections->push($section);
                
            } catch (\Exception $e) {
                Log::warning('Failed to parse section', [
                    'section_text' => $match[0][0] ?? 'unknown',
                    'error' => $e->getMessage(),
                ]);
            }
        }
        
        Log::info('Section parsing completed', [
            'document_id' => $documentId,
            'sections_found' => $sections->count(),
            'total_matches' => count($sectionMatches),
        ]);
        
        return $sections;
    }
}