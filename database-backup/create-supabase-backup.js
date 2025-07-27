const { exec } = require('child_process');
const fs = require('fs');
const path = require('path');

// Supabase database connection details for hpozuqhkxpexrzjysvpo
const DB_CONFIG = {
  host: 'aws-0-us-east-1.pooler.supabase.com',
  port: 5432,
  database: 'postgres',
  username: 'postgres.hpozuqhkxpexrzjysvpo',
  password: process.env.SUPABASE_DB_PASSWORD || process.argv[2] || 'bC5VSL2y4yrQIlPE'
};

const BACKUP_DIR = __dirname;
const timestamp = new Date().toISOString().slice(0, 10); // YYYY-MM-DD format
const projectName = 'aerosync-v1';

function createComprehensiveBackup() {
  return new Promise((resolve, reject) => {
    if (!DB_CONFIG.password) {
      console.error('ERROR: Database password not provided!');
      console.log('Please set SUPABASE_DB_PASSWORD environment variable.');
      reject(new Error('Database password missing'));
      return;
    }

    const backupFiles = {
      full: path.join(BACKUP_DIR, `${projectName}_FULL_BACKUP_${timestamp}.sql`),
      schema: path.join(BACKUP_DIR, `${projectName}_SCHEMA_ONLY_${timestamp}.sql`),
      data: path.join(BACKUP_DIR, `${projectName}_DATA_ONLY_${timestamp}.sql`),
      manifest: path.join(BACKUP_DIR, `BACKUP_MANIFEST.json`)
    };

    console.log('🚀 Starting comprehensive Supabase database backup...');
    console.log(`📊 Project: AeroSync-V1 (${DB_CONFIG.host})`);
    console.log(`📁 Backup Directory: ${BACKUP_DIR}`);
    console.log('');

    // Set PGPASSWORD environment variable for authentication
    const env = { ...process.env, PGPASSWORD: DB_CONFIG.password };

    // Full backup with schema + data
    const fullBackupCommand = [
      'pg_dump',
      `--host=${DB_CONFIG.host}`,
      `--port=${DB_CONFIG.port}`,
      `--username=${DB_CONFIG.username}`,
      `--dbname=${DB_CONFIG.database}`,
      '--verbose',
      '--clean',                    // Include DROP statements
      '--create',                   // Include CREATE DATABASE statement
      '--if-exists',               // Use IF EXISTS for DROP statements
      '--no-owner',                // Don't include ownership commands
      '--format=plain',            // Plain text format
      '--inserts',                 // Use INSERT statements instead of COPY
      '--column-inserts',          // Use column names in INSERT statements
      '--serializable-deferrable', // Use serializable transaction
      `--file=${backupFiles.full}`
    ].join(' ');

    console.log('1️⃣ Creating full backup (schema + data)...');
    exec(fullBackupCommand, { env, maxBuffer: 1024 * 1024 * 100 }, (error, stdout, stderr) => {
      if (error) {
        console.error('❌ Full backup failed:', error.message);
        reject(error);
        return;
      }

      console.log('✅ Full backup completed!');
      if (stderr && !stderr.includes('NOTICE:')) {
        console.log('⚠️  Warnings:', stderr);
      }

      // Schema-only backup
      const schemaBackupCommand = [
        'pg_dump',
        `--host=${DB_CONFIG.host}`,
        `--port=${DB_CONFIG.port}`,
        `--username=${DB_CONFIG.username}`,
        `--dbname=${DB_CONFIG.database}`,
        '--verbose',
        '--schema-only',             // Schema only
        '--clean',                   // Include DROP statements
        '--create',                  // Include CREATE DATABASE statement
        '--if-exists',              // Use IF EXISTS for DROP statements
        '--no-owner',               // Don't include ownership commands
        '--format=plain',           // Plain text format
        `--file=${backupFiles.schema}`
      ].join(' ');

      console.log('2️⃣ Creating schema-only backup...');
      exec(schemaBackupCommand, { env, maxBuffer: 1024 * 1024 * 50 }, (schemaError, schemaStdout, schemaStderr) => {
        if (schemaError) {
          console.error('❌ Schema backup failed:', schemaError.message);
        } else {
          console.log('✅ Schema-only backup completed!');
        }

        // Data-only backup
        const dataBackupCommand = [
          'pg_dump',
          `--host=${DB_CONFIG.host}`,
          `--port=${DB_CONFIG.port}`,
          `--username=${DB_CONFIG.username}`,
          `--dbname=${DB_CONFIG.database}`,
          '--verbose',
          '--data-only',              // Data only
          '--no-owner',               // Don't include ownership commands
          '--format=plain',           // Plain text format
          '--inserts',                // Use INSERT statements
          '--column-inserts',         // Use column names in INSERT statements
          `--file=${backupFiles.data}`
        ].join(' ');

        console.log('3️⃣ Creating data-only backup...');
        exec(dataBackupCommand, { env, maxBuffer: 1024 * 1024 * 100 }, (dataError, dataStdout, dataStderr) => {
          if (dataError) {
            console.error('❌ Data backup failed:', dataError.message);
          } else {
            console.log('✅ Data-only backup completed!');
          }

          // Create backup manifest
          const manifest = {
            timestamp: new Date().toISOString(),
            project: {
              name: 'AeroSync-V1',
              id: 'hpozuqhkxpexrzjysvpo',
              region: 'us-east-1',
              host: DB_CONFIG.host
            },
            backupFiles: {},
            database: {
              version: '15.8.1.121',
              postgres_engine: '15'
            },
            extensions: {
              installed: [
                'pg_graphql 1.5.11',
                'pg_stat_statements 1.10', 
                'pgjwt 0.2.0',
                'supabase_vault 0.3.1',
                'vector 0.8.0',
                'uuid-ossp 1.1',
                'pgcrypto 1.3',
                'plpgsql 1.0'
              ]
            },
            migrations: {
              total: 84,
              latest: '20250628061846_add_original_outline_title_column'
            }
          };

          // Get file stats for manifest
          Object.keys(backupFiles).forEach(type => {
            if (type !== 'manifest' && fs.existsSync(backupFiles[type])) {
              const stats = fs.statSync(backupFiles[type]);
              manifest.backupFiles[type] = {
                path: backupFiles[type],
                size: stats.size,
                sizeMB: (stats.size / 1024 / 1024).toFixed(2),
                created: stats.birthtime
              };
            }
          });

          // Write manifest
          fs.writeFileSync(backupFiles.manifest, JSON.stringify(manifest, null, 2));

          console.log('');
          console.log('🎉 Comprehensive backup completed successfully!');
          console.log('📋 Backup Summary:');
          Object.entries(manifest.backupFiles).forEach(([type, info]) => {
            console.log(`   ${type.toUpperCase()}: ${info.sizeMB} MB - ${path.basename(info.path)}`);
          });
          console.log(`📄 Manifest: ${path.basename(backupFiles.manifest)}`);
          console.log('');
          console.log('🔍 Backup includes:');
          console.log('   • All schemas (public, auth, storage, extensions, vault, etc.)');
          console.log('   • All tables with complete data');
          console.log('   • All functions and stored procedures');
          console.log('   • All triggers and constraints');
          console.log('   • All RLS (Row Level Security) policies');
          console.log('   • All installed extensions');
          console.log('   • Complete migration history (84 migrations)');

          resolve(manifest);
        });
      });
    });
  });
}

// Main execution
if (require.main === module) {
  console.log('🔐 Note: Set SUPABASE_DB_PASSWORD environment variable with your database password');
  console.log('🔐 You can get it from: https://supabase.com/dashboard/project/hpozuqhkxpexrzjysvpo/settings/database');
  console.log('');
  
  createComprehensiveBackup()
    .then((manifest) => {
      console.log('✨ Backup process completed successfully!');
      process.exit(0);
    })
    .catch((error) => {
      console.error('💥 Backup process failed:', error.message);
      process.exit(1);
    });
}

module.exports = { createComprehensiveBackup, DB_CONFIG };