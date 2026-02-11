# Installation Instructions

> This file is for Claude Code to read when a user asks to install this toolkit.
> Follow these steps in order.

---

## When to Use This

When the user says things like:
- "幫我安裝"
- "Install this for me"
- "Set up this toolkit"
- "下載並設定"

---

## Step 1: Install Skills (One-time setup)

Copy the skill files to the user's Claude Code skills directory:

```bash
# Create skills directory if it doesn't exist
mkdir -p ~/.claude/skills

# Copy all skills
cp skills/*.md ~/.claude/skills/
```

After copying, confirm to the user:
```
✅ 已安裝以下技能：
  - vibe-coding-workflow（6 步驟開發流程）
  - security-check（推送前安全檢查）
```

---

## Step 2: Copy CLAUDE.md to User's Project

Copy `CLAUDE.md` to the user's current working directory (their project root):

```bash
cp CLAUDE.md <user's project directory>/
```

If the user is already in their project directory:
```bash
cp CLAUDE.md ./
```

---

## Step 3: Run Initial Setup

Now execute the setup steps defined in CLAUDE.md Section 1:

### 3.1 Create Security Configuration

If `.claude/settings.json` does not exist in the project, create it:

```json
{
  "permissions": {
    "deny": [
      "Bash(cat .env*)",
      "Bash(cat */.env*)",
      "Bash(*secret*)",
      "Bash(*password*)",
      "Bash(*.pem)",
      "Bash(*.key)"
    ]
  }
}
```

### 3.2 Create .gitignore

If `.gitignore` does not exist, create one with:

```
# Secrets
.env
.env.*
.env.local

# Dependencies
node_modules/
vendor/
__pycache__/
*.pyc
venv/
.venv/

# Build outputs
dist/
build/
.next/
out/

# OS files
.DS_Store
Thumbs.db
```

### 3.3 Create .env.example (if project uses environment variables)

```
# Copy this file to .env and fill in your actual values
# NEVER commit .env to version control

API_KEY=your_api_key_here
DATABASE_URL=your_database_url_here
```

---

## Step 4: Verify and Report

Run these checks:

1. `.gitignore` exists and contains `.env`
2. `.claude/settings.json` exists with deny rules
3. No hardcoded secrets in project files

Then report to the user in this format:

```
✅ 安裝完成！

已安裝的技能：
  ✅ vibe-coding-workflow（6 步驟開發流程）
  ✅ security-check（推送前安全檢查）

專案環境設定：
  ✅ .gitignore 已建立，包含 .env
  ✅ .claude/settings.json 已建立，包含安全規則
  ✅ 未發現硬編碼的密鑰

---

🎉 你可以開始開發了！

當你想要開發新功能時，只要跟我說：
「我想要做 XXX 功能」

我會自動用 6 步驟流程帶你完成：
1. 規劃 → 2. 寫測試 → 3. 實作 → 4. 審查 → 5. 重構 → 6. 合併

推送程式碼前，我會自動檢查有沒有不小心把密鑰寫進去。
```

---

## Notes for Claude Code

- If the user's project already has `.gitignore`, append missing entries instead of overwriting
- If the user's project already has `.claude/settings.json`, merge the deny rules
- Always explain what you're doing in plain language (繁體中文)
- If anything fails, explain the problem and how to fix it
