# AeroSync Laravel Backend

A modern, enterprise-grade Laravel backend for aviation compliance management with advanced PDF parsing capabilities.

## 🚀 Features

### **Advanced PDF Processing**
- **Multi-method extraction** using Spatie, Poppler, and OCR
- **Hybrid processing** with automatic best-result selection
- **Quality assessment** with comprehensive scoring
- **Document classification** for aviation standards (IOSA, GACAR, ECAR, ICAO, FAA, EASA)
- **Intelligent section parsing** with hierarchy detection

### **Clean Architecture**
- **Domain-Driven Design** with clear separation of concerns
- **CQRS pattern** for command and query separation
- **Repository pattern** with Eloquent implementation
- **Value objects** for type safety and validation
- **Rich domain entities** with business logic

### **Performance & Reliability**
- **Comprehensive error handling** with detailed exception hierarchy
- **Configurable caching** for extraction results and classifications
- **Queue-based processing** for background jobs
- **Circuit breaker patterns** for external service resilience
- **Detailed logging and monitoring** support

## 📁 Project Structure

```
aerosync-laravel/
├── app/
│   ├── Domain/                    # Domain layer (business logic)
│   │   └── DocumentParsing/
│   │       ├── Entities/          # Domain entities
│   │       ├── ValueObjects/      # Value objects
│   │       ├── Services/          # Domain services
│   │       ├── Repositories/      # Repository interfaces
│   │       └── Events/            # Domain events
│   ├── Application/               # Application layer (use cases)
│   │   └── DocumentParsing/
│   │       ├── UseCases/          # Application use cases
│   │       ├── Commands/          # Commands (CQRS)
│   │       ├── Queries/           # Queries (CQRS)
│   │       └── DTOs/              # Data transfer objects
│   ├── Infrastructure/            # Infrastructure layer
│   │   └── DocumentParsing/
│   │       ├── Extractors/        # PDF extraction implementations
│   │       ├── Classifiers/       # Document classification
│   │       ├── Persistence/       # Database persistence
│   │       └── Exceptions/        # Infrastructure exceptions
│   └── Presentation/              # Presentation layer
│       └── Controllers/           # HTTP controllers
├── config/
│   └── document-parsing.php      # Configuration file
└── routes/
    └── api.php                    # API routes
```

## 🛠 Architecture Highlights

### **Domain Models**
- **RegulatoryDocument**: Core aggregate root for aviation documents
- **DocumentSection**: Individual sections with quality scoring
- **DocumentType**: Aviation document types with metadata
- **QualityScore**: Comprehensive quality assessment
- **ProcessingStatus**: Document processing lifecycle

### **PDF Extraction**
- **SpatieTextExtractor**: Fast text extraction for regular PDFs
- **HybridPdfExtractor**: Multi-method extraction with quality comparison
- **Extensible design** for additional extractors (Poppler, OCR)

### **Document Classification**
- **PatternBasedClassifier**: Regex and keyword-based classification
- **Confidence scoring** with evidence tracking
- **Extensible for AI-powered classification**

### **Quality Assessment**
- **Multi-dimensional scoring**: Content, structure, hierarchy, completeness
- **Configurable thresholds** and weights
- **Detailed quality reports** with actionable recommendations

## 📊 API Endpoints

### **Document Processing**
```http
POST /api/v1/documents/process
Content-Type: multipart/form-data

Parameters:
- file: PDF file (required, max 50MB)
- document_type: Aviation document type (optional)
- organization_id: Organization context (optional)
- use_ai: Enable AI processing (boolean)
- quality_threshold: Quality threshold (0.0-1.0)
```

### **Document Management**
```http
GET /api/v1/documents/{id}              # Get document details
GET /api/v1/documents/{id}/status       # Get processing status
GET /api/v1/documents                   # List documents with filtering
GET /api/v1/documents/{id}/sections     # Get document sections
```

### **System Information**
```http
GET /api/v1/health                      # Health check
GET /api/v1/document-types              # Supported document types
GET /api/v1/system/stats                # Processing statistics
GET /api/v1/system/extractors           # Available extractors
```

## 🔧 Configuration

### **PDF Extraction Settings**
```php
'extraction' => [
    'methods' => [
        'spatie' => ['enabled' => true, 'priority' => 80],
        'hybrid' => ['enabled' => true, 'priority' => 100],
    ],
    'default_options' => [
        'timeout_seconds' => 300,
        'quality_threshold' => 0.7,
        'preserve_layout' => true,
    ],
],
```

