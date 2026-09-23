---
name: monarch-release
description: Run or plan Monarch dev-to-staging-to-production bundle releases, with live deployment checks, exact image and Terraform revisions, release notes, approval gates and monitoring. Use for Monarch deployment and promotion requests, not standalone release QA or application fixes.
---

# Monarch releases

Target `TestBoxLab/monarch`, not the parent TestBox repository. Discover the checkout and verify its remote; the usual path is `/Users/bilal/projects/testbox/monarch`. Use authenticated GitHub CLI (`/opt/homebrew/bin/gh` on this host). Read current repository instructions and remote workflow definitions before dispatch: `deploy-dev.yml`, `release.yml`, relevant reusable deploy workflows, and `release-qa.yml`. They are authoritative if this skill drifts.

## Approval and scope

Start by waiting for the current dev deployment. Do not trigger another dev deployment merely to begin a release.

Treat dev, staging, notes/QA and production as separate checkpoints. Show the exact target and relevant evidence before asking to advance. An explicit instruction such as “stage after dev finishes” or “run production” already authorizes that checkpoint; do not ask again. Monitoring is part of an authorized deployment. A green staging run does not itself authorize production.

Do not automatically retry failed releases, change shared variables, enable integrations, cancel another run, roll back, merge code, or substitute a newer bundle. Diagnose the actual failure and obtain authorization for the concrete next action. Respect explicit exclusions of particular versions. Creating or using this skill does not itself authorize deployment, paid model calls, or Slack messages.

## 1. Wait for dev and establish the candidate

Resolve **remote** main, recent dev runs, and any active bundle release:

```bash
GH=/opt/homebrew/bin/gh
REPO=TestBoxLab/monarch
MAIN_SHA=$("$GH" api "repos/$REPO/commits/main" --jq .sha)
"$GH" run list -R "$REPO" --workflow deploy-dev.yml --limit 10 \
  --json databaseId,headSha,status,conclusion,createdAt,url
"$GH" run list -R "$REPO" --workflow release.yml --limit 10 \
  --json databaseId,number,status,conclusion,headSha,url
```

Select `DEV_RUN_ID` from observed results, based on the user's candidate or current dev run. If main advances, check whether the candidate was superseded; do not silently switch an already approved target. Inspect jobs and wait for successful completion:

```bash
"$GH" run view "$DEV_RUN_ID" -R "$REPO" --json status,conclusion,headSha,jobs,url
```

Path filters legitimately skip unchanged apps. An overall green run does not prove every component was rebuilt. Verify that each required fix actually reached its component deployment, using that component's last successful deploy and source SHA. A failed older run and a successful later attempt are distinct evidence; inspect attempts before describing a candidate as failed.

Normal staging snapshots current dev image pointers. `commit_sha` names the release candidate; it does **not** force all component images to that SHA. An exact historical SHA needs the repository's supported hotfix/source-image mechanism, not an invented staging flag. Report this distinction when it affects scope.

## 2. Deploy staging and monitor

After the staging checkpoint is authorized and the relevant dev run is green, recheck active releases and dev activity to avoid duplicate or racing dispatches. Set `CANDIDATE_SHA` to the verified remote candidate, then run:

```bash
"$GH" workflow run release.yml -R "$REPO" --ref main \
  -f environment=staging -f commit_sha="$CANDIDATE_SHA"
"$GH" run list -R "$REPO" --workflow release.yml --limit 5 \
  --json databaseId,number,status,headSha,createdAt,url
```

Identify the newly created run by dispatch time and metadata, not just the first list item. Save its ID and URL. Watch jobs through terminal status. FD can deploy independently of the Auth → Ingest → Enterprise chain; one failed job can leave other components deploying. Never describe a failed bundle as “nothing changed.”

```bash
"$GH" run view "$RELEASE_RUN_ID" -R "$REPO" --json status,conclusion,jobs,url
"$GH" api "repos/$REPO/actions/runs/$RELEASE_RUN_ID/pending_deployments"
"$GH" api "repos/$REPO/actions/jobs/$FAILED_JOB_ID/logs"
```

Inspect pending deployments only if a job waits unexpectedly. Report a required environment approval separately from runner scheduling. Read actual failed logs; do not assume the previous failure recurred.

For long runs, use a thread heartbeat roughly every two minutes. Include the exact repository, run ID, target bundle and authorization boundary; notify only meaningful milestones, failures, required action and completion. Pause the monitor after terminal verification. Do not let the monitor retry, cancel, change settings, send Slack messages or promote the next environment.

