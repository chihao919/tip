---
name: vibe-coding-workflow
description: >
  Development workflow for building features. Use when the user wants to
  build something new, add a feature, fix a bug, start a project, or plan
  implementation. Covers planning, behavior specs, testing, implementation,
  review, refactoring, and merging.
---

# Vibe Coding Development Workflow

This skill defines a 7-step development workflow. Follow these steps in order.

## Step 1: Plan (Always start here for new features)

**You are in Plan Mode. Do NOT write any code.**

1. Guide the user to share their idea.
   Start by asking: "What do you want to build? Just describe it in your
   own words — it doesn't have to be perfect."
   Let them talk. Don't interrupt or ask detailed questions yet.
   If they're vague, that's fine — your job is to help them think it through
   in the next step.

2. Then ask the user 5 clarifying questions to help them think it through.
   Focus on understanding their intent, not technical details.
   Common directions include (adapt to the specific project):
   - What problem are you trying to solve?
   - Who will use this, and in what situation?
   - What does "done" look like to you?
   - Is there anything you're sure you DON'T want?
   - Are there existing tools or services this needs to work with?
   Don't ask generic questions — ask about gaps in THEIR specific idea.
   Technical concerns (edge cases, error handling, security) are YOUR job
   to figure out when producing the plan in step 4.

3. After the user answers, restate the full requirements in your own words.
   Keep it short — a few sentences, not a long list.
   Then ask: "Is there anything I got wrong, or anything I missed?"
   This forces the user to actually think about your summary instead of
   just saying "OK" to a wall of text.

