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
| [vibe-coding-workflow.md](./vibe-coding-workflow.md) | Claude Code skill definition for the 6-step workflow (English, for AI) | Claude Code / Contributors |
| [DISCUSSION-HISTORY.md](./DISCUSSION-HISTORY.md) | Design decisions and evolution of this project | Contributors / Claude Code |

## 安裝方式 (Installation)

### 方法一：讓 Claude Code 幫你安裝（推薦給初學者）

如果你已經安裝了 Claude Code，只要在終端機輸入以下指令：

```bash
claude
```

然後對 Claude 說：

> 請幫我從 https://github.com/chihao919/tip 下載 CLAUDE.md 和 guide-for-beginners.md 到我的專案根目錄

Claude 會自動幫你下載並設定好一切。

### 方法二：手動下載

1. 點擊上方的綠色 **Code** 按鈕
2. 選擇 **Download ZIP**
3. 解壓縮後，把 `CLAUDE.md` 複製到你的專案根目錄

### 方法三：使用 Git Clone

```bash
# 複製整個專案
git clone https://github.com/chihao919/tip.git

# 或者只下載 CLAUDE.md 到當前目錄
curl -O https://raw.githubusercontent.com/chihao919/tip/master/CLAUDE.md
```

---

## Quick Start

### For beginners: Read the guide first

Read [guide-for-beginners.md](./guide-for-beginners.md) to understand the key concepts:
security, testing, version control, and how to work with AI effectively.

### For projects: Drop in CLAUDE.md

1. Copy `CLAUDE.md` to the root of your project
2. Start Claude Code in that project
3. Claude will ask: *"Do you want me to run all setup steps automatically, or list them for you to confirm one by one?"*
4. Choose your preference and let Claude handle the rest

**What CLAUDE.md does automatically:**
- 🔐 Creates `.claude/settings.json` with security deny rules
- 📄 Creates `.gitignore` and `.env.example`
- ✅ Verifies the entire security setup

**What CLAUDE.md enforces as ongoing rules:**
- Never hard-code secrets
- Write tests for every feature
- Handle errors properly
- Plan before coding
- Explain code in plain language

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
