---
name: pr-description-writer
description: Write or revise clear, evidence-first pull request titles and descriptions. Use whenever drafting, reviewing, combining, or updating PR copy, including as part of opening a PR.
---

# PR Description Writer

Write for a reviewer with no prior context. Lead with the product or operational outcome, then give only the technical detail needed to review it.

## Required rules

1. Start with one or two plain sentences that explain the outcome and affected behavior. The opener must stand alone without the ticket or conversation.
2. Use `### What`, `### Why`, `### How`, and `### Evidence` unless a mandatory repository template requires equivalent headings.
3. Put implementation details under `How`, after the short explanation.
4. Include every relevant ticket ID in the title when tickets exist. Link those tickets in the body.
5. Never create `Tests` or `Verification` sections.
6. Evidence means observed behavior tied to the PR's claim: a live or preview result, screenshot, trace, log, query result, deployment run, or a direct before-and-after reproduction.
7. Automated tests, typechecks, lint, formatting, and local plans are checks. They can support development but are not product evidence and do not belong in `Evidence`.
8. Leave `### Evidence` empty until real evidence has been collected. Do not fill it with checks, promises, placeholders, or “not tested.”
9. Keep the body concise. Do not narrate files, list every internal check, copy the ticket, or invent motivation.
10. State material limits plainly when they affect the review or rollout.

## Title

Follow the repository's established project and workstream format. Add the relevant ticket IDs in a compact final bracket.

Example:

```text
[Workflows Runtime Architecture] - [Authoring] Alert Delivery [WF-13, WF-16, WF-17]
```

Do not add conventional commit prefixes unless the repository explicitly requires them for PR titles.

## Body

```markdown
<One or two sentences explaining the outcome and affected behavior.>

### What

<The bounded behavior change.>

### Why

<The concrete problem or requirement.>

### How

<Only the implementation and rollout details a reviewer needs.>

### Evidence


Related: [ABC-123](https://linear.app/example/issue/ABC-123)
```

Keep `Evidence` blank when no evidence exists yet. Add evidence only after collecting it.

## Workflow

1. Read repository instructions and the PR template.
2. Inspect the PR diff against its actual target and exclude inherited commits.
3. Read the current PR body and relevant tickets.
4. Identify the one outcome, the need, the implementation, and any real evidence.
5. Draft the shortest complete title and body.
6. Check that a new reviewer can understand the change without opening a link.
7. Confirm every relevant ticket ID appears in the title and every ticket is linked in the body.
8. Confirm `Evidence` contains observations rather than development checks; otherwise leave it empty.

## Combining PRs

When combining PRs, describe the combined outcome rather than pasting both bodies together. Preserve only still-correct evidence and limits. Update links that pointed at the removed PR, then close the redundant PR with a link to the surviving PR.
