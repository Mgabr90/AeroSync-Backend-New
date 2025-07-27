# AeroSync Laravel Backend API - Postman Collection

This directory contains Postman collections and environments for testing the AeroSync Laravel Backend API.

## Files Included

### Collections
- **`AeroSync-Laravel-API.postman_collection.json`** - Complete API collection with all endpoints

### Environments
- **`AeroSync-Development.postman_environment.json`** - Development environment configuration
- **`AeroSync-Production.postman_environment.json`** - Production environment configuration

## How to Import

### Import Collection
1. Open Postman
2. Click **Import** button
3. Select `AeroSync-Laravel-API.postman_collection.json`
4. Collection will be imported with all requests organized in folders

### Import Environments
1. Click **Import** button
2. Select the environment files (`AeroSync-Development.postman_environment.json` and `AeroSync-Production.postman_environment.json`)
3. Switch between environments using the dropdown in top-right corner

## API Endpoints Included

### 🏥 Health & System
- **GET** `/api/v1/health` - System health check
- **GET** `/api/health` - Legacy health check
- **GET** `/api/v1/system/stats` - Processing statistics
- **GET** `/api/v1/system/extractors` - Available PDF extractors

### 📄 Document Processing
- **POST** `/api/v1/documents/process` - Upload and process documents
- **GET** `/api/v1/documents/{id}/status` - Check processing status
- **GET** `/api/v1/documents/{id}` - Get document details
- **GET** `/api/v1/documents` - List documents with filtering

### 📋 Document Sections
- **GET** `/api/v1/documents/{id}/sections` - Get document sections
- **GET** `/api/v1/documents/{id}/sections/{sectionId}` - Get section details

### 🏷️ Document Types
- **GET** `/api/v1/document-types` - Supported document types
- **POST** `/api/v1/document-types/classify` - Classify document type

### 🔐 Authentication
- **GET** `/api/user` - Get current authenticated user

### 🔄 Legacy Compatibility
- **POST** `/api/enhanced-jobs` - Legacy endpoint compatibility

## Environment Variables

The collection uses the following environment variables:

| Variable | Description | Example |
|----------|-------------|---------|
| `base_url` | API base URL | `http://localhost:8000` |
| `api_prefix` | API version prefix | `/api/v1` |
| `auth_token` | Bearer authentication token | `your-jwt-token` |
| `document_id` | Document UUID for testing | `123e4567-e89b-12d3-a456-426614174000` |
| `section_id` | Section UUID for testing | `123e4567-e89b-12d3-a456-426614174001` |
| `organization_id` | Organization UUID | `123e4567-e89b-12d3-a456-426614174002` |

## Usage Instructions

### 1. Set Up Environment
1. Select appropriate environment (Development/Production)
2. Set the `base_url` to your Laravel application URL
3. If authentication is required, set the `auth_token` variable

### 2. Test Document Processing
1. Use **Process Document** request
2. Upload a PDF file in the form data
3. Check response for `document_id`
4. Use returned `document_id` to test other endpoints

### 3. Authentication (if required)
1. Obtain authentication token from your auth system
2. Set `auth_token` environment variable
3. Requests requiring auth will automatically include the Bearer token

## Document Processing Parameters

When using the **Process Document** endpoint, you can configure:

### Required Parameters
- `file` - PDF file to process (max 50MB)

### Optional Parameters
- `document_type` - Expected type (`iosa`, `gacar`, `ecar`, `icao`, `faa`, `easa`)
- `organization_id` - Organization UUID
- `use_ai` - Enable AI processing (boolean)
- `skip_classification` - Skip auto-classification (boolean)
- `quality_threshold` - Quality threshold (0-1, default: 0.85)

### Extraction Options
- `extraction_options[use_ocr]` - Enable OCR for scanned documents
- `extraction_options[preserve_layout]` - Preserve document layout
- `extraction_options[timeout_seconds]` - Processing timeout (30-600 seconds)
- `extraction_options[ocr_languages]` - OCR languages array

## Response Format

All API responses follow this structure:

```json
{
  "success": true|false,
  "data": {
    // Response data
  },
  "message": "Success/error message",
  "error": "Error details (if success=false)"
}
```

## Testing Features

The collection includes automated tests for:
- Response time validation (< 10 seconds)
- Response structure validation
- Automatic extraction of `document_id` from successful uploads

## Support

For API documentation and support:
- Check the Laravel application routes in `routes/api.php`
- Review controller implementations in `app/Presentation/Controllers/`
- Check application logs for debugging

## Version

Collection Version: 1.0.0
Compatible with: AeroSync Laravel Backend API v1.0.0