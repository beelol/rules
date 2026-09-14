# Visual Testing Skills

- Overmind owns review-pr routing, visual-review-pr, web-regression-audit, and visual-audit-to-tests; app repositories own test suites and audit artifacts.
- PR review checks actual user-facing impact before delegating browser testing. URL/changelog audits work without a PR.
- Browser work initially uses Sol medium; Astra medium handles complex or disputed cases. Parent review reconciles evidence before publishing.
- Findings distinguish regressions, new-feature defects, and pre-existing issues; uncertainty and severity are separate. Feature acceptance and regression verdicts remain distinct.
- Deliver a screenshot audit site/report and independently understandable inline PR findings when posting is authorized.
- Discover and run existing suites first. Convert verified steps using local test standards when requested, and retain scenario-to-test mappings for later audits.
