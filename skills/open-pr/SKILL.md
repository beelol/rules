---
name: open-pr
description: Open or update pull requests after the title and description have been written with the pr-description-writer skill. Use when the user asks to create, publish, push, open, or update a PR.
---

# Open Pull Requests

Use `pr-description-writer` for every new PR and every title or body update. Its title, evidence, and `[Pending]` rules apply before publication and whenever proof changes.

## Workflow

1. Read repository instructions and any required PR template.
2. Inspect the branch, target, commits, and diff against the actual base. Exclude inherited commits.
3. Fetch relevant tickets when available and identify any local title convention.
4. Draft the title and body with `pr-description-writer`. Keep `- [Pending]` in Evidence when no product evidence exists.
5. Run the narrow checks needed to avoid publishing broken work. Do not present these checks as product evidence.
6. Push the branch when the request authorizes it.
7. Create or update the PR with the GitHub connector when available, or use `gh` with a body file to preserve formatting.
8. Read the saved PR back and verify its title, body, base, head, and URL.
9. When product evidence or the tested revision changes, use `pr-description-writer` again and update Evidence. Check that a final-head claim was tested on that head.

## Template handling

Use a mandatory repository template. Remove its instructional text and keep required checkboxes. Do not rename automated checks or pass counts to Evidence.

## Publishing

The user's request to open, combine, or update a PR authorizes that matching operation. If the user asks only for a draft, return the draft without changing GitHub. Do not add AI attribution or generated-by footers.
