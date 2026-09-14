---
name: visual-review-pr
description: Review a PR for UI regressions and whether its new behavior works, delegating browser testing when warranted and producing screenshot evidence plus self-contained PR findings. Use for visual PR review, screenshot QA, or testing affected app flows. For a URL or changelog without a PR, use web-regression-audit.
---

# Visual PR Review

## Decide and announce

Read the PR requirements, current diff, base branch, deployment details, and nearby callers. Briefly state each material decision and its reason when made: scope, baseline, UI testing needed or skipped, suite reuse, delegation/model, classification, verdict, and publishing. State concise conclusions and evidence, not private reasoning or a narration of tool calls.

Determine whether the change affects rendered UI, interaction, navigation, state, accessibility, or user-visible API/model output. Backend-only file paths do not prove there is no UI impact. State the affected paths and why browser testing is needed. If no UI behavior is affected, say why, perform the source review using review-pr, and skip the browser subagent and screenshot site. Respect an explicit source-only review request.

## Delegate the browser audit

Read ../web-regression-audit/SKILL.md and use its workflow for UI-impacting changes. Send a bounded browser audit to a subagent while the parent checks source, requirements, existing tests, and diff anchors. Use gpt-5.6-sol at medium initially; use gpt-6-astra at medium for complex cross-feature behavior or unresolved conflicting results. Follow explicit user model preferences. If unavailable, state the fallback. Do not claim a model or delegation was used when it was not.

Give the agent the skill path, exact PR/head/base, verified target and baseline URLs, affected routes and entry points, acceptance requirements, known suites, isolated browser/test-data scope, and artifact directory. Require the scenario ledger, screenshots, category and severity, reproduction evidence, and gaps. Split independent areas across agents only when useful; never share mutable browser tabs or test records. The parent reconciles results and checks alleged blockers before publishing.

No baseline is automatically correct: for stacked PRs use the intended parent; for deployed dev verify which commits it includes. Wait for the relevant deployment to finish, verify its revision, and keep stale-preview failures separate from code findings. Do not merge, rebase, deploy, or change app code merely to run a review.

## Deliver and post separately

Produce the web audit's screenshot site/report. Keep three finding categories: regression, new-feature defect, and pre-existing issue. Severity is separate; a new-feature defect may block merge even though it is not a regression. Default merge judgment focuses on regressions and required new behavior. Pre-existing findings remain nonblocking unless explicitly in scope; do not silently fix them.

When the user authorizes posting, publish one consolidated GitHub review after validation, with each actionable finding inline on a verified relevant diff line. Each finding must stand alone: category and severity, trigger and expected/actual behavior, impact, smallest fix, and brief evidence. Use two or three short sentences where possible. Do not replace findings with the audit-site link or require readers to open it. Screenshots can support a comment directly when useful.

Do not invent anchors for pre-existing issues or unavailable source: put those in a short, separately labeled review-body section if they cannot be attached honestly. Keep the audit link in the task's delivery, separate from the PR findings. Deduplicate existing comments rather than repeatedly posting the same findings. Recheck PR head before posting; if it changed, retest affected cases and update anchors.

Use REQUEST_CHANGES for confirmed blockers; APPROVE only when essential acceptance and regression checks support it and approval is possible; otherwise COMMENT with the remaining limits. Missing access or an untested path is not a passing result. If the user asked only for a draft, stop at the draft. A request to post already supplies authorization; do not ask twice. Return the review URL and separate audit artifact.
