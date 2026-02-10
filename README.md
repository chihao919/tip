# Claude Code Beginner Guide

A starter kit for non-developers using Claude Code to build software safely and effectively.

> 🇹🇼 本專案以繁體中文撰寫，專為不懂程式但想用 AI 寫程式的人設計。

---

## What's Inside

| File | Purpose | Audience |
|------|---------|----------|
| [guide-for-beginners.md](./guide-for-beginners.md) | Plain-language guide explaining what to watch out for when using AI to code | Complete beginners (non-developers) |
| [CLAUDE.md](./CLAUDE.md) | Drop-in config file that auto-bootstraps a safe Claude Code environment | Anyone using Claude Code |

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
