# TIP — Claude Code 入門工具包

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![GitHub stars](https://img.shields.io/github/stars/chihao919/tip)](https://github.com/chihao919/tip/stargazers)
[![Last Commit](https://img.shields.io/github/last-commit/chihao919/tip)](https://github.com/chihao919/tip/commits/main)

> 🇹🇼 專為不懂程式但想用 AI 寫程式的人設計的 Claude Code 入門工具包。

---

## 為什麼需要這個？

你用 Claude Code 寫出了第一個程式，感覺自己是天才 🎉

然後隔天發現：
- 🔐 API Key 被上傳到 GitHub，收到一封天價帳單
- 🐛 程式看起來能跑，但其實到處是 bug
- 💥 改了一個小地方，整個專案壞掉了，而且回不去

**這些事情，有經驗的工程師會自然避開。但初學者根本不知道要注意。**

TIP 就是幫你提前準備好這些「防護網」。你只需要裝上去，Claude Code 就會自動：
- 🔐 保護你的密鑰不被上傳
- 🧪 每次寫完功能自動跑測試
- 📋 用最佳實踐流程開發
- 🗣️ 用白話跟你解釋每一段程式碼

---

## ⚡ 30 秒快速開始

### 方法一：一鍵安裝（推薦）

```bash
curl -fsSL https://raw.githubusercontent.com/chihao919/tip/main/install.sh | bash
```

### 方法二：讓 Claude Code 幫你裝

```bash
claude
```
然後說：「請幫我從 https://github.com/chihao919/tip 安裝開發工具包」

### 方法三：手動安裝

```bash
git clone https://github.com/chihao919/tip.git
mkdir -p ~/.claude/skills
cp tip/skills/*.md ~/.claude/skills/
cp tip/CLAUDE.md your-project/
```

詳細說明請見 [INSTALL.md](./INSTALL.md)。

---

## 📦 內容一覽

### 📖 指南文件

| 檔案 | 說明 | 適合誰 |
|------|------|--------|
| [guide-for-beginners.md](./guide-for-beginners.md) | 入門指南：用白話解釋程式開發的基本概念 | 完全的程式小白 |
| [vibe-coding-survival-guide.md](./vibe-coding-survival-guide.md) | Vibe Coding 生存指南：7 步驟開發流程 + Plan Mode | 準備開始寫程式的人 |
| [CLAUDE.md](./CLAUDE.md) | 放進專案就自動生效的 AI 行為規則 | 所有使用 Claude Code 的人 |
| [FAQ.md](./FAQ.md) | 常見問題：新手最常問的 9 個問題 | 有疑問的人 |
| [troubleshooting.md](./troubleshooting.md) | 故障排除：遇到問題怎麼解決 | 碰到問題的人 |

### 🛠️ Skills（技能）

Skills 是 Claude Code 的「專業技能」，安裝後可以用 `/skill-name` 觸發。

| 技能 | 說明 | 觸發方式 |
|------|------|----------|
| [vibe-coding-workflow](./skills/vibe-coding-workflow.md) | 7 步驟開發流程：規劃 → 行為描述 → 測試 → 實作 → 審查 → 重構 → 合併 | 開發新功能時自動使用 |
| [security-check](./skills/security-check.md) | 推送前安全掃描：檢查有沒有不小心把密鑰寫進程式碼 | `git push` 前自動觸發 |
| [debugging-guide](./skills/debugging-guide.md) | 系統化除錯指南：5 步除錯法，不再瞎猜亂改 | 遇到 bug 時使用 |
| [code-review](./skills/code-review.md) | 自我程式碼審查：5 點檢查清單，幫你抓出潛在問題 | 完成功能後使用 |
| [project-kickoff](./skills/project-kickoff.md) | 專案快速啟動：5 個問題釐清需求，自動建立專案骨架 | 開始新專案時使用 |

---

## 安裝後你會得到什麼？

**CLAUDE.md 自動執行：**
- 🔐 建立 `.claude/settings.json` 安全規則
- 📄 建立 `.gitignore` 和 `.env.example`
- ✅ 驗證整個安全設定

**Skills 提供的能力：**
- 📋 7 步驟流程開發功能
- 🔒 推送前自動檢查密鑰洩漏
- 🐛 系統化除錯，不再瞎猜
- 🔍 自動程式碼審查
- 🚀 快速啟動新專案

**持續遵守的規則：**
- 永遠不硬編碼密鑰
- 每個功能都寫測試
- 正確處理錯誤
- 先規劃再寫程式
- 用白話解釋程式碼

---

## 推薦搭配工具

| 工具 | 說明 | 安裝 |
|------|------|------|
| [Context Hub (chub)](https://github.com/andrewyng/context-hub) | AI 寫程式前先查最新 API 文件，避免用過時的 API | `npm install -g @aisuite/chub` |

## 參考資源

| 資源 | 說明 |
|------|------|
| [Everything Claude Code](https://github.com/affaan-m/everything-claude-code) | 最完整的 Claude Code 配置生態系統（50K+ stars）。包含 16 個 agent、65+ skills、40 commands、hooks 自動化、安全指南、token 優化策略。TIP 適合入門，ECC 適合進階。 |
| [Context Hub](https://github.com/andrewyng/context-hub) | Andrew Ng 團隊的 API 文件管理工具。讓 AI 在寫程式前先查最新文件，解決訓練資料過時的問題。 |

---

## 其他資源

| 檔案 | 說明 |
|------|------|
| [DISCUSSION-HISTORY.md](./DISCUSSION-HISTORY.md) | 設計決策記錄（給貢獻者看的） |
| [INSTALL.md](./INSTALL.md) | 詳細安裝說明（給 Claude Code 看的） |

## Requirements

- [Claude Code](https://www.anthropic.com/claude-code)（Pro、Max、Team 或 Enterprise 方案）
- 終端機 / 命令列
- Git
- （可選）[Context Hub](https://github.com/andrewyng/context-hub)：`npm install -g @aisuite/chub`

## Contributing

發現遺漏或過時的內容？歡迎 PR 和 Issue。

## License

MIT
