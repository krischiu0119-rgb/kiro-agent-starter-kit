---
# 2026-05-07
description: Rules for safe database migrations — never destroy existing production data.
inclusion: manual
---

<!-- 2026-05-07 -->

# Database Safety

## Forbidden (without explicit user approval)
- DROP TABLE, DROP COLUMN, TRUNCATE, DELETE without WHERE.

## Required Practices
- Additive only: `ADD COLUMN IF NOT EXISTS`, `CREATE INDEX IF NOT EXISTS`.
- All migrations idempotent (use IF NOT EXISTS / IF EXISTS).
- New columns: must have DEFAULT or be nullable.
- Migration files: `[MIGRATIONS_DIR]/YYYYMMDD-description.sql`.
- Test on staging/local before production.

## Constraint Changes
- Before NOT NULL: `UPDATE SET default WHERE column IS NULL` first.
- Before UNIQUE: verify no duplicate data exists.
- Before composite unique change: handle existing records.

## Backups
- Export affected tables before any destructive migration.
- Application types: use optional fields for new columns (backward compat).
