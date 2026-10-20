---
name: monarch-core-qa
description: Run Monarch's standalone Core QA playbook at the user's chosen Tier A, B, or C, then publish an evidence-backed public ChatGPT Site or equivalent shareable artifact. Use for core QA requests outside release deployment; do not use for release promotion or change-specific QA alone.
---

# Monarch Core QA

Run the repository's current Core QA playbook and publish a public report that a new reader can understand without this chat. The [example report](https://monarch-core-qa-20261016-b17ff42.bilalitani4.chatgpt.site/) is a presentation reference, not evidence for a new run or a fixed checklist.

## Choose the tier before testing

If the user has not already chosen a tier for this run, use the available question-prompt tool to ask **“Which Core QA playbook should I run: A, B, or C?”** Offer these choices and wait for the answer:

| Choice | Scope from the playbook |
| --- | --- |
| A — pages smoke | Signed-in pages and navigation; about 5 minutes. |
| B — core paths | All A checks, plus one serial saved-workflow run and one serial authoring job; about 10–15 minutes. |
| C — full concurrency | All A and B checks, plus discovery, three-way authoring and execution, a mixed batch, and cancellation; about 30–60+ minutes. |

If the user already named A, B, or C, use that choice. Do not substitute a lower tier because fixtures are missing or a check fails. Creating or editing this skill does not start a QA run.

## Establish the authoritative run

Read the current `TestBoxLab/monarch` default-branch `docs/core-qa/README.md` and the chosen tier's runbook. Read inherited runbooks too: B includes A; C includes A and B. Record the playbook commit separately from the deployed candidate, build commit, and fixture revision. The playbook's requirements and safety rules take precedence over this skill's summary. Read the current repository instructions and deployment evidence before operating the application.

Verify the user-approved non-production environment, organization, candidate, tester role, browser session, and dedicated test data. Prefer the user's authenticated session. Request the necessary session or fixture information when inaccessible; continue independent safe checks. Tier A needs a known graph. Tiers B and C need the reviewed, frozen fixture manifest in restricted operational records. Do not invent or silently revise bindings, expected outputs, canonical answers, accounts, or credentials. If binding is missing, prepare the exact proposed binding and obtain its review before fixture-backed execution.

Execute only the chosen tier's safe operations. Use existing working Product accounts and bounded read-only fixtures. Do not deploy, fix application code, activate or schedule authored workflows, approve writes, change credentials or access, use customer data, or message people. Observe the approved QA spending allowance. Stop the affected scenario if a safety or allowance prerequisite is missing.

## Execute and retain evidence

Expand every required preflight item, page and viewport, step, fixture result, and concurrency assertion into a run ledger before testing. Start each row as `NOT RUN`. Follow the playbook order and exact frozen inputs. Use actual browser actions through terminal outcomes, including reload persistence. For Tier C, prove real three-way overlap with the playbook's required observations and timestamps; near-simultaneous submissions alone do not pass. Keep retries as separate attempts and continue independent checks when safe.

For each row retain its playbook heading and pinned link, expected and actual behavior, native `PASS`/`FAIL`/`BLOCKED`/`NOT RUN` status, UTC time, actor, environment and revisions, action/input, fixture and workflow/job/run IDs, result links, screenshots, and relevant console or network errors. Capture original screenshots at the starting, progress, terminal, and persisted states where applicable. Inspect each original against its caption. A saved setting, old run, CI result, or screenshot without outcome evidence cannot establish a pass. Keep raw fixture bindings and evidence in the team's restricted location.

## Publish the report

Read [report-and-publication.md](references/report-and-publication.md). Use the installed Sites workflow to build and publish a **public ChatGPT Site**; use an equivalent public artifact only when Sites is unavailable or the user chooses another host. Public access is part of this workflow, but inspect every publication copy for secrets, private records, and unnecessary personal data first. If safe redaction would remove the evidence needed to support a claim, explain the limit and keep the original in restricted storage. Do not turn blocked or unexecuted checks into observed product defects.

Verify the live URL and anonymous access, every required criterion, screenshot loading and full-size links, captions, and counts before finishing. Return the public URL, chosen tier, environment/candidate, overall result, counts, and material failures or blockers. A local preview or saved unpublished version is not a public report.
