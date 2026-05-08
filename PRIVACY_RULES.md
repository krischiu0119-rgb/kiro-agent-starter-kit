<!-- 2026-05-08 -->
# Privacy & Sensitivity Rules

> This is a PUBLIC repository. All content must be safe for public consumption.

## Never Include

- **Brand names** from real projects (company names, product names, client names)
- **Live URLs** (production deployments, staging environments, internal tools)
- **Credentials** (API keys, tokens, passwords, connection strings, Supabase URLs)
- **Personal information** (email addresses, phone numbers, real names of team members)
- **Business logic** specific to a real project (pricing rules, SKU formats, promotion algorithms)
- **Internal infrastructure** details (database schemas from real projects, server IPs)
- **Client/partner names** or deal-specific information

## What IS Allowed

- Generic placeholder examples (e.g., `[PROJECT_NAME]`, `https://your-app.vercel.app`)
- Fictional brand names for examples (e.g., "my-api", "acme-store")
- General technology references (e.g., "uses Supabase for database", "deploys to Vercel")
- Framework patterns and workflow rules (these are the point of this repo)
- Generic code patterns without project-specific business logic

## Before Every Commit

Ask yourself:
1. Could someone identify a real company or project from this content?
2. Are there any URLs that resolve to a real deployment?
3. Are there any credentials, even expired ones?
4. Is there business logic that belongs to a specific client?

If YES to any → remove or genericize before committing.

## Tech Stack Mentions (OK)

You can mention technologies generically:
- ✅ "The author uses Supabase, Vercel, Next.js in personal projects"
- ✅ "This framework was tested with Next.js + Supabase + Tailwind stacks"
- ❌ "The EasyClean POS uses Supabase project ID xyz123"
- ❌ "Deployed at https://pos-two-azure.vercel.app"
