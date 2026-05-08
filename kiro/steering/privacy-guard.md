---
# 2026-05-08
description: Prevents personal, project-specific, or sensitive information from being committed to this public repository.
inclusion: auto
---

<!-- 2026-05-08 -->

# Privacy Guard — Public Repository Protection

## Context

This is a PUBLIC repository. Every file committed here is visible to the entire internet.
The author uses this framework across multiple private projects. Content from those projects must NEVER leak into this repo.

## Before Writing Any Content

Check against this blocklist:

### Never Include
- Real brand/company/product names (e.g., client names, project codenames)
- Live deployment URLs (production, staging, or preview)
- API keys, tokens, passwords, database connection strings
- Personal information (emails, phone numbers, real names)
- Project-specific business logic (pricing rules, SKU formats, algorithms tied to a real product)
- Internal infrastructure details (real database schemas, server IPs, Supabase project IDs)

### Always Use Instead
- Generic placeholders: `[PROJECT_NAME]`, `[PRODUCTION_URL]`, `[API_KEY]`
- Fictional names: "my-api", "acme-store", "sample-app"
- Generic tech references: "uses Supabase for database" (not the actual project URL)

## When Adding Examples

Examples must be either:
1. **Fully fictional** — invented project with no connection to real work
2. **Thoroughly anonymized** — all identifying details replaced with generic equivalents

## Enforcement

If you detect any of the following patterns in content being written:
- URLs matching `*.vercel.app`, `*.supabase.co`, `*.railway.app` with real project slugs
- Company names that appear in the author's other private repos
- Specific pricing, SKU formats, or business rules from real projects

→ **STOP and flag it** before committing. Replace with generic placeholders.
