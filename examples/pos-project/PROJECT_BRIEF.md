<!-- 2026-05-05 -->
<!-- EXAMPLE: A filled-in PROJECT_BRIEF for the EasyClean POS project. -->
<!-- This is what sub-agents read to understand the project without needing other docs. -->

# EasyClean POS — Project Brief

> Sub-agents read this file to understand the project. No other docs needed for context.

## What Is This?

iPad-first web POS system for **一級淨 (EasyClean)** — a cleaning products brand that sells through pop-up retail counters (快閃櫃) in department stores across Taiwan.

Staff use mobile browsers (primarily iPad) to:
- Ring up sales and process payments
- Open/close daily shifts with inventory counts
- Manage stock across multiple locations
- Generate sales reports synced to Google Sheets

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Framework | Next.js 15 (App Router) + React 19 + TypeScript 5 |
| Styling | Tailwind CSS 4 |
| Database | Supabase PostgreSQL + localStorage (offline fallback) |
| APIs | Google Sheets API + Google Drive API (daily reports) |
| Hosting | Vercel (auto-deploy on push) |
| Target | Mobile Safari on iPad (PWA-capable) |

## Key Business Rules

### Products & SKUs
- 12 active SKUs across 6 categories
- SKU format: `EC-{category}-{number}` (e.g., `EC-CL-001`)
- Categories: CL (cleaner), SH (shampoo), MA (mask), AC (accessory), FB (fabric), OD (odor)
- Source of truth: `data/一級淨_產品主檔.md` → synced to `pos/data/products.json`

### Pricing
- All prices in TWD, tax-inclusive
- Display format: `$1,590` (comma-separated thousands)
- Free shipping threshold: ≥ $1,590

### Promotions
- 4 active promotion combos (PROMO-1 through PROMO-4)
- Matched by a backtracking algorithm (`lib/promo-engine.ts`)
- Source of truth: `data/一級淨_市售價格及產品表.md` → synced to `pos/data/promotions.json`

### Security
- Employee PIN stored as SHA-256 hash
- "管理者" (Manager) account always retains admin privileges
- Manager mode required for: employee CRUD, location management, inventory overview

## Project Structure (Key Files)

```
pos/
├── app/              ← 12 pages (Next.js App Router)
├── lib/
│   ├── storage.ts    ← Data layer (~900 lines, largest file)
│   ├── promo-engine.ts ← Promotion matching
│   ├── format.ts     ← Price formatting, dates, IDs
│   └── google.ts     ← Google Sheets/Drive integration
├── contexts/         ← CartContext (shopping cart state)
├── data/             ← products.json + promotions.json
└── temporary/        ← Migration scripts, test runners
```

## Verification Commands

```bash
cd pos && npm run build              # Must pass — zero errors
node temporary/20260504-qa-runner.mjs  # 33 automated checks
```

## Current Status

- **Stage 1 MVP**: 95% complete
- **Deployed**: https://pos-two-azure.vercel.app
- **Database**: Supabase migrations executed, all tables live
- **Remaining**: ESLint cleanup (13 errors), iOS Safari fixes (6 items), performance optimization

## What NOT to Do

- Don't edit `products.json` or `promotions.json` directly — change the Markdown source first
- Don't create new type files — add types to `lib/types.ts`
- Don't create new data access files — add functions to `lib/storage.ts`
- Don't DROP or TRUNCATE database tables — migrations are additive only
- Don't assume `git push` = deployed — always verify with `vercel ls`
