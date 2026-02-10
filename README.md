# Claude Code Beginner Guide

A starter kit for non-developers using Claude Code to build software safely and effectively.

> 🇹🇼 本專案以繁體中文撰寫，專為不懂程式但想用 AI 寫程式的人設計。

---

## What's Inside

| File | Purpose | Audience |
|------|---------|----------|
| [guide-for-beginners.md](./guide-for-beginners.md) | Plain-language guide explaining what to watch out for when using AI to code | Complete beginners (non-developers) |
| [CLAUDE.md](./CLAUDE.md) | Drop-in config file that auto-bootstraps a safe Claude Code environment | Anyone using Claude Code |

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
