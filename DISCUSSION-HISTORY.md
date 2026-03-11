# 討論歷程記錄

> 這份文件記錄了本專案所有文件的設計決策過程，
> 供 Claude Code 在後續修改時了解脈絡。

---

## 專案起源

使用者 Steven 想為「程式小白」（完全不懂程式的人）製作一份
使用 Claude Code 的入門指南，讓他們能安全、有效地用 AI 寫程式。

目標受眾：完全不懂程式的人（不是有一點基礎的人）。
語言：繁體中文。
工具：Claude Code（不是 Cursor、Windsurf 等其他工具）。

---

## 文件架構與設計決策

### 1. guide-for-beginners.md（入門指南）

**用途：** 給人類讀的入門教學，用白話解釋程式開發的基本概念。

**設計原則：**
- 大量使用生活化比喻（例如：Git = 遊戲存檔、API Key = 家門鑰匙）
- 不假設讀者有任何程式基礎
- 重點放在「為什麼」而不是「怎麼做」（怎麼做由 AI 處理）

**涵蓋主題：**
- 密鑰安全（.env、.gitignore）
- 單元測試的概念
- 版本控制基礎（Git）
- 錯誤處理
- 依賴管理
- 程式碼品質

### 2. CLAUDE.md（Claude Code 自動執行規則）

**用途：** 放在專案根目錄，Claude Code 啟動時自動讀取並遵循。

**設計哲學：**
- 小白不需要記住規則，AI 自動遵守
- 包含 bootstrap 機制：首次使用時自動建立 .gitignore、.env.example 等
- 規則寫得像是「給 AI 的行為準則」而不是「給人的教學」

**重要規則包括：**
- 永遠不要硬編碼敏感資訊
- 每個新函式都要寫單元測試
- 改動前後都要跑測試
- **每完成一個子功能就自動跑測試，全部通過就自動 commit**（後來新增）
- 用白話解釋產出的程式碼
- 錯誤訊息要有意義，不能靜默失敗

### 3. vibe-coding-survival-guide.md（Vibe Coding 生存指南）

**用途：** 進階指南，教小白如何用正確的流程進行 AI 輔助開發。

**這份文件的靈感來源：**
- 10 本經典程式設計書籍（見下方「書籍篩選」段落）
- Mosky 劉依語的 AI 寫程式教學理念
- 2025 年 Vibe Coding 的產業現狀與教訓

### 4. README.md

標準 GitHub README，說明專案用途和檔案結構。

### 5. LICENSE

MIT 授權。

---

## 書籍篩選過程

我們從 10 本公認最好的「寫出好程式」書籍出發，
逐一分析每本書在 AI 時代下哪些知識仍然重要、哪些可以跳過。

### 選定的 10 本書

| # | 書名 | 作者 |
|---|------|------|
| 1 | Clean Code | Robert C. Martin |
| 2 | The Pragmatic Programmer | Andrew Hunt & David Thomas |
| 3 | Refactoring | Martin Fowler |
| 4 | Code Complete | Steve McConnell |
| 5 | Design Patterns | Gang of Four |
| 6 | A Philosophy of Software Design | John Ousterhout |
| 7 | The Clean Coder | Robert C. Martin |
| 8 | Working Effectively with Legacy Code | Michael Feathers |
| 9 | Test-Driven Development: By Example | Kent Beck |
| 10 | The Mythical Man-Month | Frederick Brooks |

### AI 時代下的篩選邏輯

**核心問題：** AI 已經能自動處理哪些事？人類仍需掌握哪些事？

**AI 已經能處理的（可以大幅跳過）：**
- 語法細節、格式化、命名慣例的具體規則
- 23 個設計模式的記憶與實作
- 手動重構的步驟
- 程式碼建構的細節（變數宣告、迴圈結構等）
- 手動撰寫測試的步驟

**人類仍須掌握的（必須保留）：**
- 安全性判斷（AI 約 50% 生成的程式碼有安全漏洞）
- 測試驅動的思維（先有測試再寫功能）
- 需求對齊（怎麼把模糊的想法變成清晰的計畫）
- 複雜度控制（AI 傾向過度工程化）
- 錯誤處理策略（AI 喜歡跳過邊界情況）
- 專業態度（估時間、說不、面對壓力）
- 軟體開發的本質不變（Brooks 定律至今適用）

