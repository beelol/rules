---
name: ultra-clear-reviewable-review
description: "Write a review of a PR, branch, or design that a reader with zero context understands on one read, with each finding as a short title / Why / Fix in plain words. Use when asked for a clear, concise, no-context, shareable, or reviewable review, or when a review needs to be understood by someone outside the work. Read-only unless the user asks to post it."
---

# Ultra-Clear Reviewable Review

Produce a review that someone who never saw the change can read once, understand, and act on. Clarity beats completeness of detail; correctness is never traded away.

## 1. Verify before writing

1. Read the PR title, body, full diff, and the code the diff calls into. For a local-only review, read the fetched branch; do not post anything.
2. Write down what the change **intends** to do and what it explicitly leaves for later. Judge it against that intent only.
3. Confirm every finding in the code: trace the path that triggers it and what breaks. Drop anything you cannot confirm, or mark it as unverified.
4. Check claims the author makes about safety (for example "all callers pass X") against the real callers.
5. Confirm the PR head right before citing lines or posting. If new commits landed, re-verify each finding at the new head.

## 2. Structure

Use this order. Omit a section when it has nothing in it.

1. **One-line review verdict.** Summarize only the review outcome: merge blockers, suggestions, and rollout prerequisites. Do not add a summary of what the PR does. If the user separately asks for a PR explanation, provide it outside the review. The overall result fits in one sentence. For example, "Product code is low risk; the problems are in what the new local modes do." Put direct questions to the author here, such as "Have you run this against dev? If not, can you try?" Never list "not tested yet" as a finding; testing before merge is assumed.
2. **Problems.** Ordered by severity, most severe first. Explain necessary terms where they first appear in each finding.
3. **Notes.** Real concerns that are not defects in this change, such as data handling or cost.
4. **Follow-ups, not problems.** Gaps that exist only because the change does not try to do that yet. Never list these as problems.
5. **What's safe.** Only when the reader would otherwise worry. One or two lines naming the specific behavior found safe.

The review ends after its substantive content. Omit a separate glossary and routine process footer: test totals, checks not rerun, head hashes or recheck status, and posting status. Still perform verification and head checks. Keep evidence supporting a finding inside that finding; qualify a verdict when missing evidence materially limits it.

## 3. Finding format

Each finding has a short plain-language title, one **Why** sentence, and one **Fix** sentence. Aim for 40–70 words including the title and evidence. The title carries what goes wrong; do not repeat it in separate What or Context sections.

```markdown
**[suggestion] Require confirmation before reporting success.**

**Why:** The script reports success without an API confirmation, hiding failed operations.

**Fix:** Require the response's success flag and report missing or malformed responses as errors. [Code](path:line)
```

- **Title:** Name the affected behavior or corrective action so someone who never saw the PR understands it.
- **Why:** Name the concrete consequence and the behavior causing it; include the trigger when needed to understand the failure.
- **Fix:** Give the smallest correction, with required regression coverage when behavior changes. Preserve essential limits such as once per run or before each write.
- Label each finding `[blocker]`, `[suggestion]`, or `[question]` accurately. Include nonblocking improvements only when the requested scope covers them; a direct label needs no repeated “Not a blocker” footer.
- Use accurate verbs: leaving rows out of a copy does not delete the source rows.
- Link the exact path and tight line range at the current PR head after the explanation. The finding must make sense without opening its link.
- Keep implementation names in Fix when possible; preserve details needed for correctness, including scope, ownership, and freshness checks.
- Drop findings without a concrete consequence. For unresolved ambiguities, give the relevant context and ask a direct question instead of asserting an unverified defect.

## 4. Writing rules

- Use everyday words. Explain any necessary technical term the first time it appears.
- One idea per sentence. Subject, verb, object. No clause chains and no em dashes.
- No hedging filler, no praise, no restating the PR description.
- Do not drop a fact to make a sentence shorter. Tighten wording, not content.
- Target 200–300 words for the whole review, including the verdict and findings; use fewer when sufficient. Keep Why and Fix to one short sentence each. Preserve concrete impact and recovery requirements; cut repeated context and low-severity items first.

## 5. Self-check before sending

- Does the opening summarize the review outcome only, with no PR overview?
- Is the full review concise (normally 200–300 words or fewer), without repeated context?
- Could someone who never saw the PR explain each finding back in their own words?
- Are necessary technical terms explained where they first appear, with no separate glossary?
- Does the review end without a routine process footer?
- Does any problem criticize something the change does not try to do? Move it to "Follow-ups, not problems".
- Is every finding confirmed in code, or clearly marked as unverified?
- Does each finding have a short title, one Why, and one Fix, without repeated context?

## 6. Posting (only when the user asks)

- Post each finding as an inline comment on its cited line. The comment holds the title and Why/Fix clauses, with no redundant line reference.
- Put the verdict, questions, notes, follow-ups, and "What's safe" in the review body. Do not repeat the findings there.
- When the findings span stacked PRs, post one review per PR, each with the findings whose lines live in that PR.
- Submit as a `COMMENT` review unless the user asks for another type.

## Boundaries

- Do not edit code, commit, or push under this skill. Post only when the user asks.
- To act on existing feedback, use address-pr-review.
