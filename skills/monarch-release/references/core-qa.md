# Core QA after staging

## Authoritative scope

Read the current remote `TestBoxLab/monarch` files and record their source commit:

- `docs/core-qa/README.md`
- `docs/core-qa/a-pages-smoke.md`
- `docs/core-qa/b-core-paths.md`
- `docs/core-qa/c-full-concurrency.md`

The user's Section C means **Tier C — full concurrency**, including all inherited A and B criteria. Do not choose a cheaper tier based on available fixtures. Use current playbook instructions even if the staged candidate predates their addition; keep the playbook revision separate from the bundle and per-image revisions. Do not invent criteria from this summary or broaden the run into an RFC or capacity audit.

## Delegate once and retain ownership

Use `collaboration.spawn_agent` with `fork_turns="none"`, `model="gpt-6.1-sol"`, and `reasoning_effort="medium"`. Give the subagent the exact staged bundle, manifest, staging URL, TestBox organization, playbook source links/revision, fixture record location if known, permitted test operations, browser access, and evidence directory. Pass credential references rather than secret values. The subagent owns traversal and the Site content; the parent verifies complete evidence and publishes through the owning conversation's Sites tools when required. Read the installed Sites skill for current hosting rules. Do not silently change model or effort if unavailable; report the capability needed.

Dispatch instruction:

> Run every criterion of the current Monarch Core QA Tier C playbook against the verified staging bundle in TestBox, including all Tier A pages and Tier B serial paths. Use actual UI actions and terminal results, with screenshot and run/job evidence per criterion. Prefer the available user session; otherwise use Nora's discovered SSM login securely. Ask for the user's TestBox session if Nora has no usable workflows or fixture access. Return a complete PASS/FAIL ledger and build a clear, concise ChatGPT Site containing every criterion, expected and actual outcomes, screenshots, supporting IDs/links, and failure causes. Continue independent checks while missing access is resolved. Do not deploy, fix app code, activate workflows, change credentials, or send messages to others. Do not call a partial run complete or infer success from CI, saved settings, old runs, or generated notes.

Use task-owned browser tabs and records. Keep the subagent alive through completion; do not launch a duplicate audit on a heartbeat. Recover its identity, fixture revision, evidence directory, and any Site project before resuming work.

## Login and fixtures

1. Inspect available supported browser sessions. Prefer an already signed-in user session on staging; select and verify **TestBox**. Preserve the user's session and existing work.
2. If a session is unavailable, discover Nora's username/password parameter names, AWS account, region and profile from current repository or restricted operational guidance and SSM parameter metadata. Retrieve only the identified login values with authorized access; do not guess names or accounts. Keep decrypted values in memory and transfer them to the login UI without printing them, placing them in shell arguments, saving them, or including them in screenshots/reports. Never read Product account secret values as part of this login.
3. Verify the actor, staging environment, organization, required permissions and actual workflow/graph/account availability. If Nora cannot support the suite, request access to the user's TestBox session. Recheck fixtures in that session; a different session alone does not prove prerequisites exist. Continue independent safe checks while awaiting access.
4. Locate the reviewed fixture manifest in restricted operational records. The playbook intentionally commits no live fixture IDs. If no binding exists, inventory dedicated test records in TestBox and prepare the playbook's one-time binding: discovery graph/configuration, A1–A3 exact prompts/canonical answers and read-only assertions, E1–E3 workflow IDs/versions/inputs, and the mixed-batch bindings. Prove serial fixtures as directed and obtain review of a new or changed binding before the release run. Do not silently substitute arbitrary workflows, change frozen answers, repair credentials, or invent expected results.

TestBox is authorized for these core QA operations on dedicated test data: safe discovery start/stop, bounded read-only workflow authoring and dry runs, manual executions, and cancellation. Keep authored workflows as drafts. Use only working existing Product accounts; no customer records, outbound writes/messages, schedules, activation, or access changes. Respect the approved QA spending allowance; request a concrete missing allowance rather than assuming an unlimited one.

