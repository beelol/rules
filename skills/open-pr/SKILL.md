---
name: open-pr
description: Open or update pull requests after the title and description have been written with the pr-description-writer skill. Use when the user asks to create, publish, push, open, or update a PR.
---

# Open Pull Requests

Use `pr-description-writer` for every title and body. Its ticket and evidence rules are authoritative.

## Workflow

1. Read repository instructions and any PR template.
2. Inspect the branch, target, commits, and target diff. Exclude inherited commits.
3. Fetch every relevant Linear ticket when a connector is available.
4. Write the title and body with `pr-description-writer`.
5. Run the narrow checks needed to avoid publishing broken work. Checks do not become an Evidence section.
6. Push the branch when authorized by the request.
7. Create or update the PR with a body file so formatting is preserved.
8. Read the saved PR back and verify its title, body, base, head, and URL.

## Template handling

Use the repository template when it is mandatory. Remove instructional placeholder text. Keep required checkboxes, but never rename automated checks or pass counts to Evidence.

## Publishing

Use `gh pr create` for a new PR and `gh pr edit` for an existing PR. The user's request to open, combine, or update a PR authorizes that matching operation; do not add another confirmation gate. If the user asks only for a draft, return the draft without changing GitHub.

Do not add AI attribution, generated-by footers, or tool links.