### 各書 AI 時代評分與取捨

（完整表格在 vibe-coding-survival-guide.md 裡，以下是關鍵決策）

**⭐⭐⭐⭐⭐ 幾乎整本都值得讀：**
- A Philosophy of Software Design — 複雜度控制是 AI 時代最重要的技能
- The Pragmatic Programmer — 思維方式、規劃、驗證的理念不過時
- TDD: By Example — 測試先行的思維是 AI 時代唯一客觀品質指標

**⭐⭐ 大部分可以跳過：**
- Design Patterns — 理解「為什麼」有用，但不需要記憶 23 個模式（AI 會自己用）

---

## Vibe Coding 生存指南的演化過程

### 第一版：8 個步驟

最初的工作流程有 8 個步驟，包含獨立的「定義需求」和「規劃」步驟。

### 第二版：加入 Plan Mode 和 Mosky 的提問技巧

**研究了以下資料後進行重大改版：**

1. **Mosky 劉依語**（台灣 AI 寫程式教育者）
   - 前 Pinkoi 資深後端工程師/架構師，20 年經驗
   - 核心理念：讓 AI 問你問題（反向提示），而不是你努力寫完美的 prompt
   - 課程：learn.mosky.tw/courses/ai-coding

2. **Claude Code Plan Mode**
   - 啟動：Shift+Tab 兩次（或 /plan 指令）
   - 唯讀模式：AI 可以讀檔案、分析架構、問問題，但不能修改任何東西
   - 好處：零風險、更快、更深入的分析
   - Windows 問題（v2.1.3）：Plan Mode 可能不在循環中，改用 /plan 指令

3. **2025 年 Vibe Coding 產業現狀**
   - Andrej Karpathy 2025 年 2 月創造這個詞
   - Y Combinator Winter 2025：25% 的新創有 95% AI 生成的程式碼
   - 安全危機：約 50% 的 AI 程式碼有漏洞
   - Lovable：1,645 個應用中有 170 個有資料外洩問題
   - Replit agent 刪除了生產環境資料庫
   - 產業轉向：「vibe coding」→「context engineering」

### 第三版：合併步驟，從 8 步變成 6 步（後來又加到 7 步）

**合併原因：** Plan Mode 讓「定義需求」和「規劃」變成連續的過程，不需要分開。

**移除安全設定步驟的原因：** CLAUDE.md 的 bootstrap 機制會自動處理。

### 第四版（當前版本）：Mosky 風格的寫法改造

**重大風格改變——受 Mosky 教學風格啟發：**

Steven 指出文件寫得太「深硬」（像教科書），
要求改成 Mosky 的風格：先做再說，做中學。

**具體改動：**

1. **Step 2（產生測試）的節奏改造：**
   - 舊版：先解釋什麼是測試 → 然後教你怎麼做
   - 新版：先叫 AI 做 → ☕ AI 在忙的時候順便解釋為什麼 → AI 做完了看結果
   - 靈感：「在 AI 忙碌工作的時候，我們來解釋一下為什麼要做這個步驟」

2. **Step 2 結尾加入自動化說明：**
   - CLAUDE.md 已經設好規則，AI 會自動跑測試
   - 小白不用自己記得跑，只要看結果是紅色還是綠色
   - 也同步更新了 CLAUDE.md 加入對應規則

3. **Step 3（寫功能）的觀念翻轉：**
   - 舊版：教小白怎麼拆步驟、一塊一塊做
   - 新版：Claude Code 本來就會自動拆步驟（官方文件確認），
     小白只要「看著它做就好」
   - 關鍵發現：拆得好不好取決於 Step 1 的計畫品質
   - 所以真正決定成敗的是 Step 1，不是 Step 3

4. **移除了小白看不懂的術語：**
   - branch → 完全不提（對小白沒意義）
   - commit → 「存檔」
   - 只在必要時用 ☕ 小提示解釋概念

### 尚未改到的部分

Step 4（審核）、Step 5（重構）、Step 6（合併）
還沒有用 Mosky 風格重寫，仍然是舊版的 └─ 格式。
建議後續用同樣的風格改過。

---

## 技術細節備忘

### Claude Code 的自動拆步驟行為

- 官方文件確認：「For complex tasks, it breaks work into steps,
  executes them, and adjusts based on what it learns.」
