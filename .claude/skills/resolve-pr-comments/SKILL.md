---
name: resolve-pr-comments
description: Analyze and fix all unresolved comments in a GitHub PR, then mark threads resolved. Use when asked to resolve PR comments or review feedback.
argument-hint: <pr-number>
---

# Resolve PR Comments

Fix unresolved comments in PR: $ARGUMENTS

## Workflow

1. Fetch unresolved comments:
   ```bash
   gh api repos/OWNER/REPO/pulls/$ARGUMENTS/comments --paginate
   ```
2. List all required changes from outstanding comments.
3. Implement changes; apply fixes to all similar code in the PR, not just the flagged line.
4. Re-review each comment to confirm it's been addressed.
5. Check similar implementations in the codebase for style consistency.
6. Review the full PR end-to-end to confirm its goal is achieved.
7. Resolve fixed threads:
   ```bash
   # Get GraphQL thread IDs
   gh api graphql -f query='query{repository(owner:"OWNER",name:"REPO"){pullRequest(number:$ARGUMENTS){reviewThreads(first:20){nodes{id isResolved comments(first:1){nodes{body path}}}}}}}'
   # Resolve each thread
   gh api graphql -f query='mutation {resolveReviewThread(input: {threadId: "THREAD_ID"}) {thread {isResolved}}}'
   ```
8. Update the PR top-level description if it's out of date.
