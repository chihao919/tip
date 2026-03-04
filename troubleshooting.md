# 🔧 故障排除指南 Troubleshooting

> 當事情不如預期，先別慌。大部分問題都有固定的解法，這裡幫你一一拆解 💪

---

## 問題 1：Claude Code 沒有讀 CLAUDE.md

你在 CLAUDE.md 裡寫了一堆規則，但 AI 完全沒有照做？這是最常見的問題之一。

### 可能原因與解法

**原因 A：檔案位置不對**

CLAUDE.md 必須放在「專案根目錄」，也就是你用 Claude Code 打開的那個資料夾的最頂層。

```
your-project/          ← 這裡才是根目錄
├── CLAUDE.md          ✅ 正確位置
├── src/
│   └── CLAUDE.md      ❌ 不會被自動讀取
└── README.md
```

如果你的 CLAUDE.md 被放在子資料夾裡，把它移到根目錄。

**原因 B：檔名大小寫錯誤**

檔名是**大小寫敏感**的，一定要完全一樣：

```bash
# Correct
CLAUDE.md

# Wrong - will NOT be recognized
claude.md
Claude.md
CLAUDE.MD
```

在 macOS 上你可能不會發現差別（因為 macOS 預設不區分大小寫），但最好還是對的。

**原因 C：Claude Code 需要重啟**

改了 CLAUDE.md 之後，Claude Code 不一定會即時讀到新的內容。

```
關閉 Claude Code → 重新開啟 → 重新開始對話
```

**原因 D：全域 CLAUDE.md 衝突**

如果你同時有 `~/.claude/CLAUDE.md`（全域）和專案裡的 `CLAUDE.md`，它們都會生效，但有時候指令互相矛盾會造成行為不一致。檢查兩個檔案有沒有衝突的設定。

### 快速確認清單

- [ ] 檔案在專案根目錄？
- [ ] 檔名是 `CLAUDE.md`（全大寫）？
- [ ] 已經重啟 Claude Code？
- [ ] 對話是新開的，不是舊的繼續？

---

## 問題 2：Skills 沒有出現

你安裝了 Skills，但輸入指令沒有反應，或是 AI 說不知道這個指令？

### 可能原因與解法

**原因 A：安裝路徑不對**

Skills 必須安裝在這個路徑：

```bash
~/.claude/skills/

# Check if the path exists
ls ~/.claude/skills/

# If it doesn't exist, create it
mkdir -p ~/.claude/skills/
```

**原因 B：YAML frontmatter 格式錯誤**

每個 Skill 檔案最上面必須有正確格式的 YAML frontmatter，缺少或格式錯誤都會讓 Skill 失效。

一個正確的 Skill 檔案長這樣：

```markdown
---
name: my-skill
description: What this skill does
trigger: /my-command
---

# Skill content starts here...
```

常見錯誤：
- 忘記三個破折號 `---`
- `name` 裡有特殊字元或空格
- YAML 縮排不一致（YAML 對縮排很挑剔）

**原因 C：Claude Code 需要重啟**

這是最常見的解法！安裝新 Skill 之後一定要重啟：

```
關閉 Claude Code 完全退出 → 重新開啟
```

**原因 D：指令觸發方式不對**

確認你的輸入方式跟 Skill 定義的 `trigger` 完全一樣：

```bash
# If trigger is defined as:
trigger: /security-check

# You must type exactly:
/security-check

# NOT:
security-check
/Security-Check
```

### 快速確認清單

- [ ] Skills 在 `~/.claude/skills/` 目錄？
- [ ] 檔案有正確的 YAML frontmatter？
- [ ] 已重啟 Claude Code？
- [ ] 指令輸入完全正確（包含 `/`）？

---

## 問題 3：測試一直失敗

你叫 AI 寫了程式碼，也寫了測試，但跑起來一直紅燈 🔴 別緊張，通常是這幾個原因。

### 常見原因

**原因 A：缺少套件/依賴沒裝**

```bash
# For Node.js projects
npm install
# or
yarn install
# or
pnpm install

# For Python projects
pip install -r requirements.txt
# or
poetry install
```

