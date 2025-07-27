# GACAR Testing Documents

This folder is designated for **General Authority of Civil Aviation Regulations (GACAR)** testing documents.

## About GACAR

GACAR (General Authority of Civil Aviation Regulations) are the aviation regulations issued by the General Authority of Civil Aviation in Saudi Arabia. These regulations cover various aspects of civil aviation including:

- Aircraft operations
- Airworthiness standards
- Personnel licensing
- Airport operations
- Air traffic services
- Aviation security

## Document Format

GACAR documents are typically structured with:
- Numbered sections (e.g., GACAR Part 61, GACAR Part 91)
- Subsections with hierarchical numbering
- Regulatory text with specific requirements
- Appendices and amendments

## Testing Purpose

This folder should contain GACAR PDF documents for testing the AeroSync document processing pipeline, specifically:
- PDF parsing and text extraction
- Document type classification
- Section hierarchy detection
- Content quality assessment

## How to Add GACAR Documents

1. Place GACAR PDF files in this folder
2. Use descriptive filenames (e.g., `GACAR-Part-61-Personnel-Licensing.pdf`)
3. Ensure files are actual regulatory documents, not summaries or interpretations
4. Test various document sizes and complexity levels

## Supported Document Types

The AeroSync backend supports GACAR document processing with:
- Pattern-based classification
- Specialized section detection
- Quality scoring for regulatory content
- Integration with document management APIs

## Current Status

⚠️ **No GACAR documents currently available**

Please add GACAR PDF files to this folder for comprehensive testing of the document processing pipeline.

## Related Configuration

- Document type: `gacar`
- Complexity level: `high`
- Special handling: `required`
- Configuration files: `backend/lib/unified-parser/config/gacar-config.js`