On success, verify smoke checks, kit release and manifest publication. Discover the exact bundle version from this run's output or associated published release; do not manufacture it from a run number. Set `BUNDLE_VERSION` and download its manifest:

```bash
"$GH" release download "bundle-$BUNDLE_VERSION" -R "$REPO" \
  --pattern manifest.json --output "$MANIFEST_PATH"
curl --fail --silent --show-error --max-time 20 \
  https://app-staging.monarchagents.ai/api/
```

Use a fresh temporary `MANIFEST_PATH`. Inspect `bundleVersion`, `gitSha`, `images.*.shaTag`, `images.*.digest`, staging `deployedAt`, kit and saved production baseline. Verify required fixes are included in the relevant component SHA.

**Images and Terraform are separate evidence.** Reusable deploy workflows can check out each component's pinned SHA for Terraform. A fix merged into main will not repair an older bundle's pinned Terraform. Conversely, GitHub variables and external configuration can change between staging and production even when image digests are identical. Verify the actual workflow checkout and environment-specific inputs; do not promise production success from staging alone.

## 3. Release notes and QA checkpoint

Check whether Release QA started for this exact release:

```bash
"$GH" run list -R "$REPO" --workflow release-qa.yml --limit 10 \
  --json databaseId,status,conclusion,createdAt,event,url
```

Correlate the reporting run to the release run or bundle. Inspect saved reports, diagnostics and publication receipts. A reporting run can fail while publishing a fallback report; distinguish coverage validation, publication and Slack delivery. Generated QA notes are a test plan, not evidence that those tests ran.

If no report started, inspect the current trigger and default-branch workflow. Do not assume it is automatic merely because the deployment passed. Production reporting may require the **saved staging report for the same bundle**; a missing report requires an explicit backfill, not another production deployment.

When manual generation and its paid analysis/publication are authorized, use current workflow inputs. Example for the verified bundle:

```bash
"$GH" workflow run release-qa.yml -R "$REPO" --ref main \
  -f environment=staging -f version="$BUNDLE_VERSION" \
  -f post_to_slack=false -f max_cost_usd=1
```

The cost cap is an example, not authorization. Set `post_to_slack=true` only with explicit user authorization and verify the current destination; do not hardcode a historical channel. Reuse saved output when supported instead of paying to regenerate it.

Wait for release/QA notes and present their material checks and gaps. Ask for production approval against that exact bundle and available QA evidence. There is no assumed complete regression process. If the user explicitly approves promotion despite missing notes or manual QA, retain that limitation and proceed without repeating the approval question.

## 4. Promote the approved bundle to production

Recheck successful staging, the exact manifest, required fixes and active releases. Capture the previous recorded production bundle as a rollback reference, while noting any intervening partial deployments. Do not automatically roll back.

Use the **bare manifest bundleVersion**, not the GitHub `bundle-` tag prefix, for both inputs:

```bash
"$GH" workflow run release.yml -R "$REPO" --ref main \
  -f environment=production \
  -f version="$BUNDLE_VERSION" -f confirm="$BUNDLE_VERSION"
```

Capture the new run ID and monitor as for staging. Do not create duplicates when the run queues behind another release. After success, download the updated manifest to a new path, confirm production `deployedAt`, verify smoke/kit/publication jobs, and check:

```bash
curl --fail --silent --show-error --max-time 20 \
  https://app.monarchagents.ai/api/
```

HTTP 200 is availability evidence only. Inspect accessible service health, errors and logs when available; explicitly state any access limitation. Check production release reporting independently. Report deployment success even if notes fail, while identifying the separate reporting failure.

## Authorized cancellation

Only when requested, cancel the exact identified run. If normal cancellation remains stuck, use force-cancel and verify terminal status:

```bash
"$GH" run cancel "$RUN_TO_CANCEL" -R "$REPO"
"$GH" api --method POST "repos/$REPO/actions/runs/$RUN_TO_CANCEL/force-cancel"
"$GH" run view "$RUN_TO_CANCEL" -R "$REPO" --json status,conclusion
```

These are sequential alternatives, not an instruction to force-cancel immediately. Cancellation does not undo migrations, image-pointer updates or completed deployments. Never promise it will leave an environment unchanged.

## Completion

Return the run link, exact bundle, confirmed deployment and smoke status, notes/QA status, and any remaining blocker. Stop the completed monitor. Keep release history and one-off SHAs out of this reusable skill.
