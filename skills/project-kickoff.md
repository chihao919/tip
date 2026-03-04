---
name: project-kickoff
description: >
  Project quick start skill for initializing a new project from scratch.
  Use when the user wants to start a brand new project, not just add a feature.
  Guides through 5 clarifying questions, auto-selects tech stack with reasoning,
  generates project structure, and creates PLAN.md. Complements
  vibe-coding-workflow (which handles per-feature development after kickoff).
---

# 專案快速啟動

要開始一個全新的專案？太好了，讓我們打好地基再開始蓋房子。

這個技能負責「整個專案的第一次」：搞清楚你要做什麼、選好工具、建好骨架，然後把後續的功能開發交給 `vibe-coding-workflow`。

---

## 使用時機

- 從零開始一個新專案
- 有想法但不知道從哪裡下手
- 想知道「我應該用什麼技術」

**不適用：**
- 已有專案，想加新功能 → 用 `vibe-coding-workflow`
- 已有專案，想修 bug → 用 `vibe-coding-workflow`

---

## 啟動流程

### 第一階段：釐清你的想法

先說：「告訴我你想做什麼，隨便說都可以，不用完整。」

讓使用者自由表達，然後根據他說的內容，問以下五個方向的問題（根據他的狀況選最相關的問，不要全部問）：

```
1. 這個東西要解決什麼問題？誰會用到它？
   （了解使用情境和目標用戶）

2. 使用者主要用手機還是電腦？還是兩個都要？
   （決定是否需要 mobile-first 或 PWA）

3. 需要帳號登入系統嗎？用戶的資料要存起來嗎？
   （決定是否需要後端和資料庫）

4. 你有沒有看過類似的東西？可以給我一個參考嗎？
   （快速對齊視覺和功能期待）

5. 這個專案是自己用、小團隊用，還是要給很多人用？
   （決定規模和複雜度）
```

問完之後，用自己的話重述一遍你的理解，問：「我理解的對嗎？有沒有我搞錯的地方？」

---

### 第二階段：選擇技術棧

根據回答，推薦技術棧並**解釋為什麼**：

#### 技術棧選擇邏輯

**純前端（沒有後端、沒有資料庫）：**
```
Recommended:
- Framework: React (with Vite for fast setup)
- Styling: Tailwind CSS
- Deployment: Vercel

Why: The project only needs UI with no data persistence.
React + Vite gets you running in under 5 minutes.
No backend means no server costs and faster iteration.
```

**需要後端 + 資料庫：**
```
Recommended:
- Frontend: React (with Vite)
- Backend: Node.js + Express (or Next.js for full-stack in one repo)
- Database: PostgreSQL (for structured data) or MongoDB (for flexible data)
- Deployment: Vercel (frontend) + Railway/Render (backend)

Why: Next.js lets you write frontend and backend in one repo,
which is simpler for small teams. PostgreSQL is reliable and
well-supported everywhere.
```

**快速原型 / Landing Page：**
```
Recommended:
- Next.js (full-stack, easy to deploy)
- Tailwind CSS
- Vercel

Why: Next.js gives you routing, API routes, and deployment
in one package. Perfect for moving fast.
```

**工具 / CLI / 腳本：**
```
Recommended:
- Python (if data processing or automation)
- Node.js (if integrating with web APIs)

Why: Python has the best ecosystem for data and automation.
Node.js is better when you're already in a JavaScript project.
```

呈現推薦後，問：「這個方向可以嗎？或者你有特別偏好某個技術？」

---

### 第三階段：生成專案結構

確認技術棧後，生成對應的專案結構，用 tree 格式呈現：

**React + Vite 範例：**
```
my-project/
├── public/
│   └── favicon.ico
├── src/
│   ├── components/       # reusable UI components
│   │   └── Button.jsx
│   ├── pages/            # page-level components
│   │   └── Home.jsx
│   ├── hooks/            # custom React hooks
│   ├── services/         # API calls and external integrations
│   ├── utils/            # helper functions
│   ├── App.jsx
│   └── main.jsx
├── .env.example          # template for environment variables
├── .gitignore
├── index.html
├── package.json
├── vite.config.js
└── PLAN.md               # feature roadmap (generated next)
```

**Next.js 範例：**
```
my-project/
├── app/                  # Next.js App Router
│   ├── api/              # API routes (backend)
│   │   └── users/
│   │       └── route.js
│   ├── (pages)/          # page routes
│   │   └── page.jsx
│   ├── layout.jsx
│   └── globals.css
├── components/           # reusable UI components
├── lib/                  # database clients, utilities
├── hooks/                # custom React hooks
├── .env.example
├── .gitignore
├── package.json
├── next.config.js
└── PLAN.md
```

---

### 第四階段：生成 PLAN.md

根據使用者描述的功能，生成一份 PLAN.md：

```markdown
# Project Name — Development Plan

## Goal
[One paragraph describing what this project does and who it's for]

## Tech Stack
- Frontend: [chosen tech]
- Backend: [chosen tech or "N/A"]
- Database: [chosen tech or "N/A"]
- Deployment: [chosen platform]

## Features Roadmap

### Phase 1: Foundation (start here)
- [ ] Project setup and basic routing
- [ ] [Core feature 1] — [brief description]
- [ ] [Core feature 2] — [brief description]

### Phase 2: Core Features
- [ ] [Feature 3] — [brief description]
- [ ] [Feature 4] — [brief description]

### Phase 3: Polish
- [ ] [Feature 5] — [brief description]
- [ ] Error handling and edge cases
- [ ] Mobile responsiveness check

## Out of Scope (for now)
- [Things the user mentioned but decided to defer]
- [Features that would overcomplicate Phase 1]

## Open Questions
- [Any decisions not yet made]
- [Technical risks to investigate]
```

---

### 第五階段：初始化專案

確認計劃後，執行以下步驟：

```bash
# 1. Create project with chosen framework
# (show the actual command based on tech stack)

# React + Vite:
npm create vite@latest my-project -- --template react

# Next.js:
npx create-next-app@latest my-project --typescript --tailwind --app

# 2. Create the folder structure
mkdir -p src/components src/pages src/hooks src/services src/utils

# 3. Create .env.example
# (populate based on what services the project will use)

# 4. Create .gitignore
# (standard template from CLAUDE.md)

# 5. Initialize git and make first commit
git init
git add .
git commit -m "feat: initial project setup"

# 6. Create GitHub repo (optional, ask first)
gh repo create my-project --public --source=. --push
```

---

## 完成後的交接

Kickoff 完成後，說：

「專案骨架建好了！接下來每次要開發一個功能，就用 `vibe-coding-workflow` 來規劃和實作。

現在可以從 PLAN.md 的 Phase 1 開始，告訴我你想先做哪一個功能。」

---

## 注意事項

- **不要過度設計**：Phase 1 的結構要越簡單越好，不要預先建立「以後可能會用到」的資料夾
- **先問再選**：技術棧一定要讓使用者確認，不要自行決定
- **PLAN.md 是活文件**：隨著開發進展可以修改，不是刻在石頭上的
- **不要一次建太多功能**：Phase 1 最多三到四個功能，其他的放後面的 Phase
