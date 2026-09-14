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

## Focus on blockers and regressions

- Prioritize concrete correctness, security, data-loss, concurrency, and compatibility defects introduced or worsened by the change.
- Verify the failure scenario against callers, requirements, and nearby code before reporting it. State what triggers it and what breaks.
- Report structural, reuse, scope, or verification concerns only when they cause a concrete defect, violate an explicit requirement, or leave a material regression risk unsupported by checks.
- Omit pre-existing problems, style preferences, speculative cleanup, optional refactors, praise, and unrelated debt. Broaden to nonblocking improvements only when the user explicitly requests them. Zero findings is valid.

For every blocker or suggestion, write a self-contained finding that makes sense without the PR body, surrounding diff, or prior conversation:

- **Why:** In one or two short sentences, lead with the concrete user or system impact, then name the code behavior that causes it.
- **Fix:** In one short final sentence, give the smallest corrective change and include the required regression test when behavior changes.
- Cite the exact path and tight line range.

Aim for two or three short sentences per complete **Why/Fix** item. Supply only the context needed to understand the trigger, impact, cause, and smallest fix. Do not make the reader reconstruct impact, cause, or remediation from implementation details. For every question, provide path and line, the relevant context, and the direct question.

## Label every finding

Assign exactly one semantic label and prefix the finding with it:

- `[blocker]`: An evidence-backed defect that must be fixed before merge because it violates required behavior or creates a material correctness, security, data-loss, compatibility, or regression risk.
- `[suggestion]`: A concrete nonblocking improvement; include only when the user explicitly requested a broader review.
- `[question]`: An unresolved ambiguity necessary to assess a potential blocker or regression. Give the concrete scenario, ask directly, and do not imply that an unverified defect is established.

Do not use a question as a softer substitute for a known defect. Do not mark a suggestion or question as a blocker without repository, requirement, or behavioral evidence.

## Draft before posting

Present the proposed review disposition in one short line, followed by the exact labeled findings ordered by severity. Do not repeat the findings in a separate summary or add a count for every label. If there are no findings, say no blockers or regressions were found and mention any material verification limit. Do not post a review or PR comment without explicit authorization.

If authorized, post only the approved findings and return the PR URL:

- Submit a `REQUEST_CHANGES` review if at least one approved finding is labeled `[blocker]`.
- Otherwise, submit a `COMMENT` review.
- If no findings survive, post one short no-blockers comment rather than an empty review.

## Boundaries

- Do not edit files, commit, push, or resolve review threads under this skill.
- Do not turn review findings into implementation work without a separate user request.
- Use address-pr-review when the task is to modify an existing PR from reviewer feedback.
