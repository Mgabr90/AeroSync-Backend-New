# PostgreSQL Client Tools Installation Guide

## Prerequisites
- Windows Administrator privileges
- Internet connection

## Step 1: Clean Environment (Already Done)
✅ Corrupted Chocolatey installation has been cleaned up

## Step 2: Install Chocolatey (Admin Terminal Required)

### Open Admin Terminal
1. Press `Win + X`
2. Select "Windows PowerShell (Admin)" or "Terminal (Admin)"
3. If prompted by UAC, click "Yes"

### Install Chocolatey
Copy and paste this command in the admin terminal:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

### Verify Chocolatey Installation
```powershell
choco --version
```
You should see a version number like `2.5.0` or similar.

## Step 3: Install PostgreSQL Client Tools

### Method 1: Client Tools Only (Recommended)
```powershell
choco install psql -y
```

### Method 2: Full PostgreSQL with Client Tools
```powershell
choco install postgresql -y
```

### Verify PostgreSQL Client Installation
```powershell
pg_dump --version
```
You should see something like: `pg_dump (PostgreSQL) 15.8`

## Step 4: Test Database Connection

Test if you can connect to the Supabase database:
```powershell
pg_dump --host=db.hpozuqhkxpexrzjysvpo.supabase.co --username=postgres --dbname=postgres --version
```

## Step 5: Refresh Environment Variables

Close and reopen your terminal (both admin and regular) to ensure PATH changes take effect.

## Expected Results

After successful installation, you should have:
- ✅ `choco --version` works
- ✅ `pg_dump --version` works  
- ✅ `pg_restore --version` works
- ✅ `psql --version` works

## Next Steps

Once installation is complete:
1. Return to Claude Code
2. I'll run the comprehensive database backup script
3. Generate full pg_dump backup of your AeroSync-V1 database

## Troubleshooting

### If Chocolatey install fails:
- Ensure you're running as Administrator
- Check internet connection
- Try running: `Set-ExecutionPolicy RemoteSigned -Force`

### If PostgreSQL client install fails:
- Run: `choco install postgresql --force -y`
- Manually add to PATH: `C:\Program Files\PostgreSQL\15\bin`

### If PATH issues persist:
- Restart PowerShell/Terminal
- Check environment variables in System Properties
- Add manually: `C:\ProgramData\chocolatey\bin`

## Support

After completing these steps, run this command to verify everything:
```powershell
choco list --local-only
pg_dump --version
echo $env:PATH
```

Copy the output and share with Claude Code for verification.