很多時候你拉了新的程式碼，但忘了更新依賴。

**原因 B：Node.js 或 Python 版本不對**

這個超級常見！AI 寫的程式碼可能用了新版本的語法。

```bash
# Check your current versions
node --version
python --version

# Check what version the project requires
cat .nvmrc         # for Node
cat .python-version  # for Python

# Switch versions if needed (using nvm for Node)
nvm use
# or
nvm use 20
```

**原因 C：環境變數沒有設定**

測試通常需要環境變數，但你的 `.env` 檔案不會 commit 到 git。

```bash
# Check if you have a .env file
ls -la .env

# If not, check if there's an example
cat .env.example
# Then copy and fill in your values
cp .env.example .env
```

**原因 D：測試環境跟執行環境不同**

```bash
# Make sure you're running tests in the right environment
# For Node.js
NODE_ENV=test npm test

# Check the test command in package.json
cat package.json | grep -A5 '"scripts"'
```

### Debug 步驟

1. 看清楚錯誤訊息 — 通常第一行就告訴你問題在哪
2. 只跑單一測試檔案縮小範圍：
   ```bash
   # Jest
   npx jest path/to/specific.test.js
   # pytest
   pytest tests/test_specific.py -v
   ```
3. 在測試中加 console.log / print 確認值是否如預期
4. 把錯誤訊息貼給 Claude Code，讓它幫你分析

---

## 問題 4：Git Push 被擋

你要 push 程式碼，但被 security-check 或其他 hook 阻止了？

### security-check 擋住了 Push

這個是**故意的** — security-check 偵測到你的程式碼裡可能有敏感資訊（API Key、密碼等），為了保護你才擋下來。

**不要強制跳過它**，先確認問題再處理：

```bash
# Run security check manually to see what it found
/security-check
```

**如果是真的有問題（有 Key 或密碼）：**

1. 把敏感資訊移到 `.env` 檔案
2. 在程式碼裡改用環境變數引用
3. 把 `.env` 加到 `.gitignore`
4. 重新 commit 後再 push

```bash
# Example: instead of hardcoding
# const apiKey = "sk-xxxxx"

# Use environment variable
# const apiKey = process.env.OPENAI_API_KEY

# In .env file (NOT committed to git)
# OPENAI_API_KEY=sk-xxxxx
```

**如果是誤報（假警報）：**

確認 security-check 標記的內容確實不是敏感資訊（例如它把 "example-key" 這個字串誤判了），可以在 CLAUDE.md 裡說明讓它忽略。

### 一般 Git Hook 失敗

如果是其他 pre-commit hook（例如 lint、format 檢查）失敗：

```bash
# See what hooks are installed
ls .git/hooks/

# Run the failing check manually
npm run lint
npm run format

# Fix the issues, then add and commit again
git add .
git commit -m "fix: resolve lint issues"
```

---

## 問題 5：API Key 不小心 Commit 了

這很嚴重，但可以處理。**按照順序做，不要跳步驟！**

### Step 1：立刻撤銷那把 Key（最優先）

不管後面的步驟怎樣，Key 只要還有效就是風險。馬上去對應服務的控制台把它作廢：

| 服務 | 撤銷 Key 的地方 |
|------|-----------------|
| OpenAI | platform.openai.com → API Keys |
| Anthropic | console.anthropic.com → API Keys |
| GitHub | Settings → Developer settings → Personal access tokens |
| AWS | IAM Console → Users → Security credentials |
| Google Cloud | Cloud Console → APIs & Services → Credentials |

撤銷後立刻產生一把新的 Key 備用。

### Step 2：從 Git 歷史移除

Key 已撤銷所以沒有安全疑慮了，但為了整潔還是要清除。

**方法 A：使用 BFG Repo Cleaner（推薦，比較簡單）**

```bash
# Install BFG (requires Java)
brew install bfg

# Create a file with the secrets to remove
echo "your-api-key-here" > secrets.txt

# Run BFG to remove it from all history
bfg --replace-text secrets.txt your-repo.git

# Force push to remote (this rewrites history)
git push --force
```

