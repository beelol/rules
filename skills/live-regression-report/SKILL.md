---
name: live-regression-report
description: Use when asked to run live application regression checks and publish their screenshot evidence as a public artifact or ChatGPT Site, or update that report after further live checks. For full Monarch release discovery use monarch-release-audit; for converting evidence into automated tests use visual-audit-to-tests.
---

# Live regression report

Deliver a working public report of observed live behavior. Start with the user's selected flows; expand only to relevant adjacent checks. Use existing evidence from the current task when sufficient, then execute missing checks. This skill does not authorize application deployments, fixes, account changes, or unrelated executions.

## Establish the run

- Confirm the requested app environment and browser profile from available context. Use the authenticated browser the user selected; request login when needed. Preserve corrections across turns. Stop if navigation crosses into an unintended environment.
- Use the actual test date and timezone. Reuse the current report for follow-ups; create a separate dated report when requested. A previous report supplies presentation ideas, never current results.
- Create a compact scenario ledger: ID, behavior, prerequisites, actions, expected outcome, actual outcome, status, timestamp, environment/revision if verified, actor, run/record links, screenshot paths, and scope limits.
- For release notes, map each behavior-bearing bullet and its commits to scenario IDs. Keep general regression checks separate.

## Run and capture

Use the supported live browser tools. Exercise actions through their terminal outcome, including save/reload persistence where relevant. Verify outputs, not merely available controls or saved configuration. Capture actual browser screenshots at decisive states; inspect each original against its caption.

For multi-flow requests that warrant delegation, use a few available low-cost agents, respecting the user's model preference and concurrency limits. Assign isolated tabs/records and bounded scenarios. Parent coordinates shared state, reviews returned evidence, and owns publishing. Small follow-ups can run locally. Wait for agents' evidence before assigning results.

Record whether the agent executed the test or independently verified a user-started run. Keep observations attached to their scenario ID: a retry in one flow must not change another flow’s verdict. Preserve failures and retries. Inspect downstream receipts when available: an accepted Slack response proves acceptance; it does not prove somebody read the message. Avoid repeating externally mutating runs merely to obtain another screenshot. Test authorization does not automatically authorize disclosing private records or messaging others.

Use explicit outcomes:

- **Passed:** the stated check executed and met its expected outcome.
- **Completed · retry needed:** the outcome succeeded after a recorded retry.
- **Failed:** observed behavior violated the expected outcome.
- **Blocked / Not run:** the assertion was not exercised; explain the missing prerequisite.

Scope a pass to the actual branch. Deduplicating existing records can pass while new-record creation remains untested. Identify a regression only with evidence of worsening against a verified baseline; otherwise report an observed defect with attribution unknown. Never promise proof of zero regressions or run indefinitely trying to establish it.

## Build the artifact

Put current results on the homepage, with:

1. Product, environment, test date/timezone, and a short outcome summary.
2. One section per tested behavior: status, action/input, observed result, timestamp, relevant run/source link, and captioned screenshots opening at full size.
3. Separate general checks when release-specific checks are present.
4. Clearly linked additional checks and limits. Optional untested branches must not turn successful checks into vague “partial” results. Material failures and retries remain visible with the affected result.

Use a readable responsive layout with simple navigation. Keep private ticket contents, credentials and unnecessary personal data out of public screenshots and prose. Capture a suitable result surface or redact a publication copy while retaining the private original locally. Label redactions; never alter evidence to imply success. Preserve the ledger and source evidence locally.

## Publish and verify

Discover current Sites tools and read their current publishing instructions. Reuse the report's existing project and source checkout. Keep authentication material out of output and artifacts. Publish only the authorized audience and content; publishing this report is separate from deploying the application under test.

Wait for successful deployment, then verify public access without authentication and inspect the live report in the browser. Confirm current date/content, navigation, screenshot loading and full-size links. A saved version or authenticated preview is not a public deployment. If hosting is unavailable, retain a local artifact and report that precise blocker without claiming publication.

Save publication metadata (URL, project/version/deployment IDs, source revision, access verification). Finish with the public link, the verified result, and any material limitation. Generate reusable automated tests only when requested, using visual-audit-to-tests if available.