- 這是 agentic loop 的核心行為，不需要特別設定
- 但拆得好不好取決於 Plan Mode 裡給的計畫是否清楚
- 新的 Tasks 系統（v2.1.16+）支援跨 session 的任務管理

### Claude Code Hooks（自動化測試）

- PostToolUse hook 可以在每次改完檔案後自動跑測試
- 這是「保證版」的自動化（寫死的規則，AI 不可能忘）
- 但設定對小白有門檻
- 目前的做法是靠 CLAUDE.md 規則（簡單版），
  Hooks 留給進階使用者

### Plan Mode 技術細節

- Shift+Tab 循環：Normal → Auto-accept → Plan → (Delegate)
- 可用工具：read, ls, glob, grep, task, web_fetch, web_search
- 不可用工具：edit, write, bash（所有修改工具都被封鎖）
- 小專案（<30 分鐘）：Plan Mode 對話本身就是計畫
- 大專案：建議產出 PLAN.md + ARCHITECTURE.md

---

## 寫作風格指引

本專案的寫作風格受 Mosky 劉依語啟發，核心原則：

1. **先做再說** — 先給一句話讓讀者動手，再解釋為什麼
2. **利用等待時間** — AI 在跑的時候塞知識，不會感覺在「上課」
3. **用 ☕ 標記解釋段落** — 讓想跳過的人可以跳過
4. **用 💡 標記可選知識** — 想深入的人再看
5. **用生活比喻** — IKEA 傢俱、樂高城堡、遊戲存檔
6. **避免專業術語** — branch → 不提、commit → 存檔
7. **用 🟢🔴 視覺化結果** — 測試通過/失敗一目瞭然
8. **語氣像朋友聊天** — 不是老師上課

---

## 第五版：大規模增強（v2.0）

### 完成的待辦事項

- [x] Step 4、5、6 用 Mosky 風格重寫
- [x] Hooks 進階設定寫成附錄（加在 vibe-coding-survival-guide.md 末尾）

### 新增 3 個 Skills

**設計決策：** 從 Jeffallan/claude-skills（66 個專業技能）中萃取適合個人初學者的部分，
簡化後融入本專案的風格（繁體中文、白話、生活比喻）。

1. **debugging-guide** — 系統化除錯指南
   - 靈感來源：Debugging Wizard skill
   - 簡化為 5 步除錯法：重現 → 隔離 → 假設並測試 → 修復 → 預防
   - 用「看醫生」比喻貫穿全文
   - 核心理念：禁止「隨機亂改看看」

2. **code-review** — 自我程式碼審查
   - 靈感來源：Code Reviewer skill
   - 簡化為「自己 review 自己的 code」
   - 5 點檢查清單 + 🔴🟡🟢 嚴重程度分類
   - 只輸出建議，等使用者確認再修改

3. **project-kickoff** — 專案快速啟動
   - 靈感來源：Feature Forge + Architecture Designer
   - 用 5 個問題引導使用者釐清需求
   - 自動選擇技術棧並解釋原因
   - 產出專案結構和 PLAN.md
   - 與 vibe-coding-workflow 互補（kickoff = 整個專案初始化，workflow = 每個功能開發）

### 安裝體驗改善

1. **新增 install.sh 一鍵安裝腳本**
   - `curl -fsSL ... | bash` 即可安裝
   - 自動下載所有 skills、詢問是否複製 CLAUDE.md、顯示安裝報告
   - 處理了非互動模式（pipe from curl）的情況

2. **README.md 大改版**
   - 加入 badges（License、Stars、Last Commit）
   - 加入「為什麼需要這個？」的吸引人開場
   - 加入「30 秒快速開始」段落
   - Skills 表格包含所有 5 個技能的說明

3. **INSTALL.md 更新**
   - 加入一鍵安裝指令
   - 加入更新已安裝 Skills 的方法
   - 安裝完成報告包含所有 5 個技能

### 內容補充

1. **FAQ.md** — 9 個常見問題
   - 方案費用、CLAUDE.md vs settings.json、版權、Plan Mode 等
   - 用生活比喻解釋每個概念

2. **troubleshooting.md** — 6 個常見故障排除
   - CLAUDE.md 沒被讀到、Skills 不出現、測試失敗、push 被擋等
   - 每個問題都有診斷步驟和解決方案

