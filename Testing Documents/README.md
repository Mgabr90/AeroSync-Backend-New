# AeroSync Testing Documents

This directory contains test documents for validating the AeroSync document processing pipeline across different aviation regulatory frameworks.

## Directory Structure

```
Testing Documents/
├── README.md                    # This file
├── IOSA ISM-17-EN.pdf          # IATA Operational Safety Audit manual
├── IOSA-Test-Small.pdf         # Smaller IOSA test document
├── GACAR/                      # General Authority of Civil Aviation Regulations (Saudi Arabia)
│   └── README.md
└── ECAR/                       # Egyptian Civil Aviation Regulations
    └── README.md
```

## Document Types Supported

### 📋 IOSA (IATA Operational Safety Audit)
- **Complexity**: High
- **Files**: 2 documents available
- **Purpose**: Primary testing documents for complex aviation safety standards
- **Features**: Comprehensive section hierarchy, quality assessment, advanced parsing

### 🇸🇦 GACAR (General Authority of Civil Aviation Regulations)
- **Complexity**: High  
- **Files**: None currently (placeholder folder created)
- **Purpose**: Saudi Arabian civil aviation regulations testing
- **Features**: Regulatory text processing, compliance verification

### 🇪🇬 ECAR (Egyptian Civil Aviation Regulations)
- **Complexity**: Medium
- **Files**: None currently (placeholder folder created)  
- **Purpose**: Egyptian civil aviation regulations testing
- **Features**: Multi-language support, regulatory structure analysis

## Supported Document Types in API

The AeroSync backend supports the following document types via API:

| Type | Display Name | Complexity | Special Handling |
|------|-------------|------------|------------------|
| `iosa` | IOSA Standards Manual | High | ✅ Required |
| `gacar` | GACAR Regulations | High | ✅ Required |
| `ecar` | ECAR Standards | Medium | ✅ Required |
| `icao` | ICAO Documents | Medium | ❌ Not Required |
| `faa` | FAA Regulations | Medium | ❌ Not Required |
| `easa` | EASA Standards | Medium | ❌ Not Required |

## Usage Instructions

### API Testing
1. Use the Postman collection in `../postman-collections/`
2. Select appropriate document type when processing
3. Upload PDF files via `/api/v1/documents/process` endpoint

### Adding New Test Documents
1. Place PDF files in appropriate subdirectories
2. Update this README with document information
3. Test processing via API endpoints
4. Verify section extraction and quality scores

### Laravel Backend Integration
```php
// Example API call for document processing
POST /api/v1/documents/process
Content-Type: multipart/form-data

file: [PDF_FILE]
document_type: "iosa|gacar|ecar|icao|faa|easa"
use_ai: true|false
quality_threshold: 0.85
```

## Quality Standards

Test documents should meet these criteria:
- ✅ Official regulatory publications
- ✅ Clear hierarchical structure
- ✅ Readable text (not scanned images unless OCR testing)
- ✅ Various complexity levels
- ✅ Different document sizes
- ✅ Multiple languages (where applicable)

## Processing Pipeline Testing

Each document type tests different aspects:

### Text Extraction
- PDF parsing accuracy
- Layout preservation
- Character encoding handling
- OCR capabilities (for scanned documents)

### Document Classification
- Automatic type detection
- Pattern matching accuracy
- Content-based classification
- Confidence scoring

### Section Analysis
- Hierarchical structure detection
- Section numbering recognition
- Content quality assessment
- Cross-reference resolution

### Quality Assessment
- Content completeness scoring
- Text clarity evaluation
- Structure consistency validation
- Processing confidence metrics

## Contributing

To add new test documents:
1. Ensure documents are publicly available or appropriately licensed
2. Add to the correct subdirectory
3. Update relevant README files
4. Test processing through the API
5. Document any special requirements or considerations

## Notes

- All documents should be aviation-related regulatory content
- Respect copyright and licensing requirements
- Test documents should represent real-world usage scenarios
- Consider document size limitations (currently 50MB max via API)

## Related Files

- **API Documentation**: `../postman-collections/README.md`
- **Laravel Routes**: `../laravel-backend/aerosync-laravel/routes/api.php`
- **Document Types**: `../laravel-backend/aerosync-laravel/app/Domain/DocumentParsing/ValueObjects/DocumentType.php`
- **Processing Controller**: `../laravel-backend/aerosync-laravel/app/Presentation/Controllers/DocumentProcessingController.php`