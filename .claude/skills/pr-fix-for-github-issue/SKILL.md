---
name: pr-fix-for-github-issue
description: Fix a GitHub issue end-to-end: explore root cause, implement with TDD, eval autonomously, and open a PR. Use when the user explicitly references a GitHub issue — e.g. mentions an issue number (#123), pastes a github.com/*/issues/* URL, or says "fix issue", "work on issue", "resolve issue", or "close issue". Do NOT trigger for general bug fixes or code changes not tied to a GitHub issue.
argument-hint: <issue-number>
---

# PR Fix for GitHub Issue

## Phase 1: Context Gathering

If `$ARGUMENTS` is empty, AskUserQuestion for the issue number or URL first.

1. `gh issue view $ARGUMENTS`
2. AskUserQuestion to collect (skip fields already in the issue):
   - Expected vs. actual behavior
   - Minimal repro case
   - Files/components already identified
   - Fix type: **code** or **visual** (if visual: what command regenerates the output image?)
3. Write a **fix brief**: root cause hypothesis + explicit success criteria (2–5 bullets). Confirm with user before writing any code.

## Phase 2: Root Cause Exploration

Use the Agent tool (`subagent_type: Explore`) with the fix brief. The agent:
1. `WebFetch` any URLs found in the issue body (repro cases, related PRs, docs)
2. Reads relevant files, traces the bug, and returns:
   - Confirmed root cause (file:line)
   - Minimal files to change
   - Edge cases or related breakage to watch for
   - Recommended implementation approach

Update the fix brief if root cause differs from the hypothesis.

## Phase 3: Implementation (TDD)

1. `git checkout -b claude/<descriptive-name>` (if on main)
2. Detect test/lint commands from `Makefile`, `package.json`, `pyproject.toml`, or `setup.cfg`; fall back to `pytest` / `eslint` / `ruff`
3. **Write the failing test first** — run it to confirm FAIL before any fix
4. Implement the fix (per Phase 2 exploration)
5. Run lint; fix errors
6. Commit

## Phase 4: Eval Loop

**Setup:** TaskCreate one task per success criterion from the fix brief. Accept PASS only when ALL tasks are `completed` — task list is ground truth.

**Code fixes:** Use Agent tool (`run_in_background: true`) with this prompt: verify the fix against each success criterion, update Tasks accordingly, return the verdict below.

The agent:
1. Runs the isolation test → confirms PASS
2. Runs full test suite → confirms no regressions
3. Runs lint → confirms exit 0
4. Updates each Task `pending` → `in_progress` → `completed` (pass) or leaves `pending` with failure note

**Visual fixes:** Use Agent tool (`run_in_background: true`). The agent:
1. Reads the before image (from issue/fix brief) using Read (multimodal)
2. Runs the output pipeline command to generate the after image
3. Reads the after image using Read (multimodal)
4. Reasons visually: issue resolved? regressions in adjacent areas?
5. Updates Tasks same as above

**Eval agent returns this verdict:**
```
VERDICT: PASS | FAIL
EVIDENCE:
  - <criterion>: ✅/❌ — <1-line explanation>
NEXT: <empty if PASS | specific diagnosis if FAIL>
```

**After eval agent completes (supervisor steps — both must pass):**
1. Call `TaskOutput(<agent-id>)` to read the structured verdict
2. Call `TaskList` to independently verify all tasks are `completed`
3. Accept PASS only if BOTH confirm success — agent self-report alone is not sufficient

**Loop:**
- FAIL or any Task not `completed` → apply targeted fix, then use `SendMessage(<agent-id>)` to continue the same eval agent with the diagnosis (preserves failure history). Max 2 continuations.
- After 2 continuations without PASS → surface to user: TaskList + evidence.
- All Tasks `completed` + PASS (both checks) → push branch, open PR.

**PR body:**
```
Resolves #$ARGUMENTS

## Root Cause
<from Phase 2>

## Fix
<from fix brief>

## Verification
<eval verdict + evidence>
```

**Interrupt user only for:**
- Scope questions not in fix brief
- Visual eval: no pipeline command specified in fix brief
- Eval stuck >2 retries
- Unresolvable blocker

## Code Quality
- No inferable comments; top-level imports
- One test per behavior; prefer fewer larger tests over many trivial ones
- Concise without sacrificing readability

Use `gh` for all GitHub ops. If unauthenticated: `gh auth login`.
