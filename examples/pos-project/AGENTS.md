<!-- 2026-05-05 -->
<!-- EXAMPLE: This is a filled-in AGENTS.md for a real project. -->
<!-- Use this as a reference when filling in the template for your own project. -->

# AGENTS.md — EasyClean POS

> 一級淨 快閃櫃 POS 系統 — iPad-first web POS for pop-up retail.
> Cross-platform agent workflow. Works with Kiro IDE, Claude Code, Claude CoWork.

## Project Context

- **Project**: EasyClean POS (一級淨 快閃櫃 POS)
- **Stack**: Next.js 15 (App Router) + React 19 + TypeScript 5 + Tailwind CSS 4 + Supabase + Google APIs
- **Build**: `cd pos && npm run build`
- **Test**: `node temporary/20260504-qa-runner.mjs` (33 checks)
- **Deploy**: `git push` → Vercel (auto-deploy, verify with `vercel ls`)
- **Live URL**: https://pos-two-azure.vercel.app

---

## Core Workflow Rules

### 1. Main Context = Planning Only

The main conversation is for **planning and coordination only**.
All implementation work is delegated to sub-agents.

Never write more than 20 lines of code in the main context.

### 2. Task Size Routing

| Size | Criteria | Action |
|------|----------|--------|
| **Small** | < 20 lines, single file | Execute directly in main context |
| **Medium** | 20-100 lines, 1-3 files | Delegate to 1 Executor sub-agent |
| **Large** | > 100 lines or 4+ files | Split into multiple Executors + Reviewer |

### 3. Parallel Agent Limits

- **Max parallel agents**: 3 (16GB RAM machine)
- Each agent must complete and report before spawning replacements
- Never exceed the limit — queue tasks if needed
- Note: `storage.ts` (~900 lines) counts as 2 context slots

### 4. Verification Rule

Every sub-agent **must** run `cd pos && npm run build` and confirm zero errors.
No exceptions. A task is not complete until the build passes.

---

## Agent Roles

### Planner（規劃者）
- Reads the request, breaks it into discrete tasks
- Assigns tasks to Executor agents with clear scope
- Does NOT write implementation code

### Executor（執行者）
- Receives a focused task (1 feature, 1 fix, 1 migration)
- Implements the change
- Runs `npm run build` to verify
- Reports result to `temporary/YYYYMMDD-result-{name}.md`

### Reviewer（審查者）
- Reads Executor output from `temporary/`
- Runs `node temporary/20260504-qa-runner.mjs` (full 33-check suite)
- Reports issues or approves

---

## QA Strategy — 3 Layers

| Layer | Trigger | Checks |
|-------|---------|--------|
| **Layer 1: Smoke** | After each sub-agent task | `npm run build` passes, no type errors |
| **Layer 2: Regression** | After feature complete | `qa-runner.mjs` — 33 tests covering all pages |
| **Layer 3: Full Audit** | Before deploy / stage end | 2-3 QA sub-agents: edge cases, mobile, a11y |

---

## Project-Specific Rules

### SKU Format
All products use SKU format: `EC-{category}-{number}`
- Categories: CL (cleaner), SH (shampoo), MA (mask), AC (accessory), FB (fabric), OD (odor)
- Example: `EC-CL-001`, `EC-SH-002`

### Pricing
- All prices in TWD, tax-inclusive
- Format with comma separator: `$1,590` not `$1590`
- Use `lib/format.ts` → `formatPrice()` for display

### Data Flow (Source of Truth)
```
data/一級淨_產品主檔.md  →  pos/data/products.json
data/一級淨_市售價格及產品表.md  →  pos/data/promotions.json
```
**Never edit the JSON directly.** Change the Markdown source, then sync.

### File Placement
Before creating ANY new file, read `FILE_MAP.md`:
- Types → add to `lib/types.ts`
- Data access → add to `lib/storage.ts`
- Utilities → check `lib/format.ts` first
- New pages → one directory per feature, file named `page.tsx`

---

## Communication Protocol

- Sub-agents write results to `temporary/YYYYMMDD-{task-name}.md`
- Reviewer reads from `temporary/` to assess quality
- Main context reads summaries, never raw implementation details
- Clean up temporary files after batch is complete

---

## Database Safety

- All migrations are **additive only** (ADD COLUMN, CREATE TABLE)
- Never DROP, TRUNCATE, or DELETE without explicit user approval
- Migration scripts go to `temporary/YYYYMMDD-*.sql` for review first
- Test against Supabase staging, never production directly

---

## Deployment Verification

After `git push`:
1. Run `vercel ls` — confirm new deployment appears
2. Wait for "Ready" status
3. Hit live URL — confirm it responds
4. If build fails, check `vercel logs` immediately

---

*Planning → Main context | Building → Executors | Checking → Reviewer | Logs → audit_log.md | Temp → temporary/YYYYMMDD-\*.md | Files → FILE_MAP.md*