### **Quality Thresholds**
```php
'quality' => [
    'thresholds' => [
        'minimum_overall_score' => 0.85,
        'excellent_threshold' => 0.95,
        'good_threshold' => 0.85,
        'acceptable_threshold' => 0.70,
    ],
],
```

## 📈 Performance Features

### **Caching Strategy**
- **L1 Cache**: In-memory for current request
- **L2 Cache**: Redis for cross-request caching
- **Configurable TTL** for different data types
- **Cache invalidation** on document updates

### **Queue Processing**
- **Background processing** for large documents
- **Priority queues** for urgent documents
- **Retry mechanisms** with exponential backoff
- **Progress tracking** with real-time updates

### **Monitoring & Observability**
- **Structured logging** with correlation IDs
- **Performance metrics** tracking
- **Quality score monitoring**
- **Error rate tracking**

## 🛡 Security Features

### **Input Validation**
- **File type validation** (PDF only)
- **File size limits** (configurable)
- **Malware scanning** (configurable)
- **Input sanitization**

### **Access Control**
- **Authentication required**
- **Organization-based access**
- **Rate limiting**
- **API key management**

### **Data Protection**
- **Temporary file cleanup**
- **Encrypted storage** (optional)
- **Audit logging**
- **Data retention policies**

## 🧪 Quality Assurance

### **Testing Strategy**
- **Unit tests** for domain logic
- **Integration tests** for workflows
- **Feature tests** for API endpoints
- **Performance tests** for load scenarios

### **Code Quality**
- **PHPStan** for static analysis
- **PHP CS Fixer** for code style
- **PHPMD** for mess detection
- **SonarQube** for quality gates

## 🚀 Getting Started

### **Prerequisites**
- PHP 8.2+
- Laravel 11+
- PostgreSQL (Supabase)
- Redis (for caching and queues)
- Composer

### **Installation**
1. Install dependencies:
   ```bash
   composer install
   ```

2. Configure environment:
   ```bash
   cp .env.example .env
   # Edit .env with your database and service configurations
   ```

3. Register the service provider:
   ```php
   // config/app.php
   'providers' => [
       // ...
       App\Providers\DocumentParsingServiceProvider::class,
   ],
   ```

4. Publish configuration:
   ```bash
   php artisan vendor:publish --tag=document-parsing-config
   ```

5. Set up database connection for existing Supabase schema

6. Start processing:
   ```bash
   php artisan serve
   ```

## 🔗 Integration with Existing System

This Laravel backend is designed to work with the existing Supabase database schema:

- **Documents table**: Maps to `RegulatoryDocument` entity
- **Document sections table**: Maps to `DocumentSection` entity
- **Backward compatibility**: Legacy API endpoints supported
- **Gradual migration**: Can run alongside Node.js backend

## 📝 API Response Format

### **Success Response**
```json
{
  "success": true,
  "data": {
    "document_id": "uuid",
    "document_type": {
      "value": "iosa",
      "display_name": "IOSA Standards Manual"
    },
    "status": {
      "value": "completed",
      "display_name": "Completed"
    },
    "sections_count": 150,
    "quality_score": {
      "value": 0.92,
      "level": "excellent"
    },
    "processing_time_ms": 5420
  }
}
```

### **Error Response**
```json
{
  "success": false,
  "error": "Document processing failed",
  "details": "PDF extraction failed: File not readable",
  "phase": "extraction",
  "document_id": "uuid"
}
```

## 🎯 Key Improvements Over Node.js Version

### **Architecture**
- ✅ **Clean Architecture** with proper layer separation
- ✅ **Type Safety** with PHP 8+ features and value objects
- ✅ **SOLID Principles** implementation
- ✅ **Domain-Driven Design** with rich entities

### **PDF Processing**
- ✅ **Multi-method extraction** with quality comparison
- ✅ **Comprehensive quality assessment** with detailed scoring
- ✅ **Better error handling** with specific exception types
- ✅ **Performance optimization** with caching and queues

### **Code Quality**
- ✅ **Better separation of concerns**
- ✅ **Comprehensive error handling**
- ✅ **Extensive configuration options**
- ✅ **Built-in monitoring and observability**

### **Maintainability**
- ✅ **Modular design** for easy extension
- ✅ **Comprehensive documentation**
- ✅ **Test-friendly architecture**
- ✅ **Configuration-driven behavior**

This Laravel implementation provides a robust, scalable, and maintainable foundation for aviation document processing with advanced PDF parsing capabilities.