**方法 B：使用 git filter-branch（內建工具，較複雜）**

```bash
# Remove a specific file from all history
git filter-branch --force --index-filter \
  'git rm --cached --ignore-unmatch path/to/file-with-secret' \
  --prune-empty --tag-name-filter cat -- --all

# Force push
git push origin --force --all
git push origin --force --tags
```

**方法 C：如果是剛剛 commit 的（最後一個 commit）**

```bash
# Remove the secret from the file first
# Then amend the commit
git add .
git commit --amend

# If not yet pushed, that's all
# If already pushed, force push
git push --force
```

> ⚠️ `git push --force` 會改寫遠端歷史，如果有其他人也在用這個 repo，先通知他們。

### Step 3：預防下次再發生

```bash
# .gitignore - add these patterns
.env
.env.local
.env.production
*.key
*.pem
secrets/
credentials/
```

養成習慣：**密鑰永遠放在 `.env`，程式碼裡只用 `process.env.KEY_NAME`。**

```javascript
// Bad - hardcoded secret
const client = new OpenAI({ apiKey: "sk-proj-xxxxx" });

// Good - environment variable
const client = new OpenAI({ apiKey: process.env.OPENAI_API_KEY });
```

如果你的 repo 有開啟 GitHub 的 Secret Scanning，它也會主動偵測並通知你，建議開啟這個功能。

---

## 問題 6：Claude Code 回應變慢

你覺得 AI 越聊越遲鈍？這很正常，有幾個常見原因。

### 原因 A：Context Window 太大了

Claude Code 會把整個對話歷史都放進記憶體。對話越長、貼的程式碼越多，AI 處理的資訊量就越大，自然就越慢。

就像你的瀏覽器開了 200 個分頁一樣 😅

**解法：壓縮或開新對話**

```
# Compress the current conversation
/compact

# Or just start a fresh conversation for the new task
```

`/compact` 會讓 AI 把目前對話摘要成重點，保留重要資訊但縮小體積。

**什麼時候該開新對話？**
- 任務已經結束，要開始新的任務
- 對話已經跑偏很遠，和原來的主題無關
- 有感覺 AI 開始「記憶混亂」，忘記之前說的事

### 原因 B：讀取的檔案太多

如果你的專案有很多大型檔案或不需要被 AI 讀的東西（例如 node_modules、build 輸出、圖片），AI 掃描時會花很多時間。

**解法：建立 `.claudeignore` 檔案**

用法跟 `.gitignore` 一樣，告訴 Claude Code 哪些東西不用管：

```bash
# .claudeignore

# Dependencies
node_modules/
vendor/
.venv/

# Build outputs
dist/
build/
.next/
__pycache__/

# Large media files
*.mp4
*.zip
*.tar.gz

# Logs
*.log
logs/
```

建立這個檔案後重啟 Claude Code，它就不會去掃這些路徑了。

### 原因 C：網路問題

有時候單純就是網路不穩或 Anthropic 的服務器在忙。

**確認方法：**
```bash
# Check if it's a network issue
ping api.anthropic.com

# Check Anthropic's status page
# https://status.anthropic.com
```

如果 status page 顯示一切正常但還是很慢，試試看：
- 換個網路環境（例如從 WiFi 換成手機熱點）
- 等幾分鐘再試
- 重啟 Claude Code

### 快速判斷原因

| 症狀 | 最可能原因 | 解法 |
|------|-----------|------|
| 剛開始用就很慢 | 網路問題 | 確認網路、查 status page |
| 越聊越慢 | Context 太大 | `/compact` 或開新對話 |
| 特定專案慢 | 檔案掃描太多 | 建立 `.claudeignore` |
| 某個時段特別慢 | 服務器繁忙 | 等一下再試 |

---

> 🆘 還是解不掉？把你的錯誤訊息和情況描述貼給 Claude Code 自己，讓它幫你除錯 — AI 對自己的問題通常還挺了解的 😄
>
> 或是到 [GitHub Issues](https://github.com/chihao919/tip/issues) 回報，讓社群一起幫忙。
