# AeroSync-V1 Database Backup

**Created**: July 25, 2025  
**Database**: AeroSync-V1 Supabase Project (hpozuqhkxpexrzjysvpo)  
**Method**: pg_dump via Supabase Session Pooler (IPv4 compatible)

## Backup Files

### 🗄️ Complete Backups
- **`aerosync-v1_FULL_BACKUP_2025-07-25.sql`** (1.6 MB)
  - Complete database with schema + data
  - Ready for full restoration
  - Includes DROP/CREATE statements

### 🏗️ Schema Only  
- **`aerosync-v1_SCHEMA_ONLY_2025-07-25.sql`** (368 KB)
  - Database structure only (no data)
  - Tables, functions, triggers, constraints, RLS policies
  - Perfect for setting up empty database

### 📊 Data Only
- **`aerosync-v1_DATA_ONLY_2025-07-25.sql`** (1.2 MB)  
  - Data export as INSERT statements
  - No schema definitions
  - For data migration to existing schema

## Database Contents

- **10 Schemas**: public, auth, storage, extensions, vault, graphql, realtime
- **43+ Tables**: Complete AeroSync application data
- **8 Extensions**: pg_graphql, vector, pgcrypto, pgjwt, uuid-ossp, supabase_vault
- **84 Migrations**: Complete migration history
- **RLS Policies**: Full Row Level Security implementation

## Restoration

### Full Restore
```bash
psql -h your-host -U postgres -d postgres -f aerosync-v1_FULL_BACKUP_2025-07-25.sql
```

### Schema Only
```bash  
psql -h your-host -U postgres -d postgres -f aerosync-v1_SCHEMA_ONLY_2025-07-25.sql
```

### Data Only (to existing schema)
```bash
psql -h your-host -U postgres -d postgres -f aerosync-v1_DATA_ONLY_2025-07-25.sql
```

## Technical Notes

- **Connection Method**: Supabase Session Pooler (solves IPv6 connectivity issues)
- **Backup Tool**: PostgreSQL 16.2 pg_dump
- **Format**: Plain SQL with INSERT statements and column names
- **Encoding**: UTF-8
- **RLS**: Row Level Security policies included
- **Extensions**: All Supabase and custom extensions preserved

## Support Files

- **`BACKUP_MANIFEST.json`**: Detailed backup metadata
- **`install-guide.md`**: PostgreSQL client installation guide  
- **`create-supabase-backup.js`**: Backup script (Node.js)

---
✅ **Backup Status**: Complete and Verified  
🔒 **Security**: Contains sensitive data - handle securely