## Execute and prove every criterion

Expand the playbook into a ledger before testing. Include every preflight requirement, every Tier A page and specified desktop/mobile viewport, separate QA-B1/QA-B2 serial attempts, and every step/result assertion in QA-02 through QA-06. Keep a result for each authoring/execution fixture and for each concurrency assertion; a summary row must not hide an unchecked assertion.

Follow the playbook's order and frozen fixtures. Require real three-way overlap, not rapid submissions: preserve the authoring overlap observation and execution timestamps proving `max(startedAt) < min(finishedAt)`. Keep the mixed batch separate, using this run's newly authored A1/A2. Verify exact outputs against frozen rules, ownership by workflow and version, reload persistence, discovery stop, and durable workflow cancellation with no later activity. A serial fallback cannot pass a concurrency criterion.

For every criterion retain: ID and playbook link, expected outcome, action/input, actual outcome, UTC timestamp, environment/bundle, actor/role, fixture revision, relevant workflow/job/run IDs and links, screenshot paths, and console/network errors where applicable. Capture original live screenshots at decisive states and inspect them against their captions. A screenshot alone does not prove backend completion or timing; pair it with result/step data and IDs. An Active badge does not prove credentials work. Preserve failed attempts and retries separately; do not overwrite failures or rerun external operations merely to obtain screenshots. Continue independent scenarios after an isolated failure when safe.

## Binary results without fabricated certainty

The final Site and summary use **PASS** and **FAIL** only, with every required criterion represented. PASS requires all its assertions executed on this candidate and supported by current screenshots and outcome evidence. FAIL states exactly what was observed or could not be verified, with a cause such as product behavior, authentication, missing fixture, or unavailable evidence. Never describe inaccessible or unexecuted behavior as an observed product defect. A failed access prerequisite may give dependent criteria FAIL with an explicit dependency and the captured prerequisite failure; do not pretend their UI paths ran or fabricate screenshots.

Preserve native `BLOCKED`/`NOT RUN` states and reasons in the restricted playbook run record; map them to **FAIL — not verified: <cause>** in the binary release report. Do not hide these states on a secondary page to imply a pass. Do not publish a partial progress report as the finished audit. Resolve recoverable prerequisites first, asking once for needed user input and continuing independent work. If access remains unavailable, deliver a complete failure ledger that accounts for every affected criterion and clearly states the suite did not execute fully. Overall PASS requires every required criterion to pass; otherwise overall FAIL. A successful retry does not erase the first attempt.

## Publish a concise ChatGPT Site

Create or reuse one ChatGPT Site for this candidate. Default a new Site to private; preserve an existing audience. Keep evidence in an access-controlled location and omit secrets and customer/returned records. Use publication copies with labelled redactions when needed while preserving restricted originals. Follow current Sites ownership and publishing tools; a local file or preview URL is not the required hosted Site.

Lead with bundle, environment, playbook and fixture revisions, test time, overall PASS/FAIL and exact counts. Show every criterion in a scannable table or compact cards: ID/name, PASS/FAIL, one-sentence expected/actual result, captioned screenshots opening full-size, and supporting run/result links. Group failures first without burying passed evidence. Put detailed steps and timing data behind an expansion, keeping each result understandable without chat history. Do not use vague partial labels, marketing prose, or unsupported claims that everything works.

Verify the deployed Site URL and intended audience, criterion count against the full ledger, screenshot loading/full-size links, matching captions, evidence IDs and all recorded assertions. Parent reviews evidence before accepting the subagent's verdict. Retain Site/project/deployment IDs and source/evidence locations for follow-up. Return the actual hosted URL, exact binary counts and material failure causes before requesting production approval. If hosting fails, preserve artifacts and report that blocker; do not claim the required Site exists. Clean up task-owned temporary resources after preserving evidence; leave user sessions and useful artifacts intact.
