---
name: security-check
description: >
  Pre-push security scanner for detecting leaked secrets. Use before every
  git push to scan for API keys, tokens, passwords, and sensitive data.
  Prevents accidental exposure of credentials to public repositories.
---

# Security Check

Scan staged/committed changes for sensitive data before pushing to remote.

## When to Use This Skill

Run this skill **before every `git push`** to prevent accidental secret leaks.

## Pre-Push Checklist

Before ANY `git push`, scan the diff for:

### 1. API Keys & Tokens

| Service | Pattern |
|---------|---------|
| OpenAI | `sk-` |
| Stripe | `sk_live_`, `sk_test_`, `pk_live_`, `pk_test_` |
| HubSpot | `pat-na1-`, `pat-eu1-` |
| AWS | `AKIA`, `aws_secret_access_key` |
| Google | `AIza` |
| GitHub | `ghp_`, `gho_`, `ghu_`, `ghs_`, `ghr_` |
| Generic | `api_key`, `apikey`, `api-key`, `token`, `Bearer` |

### 2. Credentials

- Passwords in config files
- `.env` file contents
- `client_secret`, `private_key`
- Database connection strings (`mongodb://`, `postgres://`, `mysql://`)

### 3. Sensitive Files

These files should NEVER be committed:

- `.env`, `.env.local`, `.env.production`, `.env.*`
- `credentials.json`, `service-account.json`
- `*.pem`, `*.key`, `id_rsa`, `id_ed25519`
- `*.p12`, `*.pfx`

## Scan Commands

```bash
# Check diff for sensitive patterns (compare with remote)
git diff origin/HEAD..HEAD | grep -iE "(api_key|token|secret|password|pat-|sk-|pk-|Bearer|AKIA|AIza|ghp_|mongodb://|postgres://)" || echo "Clean"

# Check staged files only
git diff --cached | grep -iE "(api_key|token|secret|password|pat-|sk-|pk-|Bearer|AKIA|AIza)" || echo "Clean"

# Check if .env files are staged
git diff --cached --name-only | grep -E "\.env" && echo "WARNING: .env file staged!" || echo "No .env files staged"

# Check specific commit
git show <commit> | grep -iE "(pat-|sk-|secret|token|password)"
```

## Response Protocol

### If Sensitive Data Found:

1. **STOP** - Do not push
2. Report findings to user with file and line number
3. Suggest fix:
   - Remove hardcoded value
   - Use environment variable instead
   - Add to `.gitignore` if it's a sensitive file
4. If already committed:
   - Soft reset: `git reset --soft HEAD~1`
   - Remove the secret
   - Recommit

### If Clean:

```
✅ Security check passed - no sensitive data detected
```

Proceed with push.

## Integration with vibe-coding-workflow

This skill is called automatically by the `vibe-coding-workflow` skill at:

- **Step 4 (Review)**: Security review for auth/payment features
- **Step 6 (Merge)**: Before pushing to remote

## Quick Reference

```
┌─────────────────────────────────────────────────┐
│  Before git push, ALWAYS run security check:    │
│                                                 │
│  1. Scan diff for secret patterns               │
│  2. Check for .env files in staging             │
│  3. Verify .gitignore includes sensitive files  │
│                                                 │
│  If anything found → STOP and fix first         │
│  If clean → ✅ Safe to push                     │
└─────────────────────────────────────────────────┘
```
