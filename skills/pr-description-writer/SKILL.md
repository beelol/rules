---
name: pr-description-writer
description: Write or revise clear, evidence-first pull request titles and descriptions. Use for PR drafts, new PRs, and updates after code or evidence changes.
---

# PR Description Writer

Write for a reviewer with no prior context. Explain what the product does, what changed, and what proves it. Follow the user's instructions, repository rules, and required PR template before these defaults.

## Inspect before writing

1. Read repository instructions, the PR template, the relevant ticket, and the existing PR body when one exists.
2. Compare the changed branch with the PR's actual base. Exclude inherited commits and identify the behavior this PR changes.
3. Collect direct evidence for each important claim. Record the run or deployment link, result, and revision or workflow version it exercised.
4. Separate general product requirements from values chosen for a test. A fixed team, title, or lack of start inputs in one test is not automatically a requirement for every workflow.

## Write the description

- Start with one or two plain sentences that name the affected product behavior and the outcome.
- Use `### What`, `### Why`, `### How`, `### Evidence`, and a short `### How to review`. Preserve mandatory template sections and acceptance checkboxes.
- Put the changed behavior under What, the concrete failure or need under Why, and only the necessary mechanics under How.
- Do not add Tests or Verification sections unless a required repository template calls for them.
- Keep each key point to one complete sentence on one source line. Use at most four bullets per section. Avoid nested bullets, manual line breaks, semicolons, em dashes, and unexplained code terms.
- Make every point understandable on its own. Name the workflow, user action, or data change instead of writing contextless phrases such as “a finished run.”
- Follow the repository's title format. Link relevant tickets in the body. Put ticket IDs in the title only when the repository or user requires them.
- State material limits near the claim they qualify. Do not turn a test setup detail into a general acceptance criterion.

## Evidence

- Evidence is observed product behavior, such as a live or preview run, saved read-back, screenshot, trace, diagnostic log, or direct before-and-after reproduction. Link to the exact result when possible.
- A completed step, dry run, simulation, or model score alone does not prove a data change succeeded. For a write claim, show the saved record or a linked read-back that compares the requested values.
- Automated tests, typechecks, lint, formatting, and plans are development checks. Do not substitute them for product evidence in this section.
- If no product evidence exists yet, put exactly `- [Pending]` under `### Evidence`. Replace it when evidence is collected.
- Tie evidence to the revision being reviewed. If the preview ran an older revision, label it as older or repeat the proof on the final head before claiming that head passed.
- Say plainly when a claim has only automated coverage, such as a schedule guard that was not exercised by a live scheduled run.

## Example shape

```markdown
<Product behavior and outcome in one or two sentences.>

### What

- <One specific behavior change.>

### Why

- <One concrete failure and its impact.>

### How

- <One necessary implementation fact.>

### Evidence

- [Pending]

### How to review

<Where to start and what to inspect.>

Related: [ABC-123](https://linear.app/example/issue/ABC-123)
```

## Final check

Read every point without the ticket or conversation. Confirm the title follows local rules, links resolve, claims match the code and evidence, and the Evidence section contains either observed results or `[Pending]`. After publishing or editing a PR, read the saved title, body, base, and head back from GitHub.
