---
# 2026-05-05
description: Rules for safe database migrations — never destroy existing production data.
inclusion: auto
---

<!-- 2026-05-05 -->

# Database Migration Safety Rules

> These rules apply to any SQL database: PostgreSQL, MySQL, SQLite, SQL Server, etc.

## Core Principle

**Never destroy existing data.** If the system is live and users have entered real data, any schema change must preserve that data completely.

## Rules

### 1. Additive Only
- ✅ `ADD COLUMN IF NOT EXISTS` — safe
- ✅ `CREATE INDEX IF NOT EXISTS` — safe
- ✅ `ALTER TABLE ... ADD CONSTRAINT` — safe (if no conflicting data)
- ❌ `DROP TABLE` — forbidden
- ❌ `DROP COLUMN` — forbidden without explicit user approval
- ❌ `TRUNCATE` — forbidden
- ❌ `DELETE FROM` without WHERE — forbidden

### 2. Constraint Changes
- Before adding `NOT NULL`, always `UPDATE ... SET column = default WHERE column IS NULL` first
- Before adding `UNIQUE`, verify no duplicate data exists
- Before changing a composite unique constraint, handle existing records

### 3. Migration Files
- All migrations go in `[MIGRATIONS_DIR]` with date prefix: `YYYYMMDD-description.sql`
- Every migration must be **idempotent** (safe to run multiple times)
- Use `IF NOT EXISTS` / `IF EXISTS` everywhere
- Include a comment block explaining what the migration does and any prerequisites

### 4. Data Backups
- Before any destructive migration, export affected tables first
- Use your database platform's export tools (pg_dump, mysqldump, Dashboard CSV export, etc.)

### 5. Code Changes Must Not Break Existing Data
- New columns must have `DEFAULT` values or be nullable
- Renamed columns must have a migration that copies data
- New `NOT NULL` constraints must have a migration that fills existing rows first
- Application types should use optional fields for new columns to maintain backward compatibility with existing records

### 6. Testing Migrations
- Test on a separate database instance or local database before running on production
- Or at minimum, verify with a SELECT query that existing data is intact after migration

## Examples

### ✅ Safe Migration
```sql
-- Add new column with default (existing rows get the default)
ALTER TABLE transactions ADD COLUMN IF NOT EXISTS location TEXT;

-- Add index (no data change)
CREATE INDEX IF NOT EXISTS idx_transactions_date ON transactions(date);
```

### ❌ Dangerous Migration
```sql
-- This would fail or delete rows that don't have a location!
ALTER TABLE daily_opens ALTER COLUMN location SET NOT NULL;
-- Must first: UPDATE daily_opens SET location = 'unspecified' WHERE location IS NULL;
```

---

## Customization

Replace these placeholders with your project-specific values:

| Placeholder | Description | Example |
|-------------|-------------|---------|
| `[MIGRATIONS_DIR]` | Where migration files are stored | `migrations/`, `db/migrate/`, `temporary/` |

Additional customization:
- **Backup strategy**: Document your specific backup tool and process
- **Testing environment**: Specify your staging/test database setup
- **Approval process**: Define who can approve destructive migrations (e.g., team lead, DBA)
- **ORM-specific rules**: If using an ORM (Prisma, Drizzle, ActiveRecord), add rules for generated migrations
