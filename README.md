# Claude Code Beginner Guide

A starter kit for non-developers using Claude Code to build software safely and effectively.

> 🇹🇼 本專案以繁體中文撰寫，專為不懂程式但想用 AI 寫程式的人設計。

---

## 這是什麼？

當你要開始用 Claude Code 開發程式的時候，有一些重要的事情需要注意：

- 🔐 **密鑰安全**：不小心把 API Key 上傳到 GitHub，可能隔天就收到天價帳單
- 🧪 **測試習慣**：AI 寫的程式看起來能跑，不代表真的正確
- 📝 **版本控制**：沒有存檔習慣，改壞了就回不去了
- ⚠️ **錯誤處理**：程式出錯但沒提示，根本不知道問題在哪

**但問題是：初學者通常不知道這些事情。**

這個專案的目的，就是**把這些注意事項預先告訴 Claude Code**，讓它在幫你寫程式的時候，自動遵守這些最佳實踐。

你只需要把我們提供的 `CLAUDE.md` 放到專案裡，Claude Code 就會自動：
- 幫你建立安全的開發環境
- 在開發過程中持續遵守這些規則
- 用白話解釋它寫的每一段程式

---

## What's Inside

| File | Purpose | Audience |
|------|---------|----------|
| [guide-for-beginners.md](./guide-for-beginners.md) | Plain-language guide explaining what to watch out for when using AI to code | Complete beginners (non-developers) |
| [vibe-coding-survival-guide.md](./vibe-coding-survival-guide.md) | Advanced guide: 6-step Vibe Coding workflow with Plan Mode | Beginners ready to start coding |
| [CLAUDE.md](./CLAUDE.md) | Drop-in config file that auto-bootstraps a safe Claude Code environment | Anyone using Claude Code |
| [DISCUSSION-HISTORY.md](./DISCUSSION-HISTORY.md) | Design decisions and evolution of this project | Contributors / Claude Code |
| [INSTALL.md](./INSTALL.md) | Installation instructions for Claude Code to follow | Claude Code |

### Skills（Claude Code 技能）

| File | Purpose |
|------|---------|
| [skills/vibe-coding-workflow.md](./skills/vibe-coding-workflow.md) | 6-step development workflow skill (Plan → Test → Implement → Review → Refactor → Merge) |
| [skills/security-check.md](./skills/security-check.md) | Pre-push security scanner for detecting leaked secrets |

## 安裝方式 (Installation)

### 最簡單的方式：讓 Claude Code 幫你安裝（推薦）

1. 開啟終端機，進入你的專案資料夾
2. 啟動 Claude Code：
   ```bash
   claude
   ```
3. 對 Claude 說：
   > 請幫我從 https://github.com/chihao919/tip 安裝開發工具包

Claude 會自動：
- 下載並安裝技能（skills）
- 設定專案環境（.gitignore、安全規則等）
- 確認一切都準備好了

### 手動安裝

如果你想手動安裝：

**Step 1：下載專案**
```bash
git clone https://github.com/chihao919/tip.git
```

**Step 2：安裝 Skills（一次性）**
```bash
mkdir -p ~/.claude/skills
cp tip/skills/*.md ~/.claude/skills/
```

**Step 3：複製 CLAUDE.md 到你的專案**
```bash
cp tip/CLAUDE.md your-project/
```

---

## Quick Start

### 1. 先閱讀入門指南

閱讀 [guide-for-beginners.md](./guide-for-beginners.md) 了解基本概念：
密鑰安全、測試、版本控制，以及如何有效地與 AI 合作。

### 2. 安裝 Skills + CLAUDE.md

按照上面的「安裝方式」完成：
1. 安裝 skills（一次性）
2. 把 CLAUDE.md 放到你的專案

### 3. 開始開發！

Claude Code 啟動後會問你：*「要我自動執行所有設定步驟，還是逐一列出讓你確認？」*

選擇你喜歡的方式，讓 Claude 處理剩下的事。

---

## 安裝後你會得到什麼？

**CLAUDE.md 自動執行：**
- 🔐 建立 `.claude/settings.json` 安全規則
- 📄 建立 `.gitignore` 和 `.env.example`
- ✅ 驗證整個安全設定

**Skills 提供的能力：**
- 📋 `vibe-coding-workflow` — 用 6 步驟流程開發功能
- 🔒 `security-check` — 推送前自動檢查密鑰洩漏

**持續遵守的規則：**
- 永遠不硬編碼密鑰
- 每個功能都寫測試
- 正確處理錯誤
- 先規劃再寫程式
- 用白話解釋程式碼

## Why This Exists

AI coding tools are powerful, but beginners often miss critical practices like secret management and testing.
This project packages those best practices into two simple files:
one for humans to read, and one for Claude Code to execute.

## Requirements

- [Claude Code](https://www.anthropic.com/claude-code) (Pro, Max, Team, or Enterprise plan)
- A terminal / command line
- Git installed

## Contributing

Found something missing or outdated? PRs and issues are welcome.

## License

MIT
