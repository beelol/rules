---
name: visual-review-pr
description: Review a PR for UI regressions and whether its new behavior works, delegating browser testing when warranted and producing screenshot evidence plus self-contained PR findings. Use for visual PR review, screenshot QA, or testing affected app flows. For a URL or changelog without a PR, use web-regression-audit.
---

# Visual PR Review

Use **review-pr** (../review-pr/SKILL.md) for scope confirmation, independent source/product review passes, final packets, revisions, and posting. This skill supplies browser evidence. When called by review-pr, continue its existing review rather than restarting confirmation or its passes.

## Decide and announce

Read the PR requirements, current diff, base branch, deployment details, and nearby callers. Briefly state each material decision and its reason when made: scope, baseline, UI testing needed or skipped, suite reuse, delegation/model, classification, verdict, and publishing. State concise conclusions and evidence, not private reasoning or a narration of tool calls.

Determine whether the change affects rendered UI, interaction, navigation, state, accessibility, or user-visible API/model output. Backend-only file paths do not prove there is no UI impact. State the affected paths and why browser testing is needed. If no UI behavior is affected, say why, perform the source review using review-pr, and skip the browser subagent and screenshot site. Respect an explicit source-only review request.

## Delegate the browser audit

Read ../web-regression-audit/SKILL.md and use its workflow for UI-impacting changes. Send a bounded browser audit to a subagent while the parent checks source, requirements, existing tests, and diff anchors. Use gpt-5.6-sol at medium initially; use gpt-6-astra at medium for complex cross-feature behavior or unresolved conflicting results. Follow explicit user model preferences. If unavailable, state the fallback. Do not claim a model or delegation was used when it was not.

Give the agent the skill path, exact PR/head/base, verified target and baseline URLs, affected routes and entry points, acceptance requirements, known suites, isolated browser/test-data scope, and artifact directory. Require the scenario ledger, screenshots, category and severity, reproduction evidence, and gaps. Split independent areas across agents only when useful; never share mutable browser tabs or test records. The parent reconciles results and checks alleged blockers before publishing.

No baseline is automatically correct: for stacked PRs use the intended parent; for deployed dev verify which commits it includes. Wait for the relevant deployment to finish, verify its revision, and keep stale-preview failures separate from code findings. Do not merge, rebase, deploy, or change app code merely to run a review.

## Deliver and post separately

Produce the web audit's screenshot site/report. Keep three finding categories: regression, new-feature defect, and pre-existing issue. Severity is separate; a new-feature defect may block merge even though it is not a regression. Default merge judgment focuses on regressions and required new behavior. Pre-existing findings remain nonblocking unless explicitly in scope; do not silently fix them.

Deliver findings through review-pr's complete vertical packet for each PR: private explainer, exact top-level body, then exact inline comments with What / Why / Fix. Preserve the audit category in the explanation and use review-pr's severity labels. Keep trigger, expected/actual behavior, impact, smallest fix, and relevant evidence self-contained; screenshots supplement the text.

Do not invent anchors for pre-existing issues or unavailable source: propose them in a separately labeled review-body section when relevant to the agreed scope. Keep the audit link in the task's delivery, separate from the PR findings. Check existing comments to avoid duplicate findings.

Use review-pr's approval, freshness, verbatim posting, event, and partial-failure rules for both source and visual reviews. A format approval or an initial request to post does not approve unseen wording. Return confirmed review links and the separate audit artifact after posting. Missing access or an untested path is not a passing result.
