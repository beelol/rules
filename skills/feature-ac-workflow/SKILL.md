---
name: feature-ac-workflow
description: Use when a user wants to organize a new or existing project into linked feature RFCs, a README acceptance-criteria checklist, and a resumable agent goal for verified incremental delivery. Also use to reconcile an existing feature board. Not for an isolated bug fix or an ordinary status summary.
---

# Feature and Acceptance Workflow

Turn project intent and repository evidence into a development contract that a
fresh driver can resume without chat history. Default deliverable is project
planning documents, not execution of the generated goal.

## Establish current truth

Read repository instructions, root README, existing feature plans, RFCs, durable
knowledge, relevant code and tests, and delivery conventions. For a new project,
use the supplied brief and identify decisions that still need answers. Do not
invent implementation paths, approved features, platform support, or passing tests.

Reconcile conflicts using the user's latest decisions and current evidence.
Keep correct completed work. Split local implementation, device verification,
and deployed behavior when evidence covers only one. Treat an old audit as
leads to check, not an instruction to implement every suggestion. Retain useful
technical decisions and historical evidence when removing duplicate boards.

## Write the feature contract

Use the repo's existing document locations and names. Otherwise use `work/` for
concise feature RFCs and `knowledge/` for durable current facts. Each feature has
one owner document covering:

- Outcome, current state, intended behavior, dependencies, and deferred scope.
- Material user or operator journeys: success, refusal, failure and retry,
  interruption, recovery, and account or device change where relevant.
- Existing implementation locations and why authority belongs there. Distinguish
  proposed modules from files that actually exist.
- Relevant security and data-preservation requirements: ownership, authorization,
  atomic writes, replay and concurrency protection, migration, backup, and recovery.
- Actual platform and distribution constraints. Separate OS from store/channel.
  Verify current external payment, signing, privacy, and policy rules against
  primary sources and record source/date. Do not copy one project's platform list.
- How each behavior will be verified and where merged evidence will be recorded.

Money and durable entitlements require trusted backend authorization and records.
Distinguish gameplay earnings, paid transactions, ad rewards, and spending when
applicable. Client callbacks and local balances do not prove payment or ownership.
Feature UI stays with its feature. Shared UI cleanup has a separate narrow owner.
Do not impose payment, mobile, or deployment machinery on projects that lack it.

## Append one README board

Preserve existing README content. Append `Ready for Go` as the final root README
section, or update its existing equivalent in place without making a second board.
If the README is missing, create a short project introduction first. Put the
copyable driver goal before the feature list in this final section by default.
If the repo already has a clearly placed driver goal, update it there and link
it from the board. Explicit user placement wins.

Each feature checkbox is a linked parent with at least one nested AC checkbox,
including deferred features. For an unscoped idea, either write a short owner
document with an approval AC or leave it as a plain deferred note, not a task. Give every
AC a stable unique ID. Write observable outcomes small enough to verify and
merge as a coherent change. Split independent providers, stages, or behaviors
when they can ship separately. Use as many ACs as the feature needs, not a fixed
count. Put implementation detail and evidence in the linked RFC, not huge ACs.

Include completed ACs as checked with evidence, not just missing work. An
unsupported completion claim becomes an open verification AC, with the earlier
claim retained as context. Check a feature only when all its children are done.
Preserve IDs on reruns. A discovered in-scope gap adds an AC and reopens its
feature. Never delete or shrink unmet requirements to manufacture completion.

Separate authorized current work, release verification, and explicitly deferred
or optional scope. Do not invent launch blockers or move deferred features into
current scope. Owner documents link the README IDs instead of duplicating the
completion board. Detailed operational runbooks may remain in their canonical home.

## Create the driver goal and handoff contract

Read [the document shapes and goal model](references/document-shapes.md). Adapt
all paths, integration branches, scopes, and test instructions to the inspected
repo. The copyable goal must be **under 4,000 characters**. Its text must contain the
required slots listed in the reference, including the full handoff lifecycle and
parent completion rule. Instructions outside the copied block do not travel
with it. Make it explicit about this loop:

1. Name the AC location inside the copied goal: root `README.md` → `Ready for Go`
   → `Current features`, in the nested checkboxes below each linked feature.
   If the repo uses different headings, name their exact hierarchy instead.
   Explicitly list any additional authorized AC sections, then read the optional
   handoff, selected RFC, knowledge, and code.
2. Select the smallest actionable AC respecting dependencies and authorized scope.
3. Delegate bounded work to the least costly capable available subagent, with
   enough context and owned files. Use stronger review for consequential risk,
   not every task. Work directly if delegation is unavailable or not authorized.
4. Implement and verify working behavior, including relevant failure paths and
   real UI/device checks. Record commands or steps, outcomes, environment, and
   delivery reference. Inspect delegated results before accepting them.
5. Deliver and merge small verified changes through the actual repo process when
   authorized. Include AC and parent-status updates in the verified delivery.
   An unmerged branch is not completed mainline work. Confirm remote integration.
6. Reread all ACs after integration. Add observed gaps, reopen affected features,
   and continue until all authorized ACs are verified and integrated. Recheck
   affected completed ACs after changes, not every historical test on every loop.

Keep temporary constraints of this planning session separate from future driver
capabilities. For example, a current “do not delegate” instruction does not
justify permanently removing conditional delegation from the reusable goal.

A planning request does not authorize executing the goal. The generated goal
must preserve the user's actual implementation and merge authority. It must not
invent permission to merge, spend, deploy, publish, or destroy data. Blocked or
unapproved actions stay open while independent work continues. Stop honestly when
scope is complete, the user stops work, a budget ends, or all remaining work is
blocked. Never claim future unattended execution without an available authorized
runner; writing a goal does not schedule it.

Use one optional current handoff file, default `work/HANDOFF.md`. Replace it at
meaningful transitions and before stopping. Record current ACs, checkout,
unmerged changes/PRs, evidence limits, blockers, and exact next action. Remove it
when nothing needs transfer. Keep durable facts and completed evidence in their
proper documents, not an accumulating driver diary.

## Verify the planning deliverable

Check local links, unique stable IDs, parent/child completion consistency, goal
character count, required driver-goal slots, and final README placement. Check
the copied block itself, not just surrounding explanation. Compare the new board against every
relevant old scope so consolidation does not silently drop requirements. Inspect
checked items against their evidence. Explain any unresolved decisions as open
ACs instead of fabricated answers. On a rerun, update existing sections and
preserve history and IDs. Report the README link and important limits concisely.
