<!-- 2026-05-05 -->
<!-- TEMPLATE: Copy this file into your project root and rename to PROJECT_BRIEF.md -->
<!-- This is the FIRST file sub-agents read. Keep it concise but complete. -->
<!-- Delete all <!-- TEMPLATE comments when done. -->

# [PROJECT_NAME] — Project Brief

> Sub-agents read this file first to understand the project. No other file should be needed for context.

---

## What Is This?

<!-- TEMPLATE: One paragraph. What does this project do? Who uses it? -->
<!-- Examples: -->
<!-- "A B2B SaaS dashboard for managing warehouse inventory across multiple locations." -->
<!-- "A mobile-first PWA for restaurant staff to take orders and process payments." -->
<!-- "A CLI tool that generates API documentation from OpenAPI specs." -->

[ONE_PARAGRAPH_DESCRIPTION]

---

## Tech Stack

<!-- TEMPLATE: List your actual technologies. Delete lines that don't apply. -->

- **Frontend**: [FRAMEWORK — e.g., Next.js 14, Vue 3, SvelteKit, none]
- **Backend**: [FRAMEWORK — e.g., Express, Django, Rails, Go net/http, same as frontend]
- **Database**: [DATABASE — e.g., PostgreSQL via Supabase, MongoDB Atlas, SQLite]
- **Hosting**: [PLATFORM — e.g., Vercel, AWS, Railway, self-hosted]
- **Key Libraries**: [LIST — e.g., Tailwind CSS, Prisma, tRPC, Stripe SDK]
- **Language**: [LANGUAGE + VERSION — e.g., TypeScript 5, Python 3.12, Go 1.22]

---

## Architecture

<!-- TEMPLATE: Brief description of how the system is structured. -->
<!-- Can be a paragraph, a list, or ASCII art. Keep it under 10 lines. -->
<!-- Examples: -->
<!-- "Monolithic Next.js app with API routes. Database accessed via Prisma ORM." -->
<!-- "Django backend serves REST API. React SPA frontend. PostgreSQL database." -->
<!-- "Microservices: auth-service (Go), api-gateway (Node), worker (Python). All on K8s." -->

[ARCHITECTURE_DESCRIPTION]

---

## Key Commands

<!-- TEMPLATE: Commands that agents need to run. Adjust to your stack. -->

```bash
# Build / compile
[BUILD_COMMAND — e.g., npm run build, cargo build, go build ./...]

# Run tests
[TEST_COMMAND — e.g., npm test, pytest, go test ./...]

# Start dev server
[DEV_COMMAND — e.g., npm run dev, python manage.py runserver, air]

# Deploy
[DEPLOY_COMMAND — e.g., git push (auto-deploy), railway up, fly deploy]

# Lint / format
[LINT_COMMAND — e.g., npm run lint, ruff check ., golangci-lint run]
```

---

## Directory Structure

<!-- TEMPLATE: High-level overview. Reference FILE_MAP.md for full details. -->

```
[PROJECT_ROOT]/
├── [SOURCE_DIR]/           ← [DESCRIPTION]
│   ├── [SUBDIR_1]/        ← [DESCRIPTION]
│   ├── [SUBDIR_2]/        ← [DESCRIPTION]
│   └── [SUBDIR_3]/        ← [DESCRIPTION]
├── [LIB_DIR]/             ← [DESCRIPTION]
├── [DATA_DIR]/            ← [DESCRIPTION]
├── [CONFIG_FILES]         ← [DESCRIPTION]
└── FILE_MAP.md            ← Full file placement rules
```

See `FILE_MAP.md` for detailed file-by-file documentation.

---

## Business Rules

<!-- TEMPLATE: Domain-specific rules that agents MUST know to avoid bugs. -->
<!-- These are the rules that aren't obvious from reading the code. -->
<!-- Examples: -->
<!-- "Prices are always stored in cents (integer), displayed in dollars." -->
<!-- "User IDs use UUID v4, never sequential integers." -->
<!-- "All timestamps are UTC. Display converts to user's timezone." -->
<!-- "The 'admin' account can never be deleted or demoted." -->

- [RULE_1]
- [RULE_2]
- [RULE_3]

---

## Current Status

<!-- TEMPLATE: Where is the project right now? What's actively being worked on? -->

- **Stage**: [CURRENT_STAGE — e.g., MVP, Beta, Production, Maintenance]
- **Last updated**: [DATE — YYYY-MM-DD]
- **Active work**: [WHAT'S BEING BUILT/FIXED RIGHT NOW]
- **Known issues**: [MAJOR BUGS OR TECH DEBT TO BE AWARE OF]

---

## Verification

<!-- TEMPLATE: How does an agent confirm their work is correct? -->

```bash
# Minimum verification (every change)
[BUILD_COMMAND]

# Full verification (before deploy)
[TEST_COMMAND]
```

---

## Environment Setup (optional)

<!-- TEMPLATE: Delete this section if setup is standard (npm install, etc.) -->
<!-- Include only if there are non-obvious setup steps. -->

```bash
# [SETUP_STEPS]
```

Required environment variables (see `.env.example`):
- `[VAR_NAME]` — [PURPOSE]