4. Produce a complete implementation plan:
   - Files to create or modify
   - Execution order and dependencies between steps
   - Which Design Patterns you chose and WHY
     (Example: "I chose Observer Pattern for event notifications because
     multiple components need to react to state changes.")
   - Edge cases and how you plan to handle them
   - Error handling strategy (what happens when things fail)
   - Security considerations (if applicable)
   - Potential risks and alternatives
   - For complex projects, save the plan as PLAN.md

5. Wait for the user to approve the plan before proceeding.

## Step 2: Behavior Specs (BDD — the contract between you and the user)

Translate the approved plan into behavior descriptions using Given-When-Then format.
This is the bridge between what the user wants and what you will build.

1. Tell the user what you're about to do:
   "I'm going to list out what the system should do in plain language.
   Each scenario describes one specific behavior — please check if these
   match what you have in mind."

2. Write behavior specs in Given-When-Then format:
   ```
   Scenario: <descriptive name>
     Given <initial context>
     When  <action or event>
     Then  <expected outcome>
     And   <additional outcome if needed>
   ```

3. Cover both happy paths and error scenarios:
   - Normal usage (the main thing the feature does)
   - Edge cases (empty input, invalid data, boundary values)
   - Error scenarios (network failure, permission denied, timeout)

4. Present the specs to the user and ask them to review:
   - Are there scenarios that are wrong or unwanted?
   - Are there scenarios that are missing?
   - The user can read these because they are plain language, not code.

5. Get user approval before proceeding. This is your shared contract —
   all tests and implementation will be based on these specs.

**Skip this step** if the feature is trivial (e.g., changing a label, adjusting
a color). But for any feature with multiple scenarios or error handling,
behavior specs save significant rework later.

## Step 3: Generate Tests

Based on the behavior specs from Step 2, generate tests.

1. Tell the user what you're about to do and why:
   "Now I'm going to turn those behavior descriptions into automated tests.
   Each scenario you approved will become a test — so the code must satisfy
   every behavior we agreed on."

2. Write tests that map directly to the behavior specs:
   - Each Scenario from Step 2 should have a corresponding test
   - Happy paths (normal usage)
   - Edge cases (empty, invalid, extreme values, failures)

3. Test names must be human-readable and match the scenario names:
   Good: "user sets a past time → should show error"
   Bad: "test_case_1"

4. After generating tests, briefly explain to the user what each test checks.
   They can cross-reference with the behavior specs from Step 2.

5. Run all tests once to confirm they fail
   (features not built yet — this is expected). Tell the user this is normal.

## Step 4: Implement

1. Tell the user you're starting:
   "Plan approved, behaviors defined, tests ready. I'm going to start
   building now. I'll work through it one piece at a time."

2. Follow the approved plan from Step 1, guided by the behavior specs from Step 2.
   - Work through the plan one sub-feature at a time
   - After completing each sub-feature: run tests, commit if all pass
   - If a test fails: attempt to fix it
   - If it fails 2-3 times: STOP. Ask the user:
     "This part keeps failing. Let's revisit the behavior spec for this scenario."
     Check if the spec itself was wrong, or if the implementation approach needs changing.
   - Continue until all sub-features are done and all tests pass

## Step 5: Review

All tests pass. Now explain what you built.

1. Cross-reference with Step 2's behavior specs:
   Walk through each scenario and confirm it is satisfied.
   Explain in plain language what you did and why.
   The user doesn't need to read code — they need to understand your explanation.
   Include: how you handled edge cases and what happens when things go wrong.
   If your explanation doesn't match what they wanted, stop and re-plan.

2. Ask: "Is there any unnecessary code I can remove?"
   You tend to over-engineer. Actively look for code to delete.

3. For security-related features (auth, payments, personal data):
   Run the `security-check` skill to scan for:
   - Hardcoded secrets (API keys, tokens, passwords)
   - Missing input validation
   - Improper access controls
   - SQL injection, XSS vulnerabilities

4. If the user finds the direction is wrong:
   Do NOT patch directly. Go back to Plan Mode and re-plan first.

## Step 6: Refactor

1. Tell the user you're entering the cleanup phase:
   "Feature is done and verified. Now I'm going to check if the code
   can be tidied up — I'll tell you what I find before changing anything."

2. Analyze the code and check each of the following:

1. Functions that are too long
   - If a function does more than one thing, split it
   - A good function can be described in one sentence

2. Duplicated logic
   - If the same logic appears in 2+ places, extract it into a shared function
   - But don't over-abstract: if two pieces of code look similar but serve
     different purposes, it's OK to keep them separate

3. Unclear naming
   - Function and variable names should describe what they do
   - If you need a comment to explain what a name means, the name is bad

4. Messy dependencies between files
   - Each file/module should have a clear, single responsibility
   - If changing one feature requires editing many unrelated files,
     the code is too tangled — group related logic together
   - The connection between modules should be through simple, clear interfaces

5. Dead code
   - Remove unused functions, variables, imports, and commented-out code
   - AI tends to leave "just in case" code — delete it, Git remembers

**What NOT to do:**
- Don't rewrite working code just to make it "prettier"
- Don't add abstraction layers you don't need yet
- Don't refactor and add new features at the same time — one or the other

**Process:**
3. Tell the user what you suggest improving and why
4. Get approval
5. Execute the refactoring
6. Run all tests to verify nothing broke
7. If tests fail: revert to the previous commit immediately

Skip this step if the change was small (text edits, color changes).
But if a whole new feature was added, always refactor — it makes the next
feature easier to build.

## Step 7: Merge

1. Before pushing, run the `security-check` skill to scan for leaked secrets.
   Only proceed if the security check passes.

2. Merge to main branch with a meaningful commit message
   Format: `feat: <description>` or `fix: <description>`

3. You just completed ONE feature from the plan.
   (Step 4's sub-steps were the internal pieces of that one feature.)

4. Check what to do next:
   - If PLAN.md exists: read it to find the next feature
   - If no PLAN.md: look back at the plan you produced in Step 1
   - If there are more features: go to Step 2 (no need to re-plan)
   - If all planned features are done: tell the user, and ask if they
     want to add new features (which would start a new Step 1)
