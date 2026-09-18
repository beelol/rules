---
name: ultra-clear-reviewable-review
description: "Write a review of a PR, branch, or design that a reader with zero context understands on one read: a short glossary of every term, then each finding as What / Why / Fix in plain words, judged only against what the change intends to do. Use when asked for a clear, concise, no-context, shareable, or reviewable review, or when a review needs to be understood by someone outside the work. Read-only unless the user asks to post it."
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

1. **One-line verdict.** The overall result in one sentence. For example, "Product code is low risk; the problems are in what the new local modes do." Put direct questions to the author here, such as "Have you run this against dev? If not, can you try?" Never list "not tested yet" as a finding; testing before merge is assumed.
2. **The pieces.** A short glossary. Define every project-specific noun the findings use (for example snapshot, manifest, clone, vault, forwarder) in one plain sentence each: what it is and what it is for. If a reader would have to ask "what is that?", it belongs here.
3. **Problems.** Ordered by severity, most severe first.
4. **Notes.** Real concerns that are not defects in this change, such as data handling or cost.
5. **Follow-ups, not problems.** Gaps that exist only because the change does not try to do that yet. Never list these as problems.
6. **What's safe.** Only when the reader would otherwise worry. One or two lines naming what you checked and found fine.

## 3. Finding format

Each finding has a plain-statement title and these clauses:

```markdown
**N. <What goes wrong, stated plainly>** (`path:line`)
- **Context:** <Only if a term or mechanism is still unclear after the glossary. One sentence.>
- **What:** <The problem in one sentence.>
- **Why:** <Why the reader cares: the concrete impact on people, data, cost, or other teams. One sentence.>
- **Fix:** <The smallest change that removes the problem. One sentence.>
```

Rules for each clause:

- **What** says what happens, not how the code is written. Name the behavior, not the variable.
- **Why** names a real consequence: who is affected and how ("the first workflow someone runs writes to real customer tenants"). Never "this is risky" or "this could cause issues".
- **Fix** is one action a person can take. No option lists.
- Use the most accurate verb for what happens, seen from the reader's side. For example, a clone that skips rows "leaves them out"; it does not "delete" them, because the source is untouched.
- For a concern that is worth raising but should not hold the merge, such as cost, time, or resource visibility, phrase the Fix as "Consider ..." and end the finding with "Not a blocker."
- Cite `path:line` at the current PR head in the title. Keep line references out of the clauses themselves.
- Drop throwaway findings: anything without a concrete consequence, such as "two setups exist" with no named harm.
- Keep code identifiers out of What and Why unless the reader needs the name to find the thing. Put a file path in Fix only when the fix needs it.

## 4. Writing rules

- Use everyday words. Explain any necessary technical term the first time it appears.
- One idea per sentence. Subject, verb, object. No clause chains and no em dashes.
- No hedging filler, no praise, no restating the PR description.
- Do not drop a fact to make a sentence shorter. Tighten wording, not content.
- Keep the whole review readable in about a minute. If it runs longer, cut low-severity items before cutting context from high-severity ones.

## 5. Self-check before sending

- Could someone who never saw the PR explain each finding back in their own words?
- Is every noun in the findings either common English or defined under "The pieces"?
- Does any problem criticize something the change does not try to do? Move it to "Follow-ups, not problems".
- Is every finding confirmed in code, or clearly marked as unverified?
- Does every finding have exactly one What, one Why, and one Fix?

## 6. Posting (only when the user asks)

- Post each finding as an inline comment on its cited line. The comment holds the title and the What/Why/Fix clauses, with no line reference.
- Put the verdict, questions, glossary, notes, follow-ups, and "What's safe" in the review body. Do not repeat the findings there.
- When the findings span stacked PRs, post one review per PR, each with the findings whose lines live in that PR.
- Submit as a `COMMENT` review unless the user asks for another type.

## Boundaries

- Do not edit code, commit, or push under this skill. Post only when the user asks.
- To act on existing feedback, use address-pr-review.
