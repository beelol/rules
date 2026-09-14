---
name: visual-audit-to-tests
description: Turn verified browser-audit scenarios or manual regression steps into reusable tests using the app's existing test standards. Use when asked to automate visual QA steps, preserve an audit as a suite, or add regression coverage from a report. Does not run a broad visual audit by itself.
---

# Turn Audit Steps into Test Suites

Briefly state each material decision and why when made: standards found, suite and test level, scenarios selected or deferred, fixture approach, assertions, and verification outcome. Give practical conclusions, not private reasoning or tool-by-tool narration.

## Discover before writing

Read repository instructions, contribution guidance, package scripts, test and CI configs, nearby suites, fixture/setup helpers, and the source behind audited paths. Read the audit ledger and report. Derive the established naming, folder structure, runner, selectors, authentication, data setup/cleanup, and supported commands from evidence. Reuse existing suites and helpers before adding files or dependencies. If repository access or essential test standards are unavailable, report the missing context; do not invent a test harness.

Map each verified scenario to an existing test or the smallest appropriate new coverage: pure logic, component interaction, integration, browser end-to-end, or visual snapshot. Use browser tests for actual navigation, persistence, reachability, and integration behavior; use snapshots only for meaningful visual differences under stable conditions. Avoid brittle tests for exact implementation structure or incidental wording.

## Implement durable coverage

Keep tests within the app's existing feature boundaries. Extract shared fixtures/helpers through established modules only when reused. Extend a matching suite rather than duplicating it. Use observable outcomes, accessible/stable selectors, deterministic data, and condition-based waits. Preserve realistic edge cases from the audit, including the preconditions that triggered the defect. Avoid dependence on mutable personal accounts or live customer data.

For a confirmed bug, encode the intended correct behavior, not the current broken output. Where feasible demonstrate that the regression test fails against the faulty behavior and passes with the fix. Do not bless a failing screenshot as the new baseline, silently skip failures, weaken assertions, or fix unrelated app behavior. If the fix is outside scope, report the failing test and follow the repository's documented handling rather than presenting the suite as green. If the repository has no documented handling for an unfixed failure, leave the failing test uncommitted with its result recorded, continue independent coverage, and ask whether to include the app fix or defer that scenario before committing the suite. Do not invent a skip or quarantine policy.

For live AI/model cases, distinguish deterministic wiring tests from real-model evaluations. Reuse the project's evaluation tooling and consult its applicable guidance; mocked responses cannot prove live-model compliance. Preserve manual or environment-dependent scenarios with an explicit reason when reliable automation is not yet possible.

## Verify and make reusable

Run the new/changed tests, the relevant existing suite, and required focused checks. Record failures and limits honestly. Update the audit's scenario-to-test mapping with scenario IDs, repository-relative suite paths, commands, fixture requirements, expected outcomes, and manual gaps. Put durable feature/testing guidance in the project's existing knowledge or test documentation; avoid a parallel test registry when the project already has one.

Future audits must discover and run these suites first, then explore changed paths and uncovered states. A saved mapping is a starting point: check it against the current app and requirements rather than blindly replaying stale steps. Deliver test locations, commands and results, scenarios automated, and remaining manual checks. Commit/push only within the user's authorization.
