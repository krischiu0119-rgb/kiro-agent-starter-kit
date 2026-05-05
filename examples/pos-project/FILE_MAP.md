<!-- 2026-05-05 -->
<!-- EXAMPLE: This is a real FILE_MAP.md from the EasyClean POS project. -->
<!-- It demonstrates how to document file placement rules for a medium-sized Next.js app. -->
<!-- Notice: tables for each directory, explicit rules, and "where to put new things" guidance. -->

# POS File Map — 檔案放置規則

## 規則
1. **建立新檔案前**，先查閱此地圖，確認沒有重複功能的檔案
2. **新檔案必須放在對應的目錄**，不可隨意放置
3. **如果不確定放哪裡**，在 prompt 回覆中提出，由 main agent 決定

---

## pos/app/ — 頁面（Next.js App Router）

| 路徑 | 用途 | 備註 |
|------|------|------|
| `page.tsx` | 首頁：員工選擇 + PIN + 地點切換 | |
| `layout.tsx` | 全域 layout：metadata + viewport + SW 註冊 | |
| `globals.css` | 全域樣式：Tailwind + iOS 修復 + select 箭頭 | |
| `pos/page.tsx` | 結帳：產品選單 + 購物車 + 促銷 + 折扣 | 最複雜的頁面 |
| `pos/layout.tsx` | POS 子 layout：CartProvider 包裹 | |
| `pos/payment/page.tsx` | 付款：付款方式 + 金額驗證 + 交易儲存 | |
| `pos/return/page.tsx` | 退貨/退款/作廢：統一入口 | 含 void 流程 |
| `daily-open/page.tsx` | 日開：庫存 + 現金 + 出勤 + 據點 | |
| `daily-close/page.tsx` | 日結：盤點 + Google Sheets 同步 | |
| `inventory/page.tsx` | 庫存調整：損壞/樣品/退貨/其他 | |
| `report/page.tsx` | 營業報表：統計 + WoW + 員工排行 | |
| `manager/page.tsx` | 員工管理：CRUD + PIN 重設 + 據點指派 | 管理者模式 |
| `locations/page.tsx` | 地點管理：人員配置 + 在地貨件 + 庫存警告 | 管理者模式 |
| `inventory-overview/page.tsx` | 庫存總覽：所有據點庫存概況 + 補貨提醒 | 管理者模式 |
| `api/google/daily-close/route.ts` | API：日結 → Google Sheets + Drive | Server-side |
| `components/OfflineBanner.tsx` | 離線提示橫幅 | |
| `components/ServiceWorkerRegistration.tsx` | SW 註冊 | |

**新頁面規則**：每個功能一個目錄，檔名固定 `page.tsx`。共用元件放 `components/`。

---

## pos/lib/ — 核心邏輯

| 檔案 | 用途 | 行數 | 備註 |
|------|------|------|------|
| `types.ts` | 所有 TypeScript 型別定義 | ~120 | Product, CartItem, Transaction, DailyOpenRecord 等 |
| `storage.ts` | Supabase + localStorage 資料層 | ~900 | 所有 CRUD、員工 PIN、離線佇列 |
| `promo-engine.ts` | 促銷匹配引擎 | ~250 | 回溯演算法，4 個 PROMO |
| `shipping.ts` | 運費計算 | ~20 | ≥$1,590 免運 |
| `format.ts` | 金額格式化 / 日期 / ID 生成 | ~50 | formatPrice, getTodayDate, generateTransactionId |
| `google.ts` | Google Sheets + Drive API | ~200 | appendDailyCloseRow, uploadReceiptPhoto |
| `supabase.ts` | Supabase client singleton | ~15 | createClient |

**新 lib 規則**：
- 工具函數 → 先看 `format.ts` 是否已有類似功能
- 資料存取 → 加到 `storage.ts`，不要建新檔案
- 型別定義 → 加到 `types.ts`，不要建新檔案
- 只有全新的獨立領域才建新 lib 檔案（如 `google.ts` 是獨立的 API 整合）

---

## pos/data/ — 靜態資料

| 檔案 | 用途 | Source of Truth |
|------|------|----------------|
| `products.json` | 12 SKU 產品資料 | `data/一級淨_產品主檔.md` |
| `promotions.json` | 4 個促銷組合 | `data/一級淨_市售價格及產品表.md` |

**規則**：這兩個 JSON 是從 Markdown source of truth 複製的。修改產品/促銷時，先改 Markdown，再同步 JSON。

---

## pos/ 根目錄 — 配置檔

| 檔案 | 用途 |
|------|------|
| `package.json` | npm 依賴和 scripts |
| `tsconfig.json` | TypeScript 配置（strict mode） |
| `next.config.ts` | Next.js 配置 |
| `eslint.config.mjs` | ESLint 配置 |
| `postcss.config.mjs` | PostCSS / Tailwind CSS 4 配置 |
| `next-env.d.ts` | Next.js 自動生成的型別宣告（不要手動修改） |
| `PROJECT_BRIEF.md` | 專案摘要（sub-agent 必讀） |
| `FILE_MAP.md` | 本檔案 — 檔案放置規則 |
| `CLAUDE.md` | Claude Code / Cowork 指令 |
| `AGENTS.md` | Sub-agent 架構說明 |
| `README.md` | POS app 說明 |

---

## pos/contexts/ — React Context

| 檔案 | 用途 |
|------|------|
| `CartContext.tsx` | 購物車狀態管理 + sessionStorage 持久化 |

**規則**：新的全域狀態優先考慮加到現有 Context，而非建立新的 Context。

---

## pos/temporary/ — 遷移腳本和測試

| 用途 | 命名格式 |
|------|---------|
| SQL 遷移 | `YYYYMMDD-description.sql` |
| 測試/驗證腳本 | `YYYYMMDD-description.mjs` |

**規則**：所有暫存腳本放這裡，不放根目錄或其他地方。

---

## pos/public/ — 靜態資源

| 目錄/檔案 | 用途 |
|-----------|------|
| `products/*.png` | 產品圖片（以 SKU 命名） |
| `icons/` | PWA icons |
| `manifest.json` | PWA manifest |
| `sw.js` | Service Worker |

---

## 根目錄 data/ — 產品主檔（Source of Truth）

| 檔案 | 用途 |
|------|------|
| `一級淨_產品主檔.md` | SKU 唯一來源，所有產品引用以此為準 |
| `一級淨_B2B_成本價格.md` | B2B 報價單 |
| `一級淨_市售價格及產品表.md` | 快閃櫃活動訂購單 + 促銷組合定義 |

**規則**：這些是 source of truth，POS 的 JSON 從這裡同步。不要直接改 JSON。
