# Document Shapes

Adapt these shapes to the project's conventions. Replace example names, paths,
and IDs with inspected project facts. Do not copy example completion as evidence.

## Root README ending

Keep existing introduction and operating instructions. Add or update one final
section. The goal and board are reusable output, not an instruction to start
implementation while preparing the plan.

````markdown
## Ready for Go

### Continue development

Copy this goal into a driver. Current scope is the unchecked ACs below.
Deferred work is excluded unless explicitly activated.

```text
[Insert the adapted driver goal, under 4,000 characters.]
```

### Current features

- [ ] **[Document export](work/document-export.md)**
  - [x] **EXPORT-01** A user can download their own document. [Existing evidence](work/document-export.md#evidence).
  - [ ] **EXPORT-02** Another account cannot download the document, including through a guessed ID.
  - [ ] **EXPORT-03** An interrupted export can be retried without losing or duplicating saved content.

### Deferred

- [ ] **[Scheduled exports](work/scheduled-exports.md)**
  - [ ] **SCHEDULE-01** Approve frequency, retention, and delivery rules before implementation.
````

The checked example is valid only when evidence exists. A feature without any
completed implementation should have no checked children. Split an AC if a
verified subpart can be delivered independently. Reuse IDs already in the repo.

## Concise feature document

Use these fields only as much as the feature needs:

- **Outcome and acceptance:** intended result, scope, README AC IDs and link.
- **Current behavior:** inspected code and scoped evidence versus planned work.
- **Journeys:** actor, trigger, expected result, recovery, and identity boundaries.
- **Implementation:** existing modules and interfaces, changes needed, ownership
  of authoritative state, transactions, permissions, migrations, and data recovery.
- **Platform limits:** actual targets, channels, external dependencies, policies,
  and what remains disabled until verified. Cite current primary sources when needed.
- **Evidence:** AC ID, test command or manual steps, observed result, environment,
  commit or PR, and limits. Link preserved older evidence with its original scope.
- **Dependencies and deferred work:** who owns adjacent behavior and unresolved decisions.

## Adaptable driver goal

The block below is an example, not an automatic grant of execution or merge
permission. Fill in the actual locations, authorized scope, integration branch,
and repository-specific verification commands. Count the adapted block.

Required slots **inside the copied goal**, even when shortening it:

1. Exact reading entry points and the authorized versus deferred scope.
2. Least costly capable delegation when available and authorized, with direct fallback.
3. Small coherent AC delivery, relevant verification, and evidence location.
4. Actual integration branch/process and authority, without invented permissions.
5. Parent checked only when every child is done; a new gap adds an AC and reopens it.
6. Reread the board after integration and recheck affected completed ACs.
7. Exact optional handoff path, replacement contents, update timing, and deletion
   when there is nothing to transfer. “Read any handoff” alone is insufficient.
8. Continue until authorized ACs close, with honest blocked/budget/user-stop exits.

Treat this as an output contract, not a fixed wording template. Check each slot
in the final block before delivering it.

```text
Continue this project's authorized development from repository state, without relying on previous chat history.

Read AGENTS.md, the root README Ready for Go section, and work/HANDOFF.md if present. Read the selected feature document, linked knowledge, relevant code, and test conventions. The README is the AC board. Feature documents explain behavior, journeys, implementation boundaries, security, and platform limits. Historical evidence is not a fresh test result.

Choose the smallest actionable unchecked AC or coherent set in the authorized scope. Respect dependencies. Deferred features remain deferred until approved. Inspect existing implementation first and build only what is missing. When all children are done, check the feature and move on. If work reveals an in-scope gap, add a testable AC and reopen the feature. Do not remove unmet requirements to declare success.

Act as a lean driver. If delegation is available and authorized, choose the least costly capable subagent for each bounded task. Send AC IDs, objective, inspected context, owned files, dependencies, constraints, and evidence requirements. Use stronger reasoning or review for money, identity, data loss, and uncertain architecture. Parallelize only independent work. Otherwise implement directly. Inspect results yourself before accepting them.

Implement working behavior and its UI using existing project primitives. Preserve authorization, account ownership, data integrity, privacy, and recovery. Relevant money and entitlement changes require trusted backend proof and atomic, duplicate-safe records. Follow the actual OS and distribution-channel rules. Do not replace missing provider or device verification with a local mock and claim completion.

Verify each AC with relevant tests and real UI or device journeys where required. Cover failure, retry, interruption, concurrency, replay, and account change as applicable. Fix failures and inspect the diff. Record commands or steps, observed outcomes, environment, and PR or commit in the feature document. Recheck affected completed ACs after changes.

Deliver small coherent verified changes early through the repository's integration process. Where merging is authorized, include the AC checkmarks and matching feature status in the verified delivery, merge to the intended branch, and confirm the remote state. Unmerged work is not completed mainline work. If merge authority is absent, prepare the reviewable delivery and leave its integration AC open. Never infer permission to deploy, publish, spend, or destroy data from this goal.

After each integration, reread the board and handoff for new ACs or changed priorities. Continue until all authorized ACs are verified and integrated. If one is blocked, keep it open and work on independent ACs. Stop only for completion, a user stop, a budget limit, or when all remaining work needs unavailable input, access, or authorization. State the actual blockers without pretending the goal is complete.

Replace work/HANDOFF.md at meaningful transitions and before stopping with current ACs, checkout, unmerged work or PRs, evidence limits, blockers, and the exact next action. Do not append a diary. Delete it when nothing needs transfer. Keep durable facts in knowledge and completed evidence in feature documents. Report merged results and remaining blockers briefly.
```

## Handoff state

Only create a handoff when there is useful unfinished context:

```markdown
# Current Development Handoff

Updated: actual date. Replace this snapshot rather than appending a log.

## Current work

Selected ACs and intended outcome. Exact checkout and branch.

## Delivery state

Actual unmerged changes or PRs and who owns them. Latest verified integration.

## Evidence and limits

Relevant checks and results. What has not been verified.

## Blockers and next action

Specific missing access or decision, independent work available, and where to resume.
```

This file is disposable continuation context. Repository state and RFC evidence
must still be checked when a different driver resumes.
