<!-- 2026-05-05 -->
<!-- TEMPLATE: Copy this file into your project root and rename to FILE_MAP.md -->
<!-- Then fill in each section with your actual project files. -->
<!-- Delete all <!-- TEMPLATE comments when done. -->

# FILE_MAP.md — [PROJECT_NAME]

> This file is maintained by the main agent. Sub-agents must check this before creating new files.

---

## How to Fill This In

1. **List every file** that an AI agent might need to read or modify
2. **Group by purpose** — pages, logic, data, config, etc.
3. **Add notes** about rules — where new files should go, what NOT to create
4. **Keep it updated** — when you add files, update this map

Tips:
- You don't need to list every file (skip `node_modules`, `.git`, build output)
- Focus on files that agents will interact with
- Add line counts for large files so agents know what they're dealing with
- Mark "source of truth" files so agents don't accidentally create duplicates

---

## Rules

1. **Before creating new files**, check this map to confirm no duplicate exists
2. **New files must go in the correct directory** — follow the conventions below
3. **If unsure where a file belongs**, ask in the main context before creating it

---

## Pages / Routes

<!-- TEMPLATE: List your app's pages or route handlers -->
<!-- Adapt the table columns to your framework -->

<!-- === Next.js App Router example === -->
<!--
| Path | Purpose | Notes |
|------|---------|-------|
| `app/page.tsx` | Home page | Server component |
| `app/dashboard/page.tsx` | Dashboard | Requires auth |
| `app/api/users/route.ts` | Users API | GET, POST |
-->

<!-- === Django example === -->
<!--
| Path | Purpose | Notes |
|------|---------|-------|
| `views/home.py` | Home view | Template: home.html |
| `views/api/users.py` | Users API | DRF ViewSet |
| `urls.py` | URL routing | Include app urls |
-->

<!-- === Rails example === -->
<!--
| Path | Purpose | Notes |
|------|---------|-------|
| `app/controllers/home_controller.rb` | Home page | index action |
| `app/controllers/api/users_controller.rb` | Users API | RESTful |
| `config/routes.rb` | All routes | |
-->

<!-- === Go (Chi/Gin) example === -->
<!--
| Path | Purpose | Notes |
|------|---------|-------|
| `handlers/home.go` | Home handler | GET / |
| `handlers/users.go` | Users CRUD | REST endpoints |
| `routes/routes.go` | Route registration | |
-->

| Path | Purpose | Notes |
|------|---------|-------|
| `[PATH]` | [DESCRIPTION] | [OPTIONAL_NOTES] |

**New page/route rules**: [DESCRIBE YOUR CONVENTION — e.g., "one file per route", "group by feature", etc.]

---

## Core Logic / Libraries

<!-- TEMPLATE: Your business logic, utilities, helpers, services -->
<!-- Include line counts for large files so agents budget their context -->

| File | Purpose | Lines | Notes |
|------|---------|-------|-------|
| `[PATH]` | [DESCRIPTION] | ~[N] | [RULES_OR_NOTES] |

**New logic rules**:
- [WHERE DO UTILITY FUNCTIONS GO?]
- [WHERE DO TYPE DEFINITIONS GO?]
- [WHERE DOES DATA ACCESS CODE GO?]
- [WHEN IS IT OK TO CREATE A NEW FILE VS. ADDING TO EXISTING?]

---

## Data Files

<!-- TEMPLATE: Static data, seed files, fixtures, JSON configs -->
<!-- Mark which file is the "source of truth" if data is duplicated -->

| File | Purpose | Source of Truth |
|------|---------|----------------|
| `[PATH]` | [DESCRIPTION] | [YES/NO or reference to canonical source] |

**Data rules**: [HOW IS DATA UPDATED? WHO OWNS IT? SYNC PROCESS?]

---

## Configuration

<!-- TEMPLATE: Build config, linter config, env files, deployment config -->

| File | Purpose |
|------|---------|
| `package.json` / `Cargo.toml` / `go.mod` | Dependencies and scripts |
| `[LINTER_CONFIG]` | Linting rules |
| `[BUILD_CONFIG]` | Build configuration |
| `[ENV_FILE]` | Environment variables (DO NOT commit secrets) |
| `[DEPLOY_CONFIG]` | Deployment settings |

---

## Temporary / Scripts

<!-- TEMPLATE: Migration scripts, one-off tasks, test scripts -->
<!-- These should be date-prefixed and disposable -->

| Purpose | Naming Format |
|---------|--------------|
| Database migrations | `YYYYMMDD-description.sql` |
| One-off scripts | `YYYYMMDD-description.[js|py|sh]` |
| Test/debug scripts | `YYYYMMDD-test-description.[js|py]` |

**Rules**: All temporary scripts go in `temporary/`. Never put them in the project root or source directories.

---

## Static Assets

<!-- TEMPLATE: Images, fonts, icons, public files -->

| Directory | Purpose |
|-----------|---------|
| `[PUBLIC_DIR]/` | Publicly served static files |
| `[IMAGES_DIR]/` | Image assets |
| `[ICONS_DIR]/` | App icons / favicons |

---

## State Management (if applicable)

<!-- TEMPLATE: For frontend apps — React Context, Redux stores, Zustand, etc. -->
<!-- Delete this section if not applicable -->

| File | Purpose |
|------|---------|
| `[PATH]` | [DESCRIPTION] |

**Rules**: [WHEN TO ADD TO EXISTING STATE VS. CREATE NEW STORE?]

---

## Tests (if applicable)

<!-- TEMPLATE: Test file locations and conventions -->
<!-- Delete this section if not applicable -->

| Directory | Purpose | Framework |
|-----------|---------|-----------|
| `[TEST_DIR]/` | [UNIT/INTEGRATION/E2E] | [JEST/PYTEST/GO TEST/etc.] |

**Naming convention**: [e.g., `*.test.ts`, `test_*.py`, `*_test.go`]
