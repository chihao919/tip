---
name: debugging-guide
description: >
  Systematic debugging guide for beginners. Use when the user is stuck on a
  bug, getting an error, or doesn't know why their code isn't working. Guides
  them through a 5-step method: Reproduce, Isolate, Hypothesize & Test, Fix,
  Prevent. Forbids random trial-and-error approaches.
---

# 系統化除錯指南

遇到 bug 了嗎？別慌，我們一步一步來。

除錯就像看醫生：醫生不會你一進門就給你開藥，而是先問症狀、再檢查、再確診、最後才開處方。隨機亂試 = 自己亂吃藥，不但沒用還可能更糟。

---

## 使用時機

當你：
- 看到錯誤訊息不知道怎麼辦
- 程式不按預期跑但沒有報錯
- 「我改了一個地方，然後整個壞掉」
- 「之前好好的，現在突然不行了」

---

## 五步除錯法

### 🔴 第一步：重現問題（Reproduce）

**目標：能穩定讓 bug 出現**

先問自己：
- 這個 bug 每次都會發生，還是隨機出現？
- 做什麼操作會觸發它？
- 在別的環境（換瀏覽器、換電腦）還會發生嗎？

**做法：**
```
// Write down the exact steps to reproduce the bug
// Step 1: Open the app
// Step 2: Click the "Login" button
// Step 3: Enter any email and password
// Step 4: Bug appears - error message shows wrong text
```

如果你連怎麼重現都不知道，就先專注在「讓它穩定出現」，其他什麼都別做。

---

### 🔴 第二步：隔離問題（Isolate）

**目標：把問題縮小到最小範圍**

就像停電時找電路問題：先看是全棟停電（主幹問題）還是只有一個插座壞了（局部問題）。

**二分搜尋法（Binary Search）：**
```
// If you have 100 lines of code, check the middle first
// - Is the bug in lines 1-50 or 51-100?
// - Then narrow down to 25 lines, then 12, then 6...
// This is much faster than checking line by line
```

**console.log 放置技巧：**
```javascript
// Bad: Randomly adding console.log everywhere
console.log("here")
console.log("value", x)
console.log("wtf")

// Good: Place logs at entry/exit of suspected areas
console.log("[DEBUG] Before API call, payload:", payload)
const result = await fetchData(payload)
console.log("[DEBUG] After API call, result:", result)
```

**隔離的黃金問題：**
- 哪一行執行之前是正常的？
- 哪一行執行之後就壞了？
- 把這段程式碼單獨拿出來，還會出問題嗎？

---

### 🟢 第三步：建立假設並測試（Hypothesize & Test）

**目標：猜一個原因，然後驗證它**

不是「亂試看看」，是「有根據地猜，然後證明或推翻」。

**建立假設的方法：**
```
// Wrong approach: randomly change things until it works
// Right approach:
// 1. Read the error message carefully
// 2. Ask: what could CAUSE this error?
// 3. Form ONE hypothesis: "I think the bug is because X"
// 4. Find a way to prove or disprove it
// 5. If wrong, form the next hypothesis
```

**讀懂錯誤訊息：**

錯誤訊息通常有三個重點：
- **什麼錯誤**（例：`TypeError: Cannot read property 'name' of undefined`）
- **哪個檔案哪一行**（例：`at UserCard.js:42`）
- **呼叫鏈**（Stack trace，從下往上讀，找你自己寫的程式碼）

```
// TypeError: Cannot read property 'name' of undefined
//   at UserCard.js:42  <-- your code, start here
//   at renderList.js:15
//   at App.js:8

// Hypothesis: the 'user' object is undefined when it reaches UserCard
// Test: add console.log before line 42 to check if user exists
console.log("[DEBUG] user object:", user)  // line 41
console.log("[DEBUG] user.name:", user?.name)  // safe access
```

---

### 🟢 第四步：修復（Fix）

**目標：解決根本原因，不是症狀**

🔴 **禁止行為：**
- 加一個 `try/catch` 把錯誤吞掉
- 加一個 `if` 迴避問題而不解決問題
- 改到「看起來不會報錯」就停手

✅ **正確方式：**
```javascript
// Bad fix: suppress the error without understanding it
try {
  renderUser(user)
} catch (e) {
  // ignore
}

// Good fix: understand WHY user can be null, and handle it properly
// Root cause: API can return null when user is not found
// Real fix: handle the null case explicitly
if (!user) {
  return <EmptyState message="User not found" />
}
return <UserCard user={user} />
```

修完之後，回去用第一步的重現步驟確認 bug 消失了。

---

### 🟢 第五步：預防（Prevent）

**目標：讓這個 bug 不會再發生**

問自己：
- 為什麼這個 bug 沒有被測試抓到？
- 有沒有類似的地方也可能有同樣問題？
- 要怎麼讓下次更容易發現？

**預防手段：**
```javascript
// Add a test case that would have caught this bug
test("renderUser should handle null user gracefully", () => {
  const result = renderUser(null)
  expect(result).toMatchSnapshot() // should show empty state
})

// Add input validation to catch bad data early
function renderUser(user) {
  if (user === null || user === undefined) {
    console.warn("[WARN] renderUser called with null user")
    return null
  }
  // ... rest of the function
}
```

---

## 常見 Bug 類型速查

| 🔴 症狀 | 可能原因 | 先檢查什麼 |
|---------|---------|-----------|
| `undefined is not a function` | 呼叫了不存在的方法 | 物件有沒有這個方法，名字有沒有拼錯 |
| `Cannot read property 'x' of null` | 對 null 取值 | 變數在這時候是不是已經有值 |
| 畫面沒有更新 | 狀態沒有正確觸發 re-render | 是否有修改到原本物件而非建立新物件 |
| API 回傳 404 | 路徑或參數錯誤 | 印出完整的 request URL 和 headers |
| 「之前好的現在壞了」 | 最近改了什麼 | `git diff` 看最近的改動 |
| 只有某人的環境會壞 | 環境變數或版本差異 | 對比 `.env` 和 `node --version` |

---

## 求助前的自我檢查

在問別人（或問 AI）之前，先確認你能回答這些問題：

```
1. What exactly is the error message?
2. What did you expect to happen?
3. What actually happened?
4. What have you already tried?
5. When did it last work correctly?
```

能回答這五個問題，你已經解決了 80% 的問題了。

---

## 嚴禁事項

🔴 以下行為等同於「隨機亂試」，禁止使用：

- 把整段程式碼貼給 AI 說「幫我修好」但自己不理解
- 改了一個地方沒用，馬上改另一個，沒有紀錄改了什麼
- 因為不懂錯誤訊息就直接跳過
- 用 `console.log("???")` 或 `console.log("wtf")` 而不是有意義的 debug log
- 改到「不報錯了」就以為修好了，沒有驗證邏輯是否正確

---

除錯是一種技能，越練越強。每個 bug 都是一個學習機會，先深呼吸，然後一步一步來。
