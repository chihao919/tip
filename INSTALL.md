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

## 方法一：一鍵安裝（推薦）

使用者可以直接執行以下指令：

```bash
curl -fsSL https://raw.githubusercontent.com/chihao919/tip/main/install.sh | bash
```

這會自動：
- 下載所有 Skills 到 `~/.claude/skills/`
- 詢問是否複製 CLAUDE.md 到當前專案
- 顯示安裝結果報告

---

## 方法二：Claude Code 自動安裝

如果使用者在 Claude Code 中請求安裝，按照以下步驟執行：

### Step 1: Install Skills (One-time setup)

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
  - debugging-guide（系統化除錯指南）
  - code-review（自我程式碼審查）
  - project-kickoff（專案快速啟動）
```

---

### Step 2: Copy CLAUDE.md to User's Project

Copy `CLAUDE.md` to the user's current working directory (their project root):

```bash
cp CLAUDE.md <user's project directory>/
```

If the user is already in their project directory:
```bash
cp CLAUDE.md ./
```

---

### Step 3: Run Initial Setup

Now execute the setup steps defined in CLAUDE.md Section 1:

#### 3.1 Create Security Configuration

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

#### 3.2 Create .gitignore

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

#### 3.3 Create .env.example (if project uses environment variables)

```
# Copy this file to .env and fill in your actual values
# NEVER commit .env to version control

API_KEY=your_api_key_here
DATABASE_URL=your_database_url_here
```

---

### Step 4: Verify and Report

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
  ✅ debugging-guide（系統化除錯指南）
  ✅ code-review（自我程式碼審查）
  ✅ project-kickoff（專案快速啟動）

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

其他可用技能：
  🐛 遇到 bug？跟我說「幫我 debug」
  🔍 想審查程式碼？跟我說「幫我 code review」
  🚀 要開新專案？跟我說「幫我建立新專案」
```

---

## 方法三：手動安裝

使用者也可以完全手動操作：

```bash
# 1. 下載專案
git clone https://github.com/chihao919/tip.git

# 2. 安裝所有技能（一次性）
mkdir -p ~/.claude/skills
cp tip/skills/*.md ~/.claude/skills/

# 3. 複製 CLAUDE.md 到你的專案
cp tip/CLAUDE.md your-project/
```

---

## 更新已安裝的 Skills

重新執行一鍵安裝指令即可更新：

```bash
curl -fsSL https://raw.githubusercontent.com/chihao919/tip/main/install.sh | bash
```

或手動更新：

```bash
git -C tip pull
cp tip/skills/*.md ~/.claude/skills/
```

---

## Notes for Claude Code

- If the user's project already has `.gitignore`, append missing entries instead of overwriting
- If the user's project already has `.claude/settings.json`, merge the deny rules
- Always explain what you're doing in plain language (繁體中文)
- If anything fails, explain the problem and how to fix it