3. **CLAUDE.md Section 2.8**
   - 新增 Available Skills 段落
   - 讓 Claude Code 知道有哪些技能可用

### Step 4/5/6 的 Mosky 風格重寫

**改動原則（與 Step 2/3 一致）：**
- 先給一句話讓讀者動手 → ☕ AI 在忙的時候解釋為什麼 → 看結果
- 用 🟢🔴 視覺化結果
- 用生活比喻（外賣核對菜單、煮完大餐要洗碗、遊戲存檔點）
- 語氣像朋友聊天

### Hooks 附錄

- 加在 vibe-coding-survival-guide.md 末尾
- 用 💡 標記，讓想跳過的人可以跳
- 解釋 CLAUDE.md 規則（AI 口頭約定）vs Hooks（寫死的自動化）的差別
- 提供 Node.js 和 Python 兩種設定範例

---

### 第六版：加入 BDD 行為描述步驟（6 步 → 7 步）

**起因：** Steven 提到軟體工程有三層——Spec（高階需求）、BDD（行為描述）、
Unit Test（單元測試），認為人跟 AI 合作也是團隊，BDD 的「共同語言」概念
對 Vibe Coding 同樣有價值。

**核心洞察：**
- 人跟 AI 合作 = 團隊合作（你是產品經理，AI 是工程師）
- BDD 的 Given-When-Then 格式 = 人跟 AI 之間的「合約」
- 合約用白話寫，人看得懂、AI 也看得懂
- 有合約在手，出錯時可以追溯是「需求沒想清楚」還是「AI 做錯了」

**具體改動：**

1. **vibe-coding-survival-guide.md**
   - 在 Step 1（規劃）和原 Step 2（測試）之間插入新的 Step 2（行為描述）
   - 全部步驟重新編號：6 步 → 7 步
   - Step 2 用 Mosky 風格撰寫（先做再說 → ☕ 解釋 → 看結果）
   - 用「老闆跟員工之間的合約」比喻解釋 BDD

2. **skills/vibe-coding-workflow.md**
   - 新增 Step 2: Behavior Specs 段落
   - 全部步驟重新編號
   - Step 7 的下一輪引用更新為 Step 2

3. **全域更新**
   - README.md、INSTALL.md、CLAUDE.md 中的「6 步驟」全部更新為「7 步驟」
   - 流程描述更新為：規劃 → 行為描述 → 測試 → 實作 → 審查 → 重構 → 合併

**為什麼不做成獨立 Skill：**
Steven 決定直接整合進現有流程，而不是做成新的 skill。
原因是 BDD 不是獨立的工具，而是開發流程中的一個環節。

### 整合 Context Hub (chub) — 解決 AI 幻覺 API 問題

**起因：** 研究了 Andrew Ng 團隊的 [Context Hub](https://github.com/andrewyng/context-hub)
專案，發現它解決了一個 TIP 流程中的重要缺口：AI 在寫外部 API 呼叫時，可能
使用過時的 API 用法（因為訓練資料有截止日期）。

**Context Hub 的核心價值：**
- CLI 工具（chub），讓 agent 在寫程式前先抓最新的官方 API 文件
- 支援 60+ 種 API（OpenAI、Stripe、Firebase、Supabase 等）
- Annotations 機制：agent 可以留筆記給未來的自己，跨 session 保留
- 文件是社群維護的，比 AI 自己搜尋更精準

**整合方式：**
1. vibe-coding-survival-guide.md Step 4 加入 chub 提醒
2. vibe-coding-workflow skill Step 4 加入查文件步驟
3. FAQ 新增 Q10：AI 寫的 API 呼叫不對怎麼辦
4. README 加入推薦工具段落

**為什麼不做成獨立 Skill：**
chub 本身已經有自己的 get-api-docs skill（格式跟 TIP 的 skill 一模一樣）。
TIP 不需要重新造輪子，只需要在流程中提醒使用者：「用到外部 API 時，先查文件」。

---

## 待辦事項

- [ ] 考慮加入實際操作的螢幕截圖或 GIF
- [ ] 考慮錄製安裝和使用的影片教學
- [ ] 考慮加入更多 Skills（如 git-workflow、documentation-writer）
- [ ] 考慮支援其他語言版本（英文、簡體中文）
