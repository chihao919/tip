---
name: code-review
description: >
  Self code review skill for checking your own code after completing a feature.
  Use after finishing a feature or making significant changes. Runs a 5-point
  checklist covering security, error handling, naming clarity, duplicate logic,
  and unnecessary code. Outputs prioritized improvement suggestions and waits
  for user confirmation before making any changes.
---

# 自我程式碼審查

功能寫完了？先別急著交出去，花五分鐘自我審查一下。

就像作文交出去之前要自己讀一遍，程式碼也一樣。你現在花五分鐘，可以省下之後被 bug 追著跑的幾小時。

---

## 使用時機

在以下情況使用這個技能：
- 完成一個新功能後
- 做了比較大的改動之後
- 準備讓別人 review 你的 code 之前
- PR 要 merge 之前

---

## 審查流程

收到使用者的 code 後，先安靜地閱讀整個改動，然後按照以下五個面向逐一檢查，最後整理出一份報告。

**重要：只輸出建議，等使用者確認後才動手修改。**

---

## 五點審查清單

### 1. 安全性（Security）

檢查是否有以下問題：

```javascript
// Red flag: hardcoded secrets
const API_KEY = "sk-abc123..."  // never do this

// Red flag: directly using user input without validation
const query = `SELECT * FROM users WHERE id = ${req.params.id}`  // SQL injection risk

// Red flag: exposing sensitive data in responses
res.json({ user, passwordHash, internalToken })  // too much info
```

問自己：
- 有沒有把 API key 或密碼直接寫在程式碼裡？
- 使用者的輸入有沒有做驗證再使用？
- 回傳給前端的資料有沒有多餘的敏感欄位？

---

### 2. 錯誤處理（Error Handling）

檢查每個可能失敗的地方：

```javascript
// Bad: silently swallowing errors
try {
  await saveUser(data)
} catch (e) {
  // nothing here - this is a trap
}

// Bad: vague error message
throw new Error("something went wrong")

// Good: descriptive error with context
try {
  await saveUser(data)
} catch (e) {
  console.error("Failed to save user, userId:", data.id, e.message)
  throw new Error(`User save failed for id ${data.id}: ${e.message}`)
}
```

問自己：
- API 呼叫失敗時，使用者會看到什麼？
- 有沒有 `catch` 是空的，或只有 `console.log`？
- 網路斷線、資料格式錯誤的情況有考慮到嗎？

---

### 3. 命名清晰度（Naming Clarity）

好的命名讓人不需要看實作就能理解：

```javascript
// Bad naming - reader has no idea what these do
function process(d) { ... }
const x = getStuff()
let flag = true

// Good naming - self-documenting
function formatUserDisplayName(user) { ... }
const activeSubscriptions = fetchUserSubscriptions()
let isEmailVerified = true
```

問自己：
- 函式名稱有沒有說清楚「做什麼事」？
- 變數名稱有沒有說清楚「存的是什麼」？
- 有沒有 `data`、`info`、`temp`、`x`、`flag` 這種模糊名字？
- 布林變數有沒有用 `is`、`has`、`can` 開頭？

---

### 4. 重複邏輯（Duplicate Logic）

重複的程式碼是未來 bug 的溫床：

```javascript
// Bad: same logic repeated in two places
function createAdminUser(name, email) {
  const user = { name, email, role: "admin" }
  user.createdAt = new Date().toISOString()
  user.id = generateId()
  return user
}

function createGuestUser(name, email) {
  const user = { name, email, role: "guest" }
  user.createdAt = new Date().toISOString()  // duplicated
  user.id = generateId()                     // duplicated
  return user
}

// Good: extract the shared logic
function createUser(name, email, role) {
  return {
    id: generateId(),
    name,
    email,
    role,
    createdAt: new Date().toISOString(),
  }
}
```

問自己：
- 有沒有幾乎一樣的程式碼出現兩次以上？
- 有沒有可以抽出來成共用函式的邏輯？
- **但注意**：看起來像但用途不同的程式碼，不一定要合併

---

### 5. 不必要的程式碼（Unnecessary Code）

刪掉廢碼，讓人只需要讀真正重要的部分：

```javascript
// Unnecessary: commented-out code that's no longer needed
// function oldFetchUser(id) {
//   return db.query("SELECT * FROM users WHERE id = " + id)
// }

// Unnecessary: unused imports
import { formatDate, parseDate, validateDate } from './dateUtils'
// only formatDate is actually used

// Unnecessary: dead code paths
function getUser(id, options) {
  // 'options' parameter is never used
  return db.users.findById(id)
}
```

問自己：
- 有沒有被註解掉的舊程式碼？
- 有沒有 import 了但沒有用到的東西？
- 有沒有函式的參數根本沒被用到？
- 有沒有永遠不會執行到的程式碼（dead code）？

---

## 輸出報告格式

審查完成後，用以下格式呈現結果：

```
## 程式碼審查結果

### 🔴 重大問題（Critical）— 必須修改
這類問題會造成 security 漏洞或程式崩潰，不修不能上線。

- [具體說明問題在哪裡，為什麼危險，怎麼改]

### 🟡 主要問題（Major）— 強烈建議修改
這類問題現在不會爆炸，但會讓程式難以維護或測試。

- [具體說明問題在哪裡，為什麼重要，怎麼改]

### 🟢 次要問題（Minor）— 可以修改
這類問題是習慣和風格層面，改了會更好讀，但不改也不會怎樣。

- [具體說明問題在哪裡，為什麼建議改，怎麼改]

---
發現 X 個問題（🔴 A 個 / 🟡 B 個 / 🟢 C 個）

要我幫你修哪些？
```

---

## 嚴重性分級標準

| 等級 | 符號 | 何時使用 |
|------|------|---------|
| Critical | 🔴 | Security 漏洞、會讓程式 crash 的 bug、資料可能遺失 |
| Major | 🟡 | 沒有錯誤處理、邏輯重複超過 3 次、命名完全看不懂 |
| Minor | 🟢 | 命名可以更清楚、小範圍重複、未使用的 import |

---

## 重要提醒

- 審查完只輸出建議，**不要自動修改**
- 等使用者說「幫我修 🔴 的問題」或「全部幫我改」才動手
- 如果沒有發現問題，就說「這段 code 看起來很乾淨，沒有明顯問題」
- 不要為了挑毛病而挑毛病，沒有問題就是沒有問題
