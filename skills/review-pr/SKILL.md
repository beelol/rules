---
name: review-pr
description: "Review a GitHub pull request for evidence-backed blockers and regressions, with brief findings understandable without prior context. Use when asked to review or audit a PR, inspect a PR diff, or draft review findings. Read-only; use address-pr-review to implement existing feedback."
---

# Review a Pull Request

Review the proposed diff. Do not adjust the branch or address existing review comments.

## Establish intent

1. Read the PR title, body, diff, linked requirements, repository instructions, and nearby implementation patterns.
2. Identify required behavior, preserved interfaces, and explicit non-goals.
3. Ground convention and reuse claims in actual repository evidence.

## Decide whether browser testing is needed

Briefly state material decisions and their reasons as they are made, including scope, baseline, browser testing, delegation, classification, and verdict. Keep these to practical conclusions, not private reasoning or tool narration.

After inspecting the diff and callers, decide whether rendered UI, interaction, navigation, state, accessibility, or user-visible API/model output changes. If so, use ../visual-review-pr/SKILL.md to coordinate a browser subagent and screenshot audit while continuing source review. Respect an explicit source-only scope. If no UI behavior is affected, state why and skip browser testing. Distinguish regressions, new-feature defects, and pre-existing issues; category and blocker severity are separate.

## Focus on blockers and regressions

- Prioritize concrete correctness, security, data-loss, concurrency, and compatibility defects introduced or worsened by the change.
- Verify the failure scenario against callers, requirements, and nearby code before reporting it. State what triggers it and what breaks.
- Report structural, reuse, scope, or verification concerns only when they cause a concrete defect, violate an explicit requirement, or leave a material regression risk unsupported by checks.
- Omit pre-existing problems, style preferences, speculative cleanup, optional refactors, praise, and unrelated debt. Broaden to nonblocking improvements only when the user explicitly requests them. Zero findings is valid.

## Write concise, self-contained findings

Each blocker or suggestion has a short plain-language title, one **Why** sentence, and one **Fix** sentence. Aim for 40–70 words including the title and evidence. Name the affected behavior so someone who never saw the PR can understand the problem and act on it.

```markdown
**[suggestion] Require confirmation before reporting success.**

**Why:** The script reports success without an API confirmation, hiding failed operations.

**Fix:** Require the response's success flag and report missing or malformed responses as errors. [Code](path:line)
```

- **Title:** State the problem or corrective action without repeating it in a separate What or Context section.
- **Why:** Name the concrete consequence and the behavior causing it; supply the trigger when needed to understand the failure.
- **Fix:** Give the smallest correction and required regression coverage when behavior changes. State essential limits explicitly, such as once per run or before each write.
- **Evidence:** Link the exact path and tight line range after the explanation. Links support a finding; its meaning stands without opening them.

Use familiar words and keep implementation names in Fix when possible. Preserve details needed for correctness, including scope, ownership, and freshness checks; remove repeated context and extra explanation. For questions, give the relevant context, path and line, and the direct question.

## Label every finding

Assign exactly one semantic label and prefix the finding with it:

- `[blocker]`: An evidence-backed defect that must be fixed before merge because it violates required behavior or creates a material correctness, security, data-loss, compatibility, or regression risk.
- `[suggestion]`: A concrete nonblocking improvement; include only when the user explicitly requested a broader review.
- `[question]`: An unresolved ambiguity necessary to assess a potential blocker or regression. Give the concrete scenario, ask directly, and do not imply that an unverified defect is established.

Do not use a question as a softer substitute for a known defect. Do not mark a suggestion or question as a blocker without repository, requirement, or behavioral evidence.

## Draft before posting

For a visual audit, visual-review-pr governs the screenshot report, three categories, inline posting, and verdict. The defaults below apply to source-only reviews. A request to post already supplies authorization; do not ask again.

Present the proposed review disposition in one short line, followed by the exact labeled findings ordered by severity. Do not repeat the findings in a separate summary or add a count for every label. If there are no findings, say no blockers or regressions were found and mention any material verification limit. Do not post a review or PR comment without explicit authorization.

If authorized, post only the approved findings and return the PR URL:

- Submit a `REQUEST_CHANGES` review if at least one approved finding is labeled `[blocker]`.
- Otherwise, submit a `COMMENT` review.
- If no findings survive, post one short no-blockers comment rather than an empty review.

## Boundaries

- Do not edit app code, commit, push, or resolve review threads under this skill. Writing audit evidence is allowed when browser testing applies.
- Do not turn review findings into implementation work without a separate user request.
- Use address-pr-review when the task is to modify an existing PR from reviewer feedback.
