---
name: web-regression-audit
description: Test a web page or app for regressions, validate a changelog or release, or exercise affected user flows with screenshots and an audit report. Works without a PR. For PR-specific routing and inline posting, use visual-review-pr. Does not redesign or fix the app unless requested.
---

# Web Regression and Feature Audit

## Decisions and scope

Briefly state each material decision and its reason when made: what to test, comparison baseline, suite reuse, delegation/model, environment, classification, scope changes, and final verdict. Use plain-language conclusions backed by evidence, not private reasoning. Bundle related decisions; do not narrate each click.

Accept a URL, PR context, changelog, release range, or feature checklist. Discover available repository instructions, routes, changed shared components and callers, feature requirements, and existing tests. For a changelog, map every in-scope entry to concrete acceptance scenarios and affected existing flows. For a URL-only request, map the requested page and reachable relevant paths; without a verified baseline, report observed defects and acceptance results but do not claim proven regressions. Ask for missing baseline or requirements only when needed, while continuing independent discovery.

Build a coverage ledger before testing. Give scenarios stable IDs and record purpose, route/entry point, setup and data, actions, expected result, target/baseline revisions, viewport/theme/role, suite mapping, observed results, screenshots, and pass/fail/blocked/not-run status. Keep it in the repository's established audit location; otherwise use artifacts/web-audits/<scope>/ with report.md, scenarios.json, and screenshots/. The JSON must contain concrete scenario records, not executable code or invented observations.

Cover every affected app path identified from the change and callers, not only default screens. Track untested paths explicitly. Include relevant happy paths and edge states: menus and dialogs, loading/empty/error states, long data, history and legacy records, unsaved state, back/refresh navigation, keyboard/focus, narrow widths, resizing, themes, and roles. Scale coverage to actual impact; an app-wide shell change requires broader route coverage than a local control change.

## Reuse and delegate

Search test configs, package scripts, neighboring suites, fixtures, and previous scenario ledgers first. Run applicable existing suites through their supported commands. Record what they cover and explore new or uncovered behavior in the browser. Never equate a passing suite or a screenshot with proof of all affected functionality.

For independent browser work, delegate bounded path groups to gpt-5.6-sol at medium while the parent performs useful source/suite/coverage work. Use gpt-6-astra at medium for difficult cross-feature checks or disputed results; explicit user preferences win. Announce the model and reason, use isolated tabs and test records, and require concrete evidence back. If delegation or the model is unavailable, state the fallback and continue locally. Do not spawn an agent merely to wait for it.

## Compare real behavior

Verify target and baseline revisions and deployment readiness before comparing. Use matching inputs, records or equivalent seeded fixtures, roles, viewports, themes, and actions. Compare the appropriate deployed baseline or parent revision, not an arbitrary older screenshot. Record redirects and environment drift; do not continue testing in an unintended environment.

Prefer real authenticated application behavior. Clearly label synthetic fixtures, mocked APIs, and isolated component renders; they cannot establish live integrations or model behavior. Use safe test records. Do not perform destructive actions or send messages through connected services unless authorized. If access is blocked, record the gap and continue what is available without treating it as a pass.

Exercise controls and verify outcomes, persistence, errors, and reachability. Inspect rendered screenshots and relevant console/network evidence. Let animations and asynchronous state settle before judging steady-state failures; test loading states separately. Do not let screenshot helpers or patched startup settings mask a defect in normal startup.

Reproduce suspected failures on the baseline before assigning cause. For nondeterministic generation, compare identical prompts and inputs on fresh independent artifacts as well as repeat runs of the failing artifact. A successful retry does not prove the failure cannot be caused by the change; preserve failures and mark attribution uncertain when evidence is insufficient. Resolve conflicting agent reports using matched conditions and direct checks.

## Three categories, separate severity

- **Regression:** behavior that worked on the verified baseline now breaks or materially worsens.
- **New-feature defect:** added or explicitly changed behavior fails its requirement, including a new use of a pre-existing limitation.
- **Pre-existing issue:** equivalent behavior already fails on the baseline and is not worsened by this change.

Assign blocker/nonblocker separately from category. New-feature defects can block acceptance. Pre-existing findings ordinarily do not block the change and are fixed only when requested. Mark uncertain attribution as unverified in the ledger; do not force it into a proven category. Report feature acceptance and regression results separately, including gaps. In regression-only scope, keep other findings separate from the verdict.

## Evidence and delivery

Create a browsable audit site and a concise Markdown report with the same three category sections, coverage ledger, acceptance/regression verdicts, tested revisions, and limitations. Include screenshots for tested behavior and findings, with matched baseline/target pairs where available, captions, reproduction steps, and expected/actual results. Support easy navigation by scenario and full-size viewing. Mark unavailable comparison images honestly. Keep screenshots tied to their scenario IDs and conditions.

Use Sites building/hosting skills when available for a hosted audit; otherwise deliver a self-contained local HTML gallery with relative image paths. Follow publication authorization and access controls, and do not expose credentials or sensitive test data. Verify that the gallery renders and its images/links load. Keep audit artifacts out of the feature diff unless requested. Do not claim a local gallery is hosted.

For a PR, return evidence to visual-review-pr for standalone inline findings and a separate verdict; do not post duplicate reviews from subagents. Without a PR, deliver the audit and do not invent a PR destination. Summarize confirmed blockers first, then feature acceptance, pre-existing findings, and remaining gaps. State only coverage actually achieved.

When asked to preserve these steps as automated suites, use ../visual-audit-to-tests/SKILL.md. Always retain reproducible scenarios so a later run can reuse existing suites and continue the remaining checks.
