---
name: linear-write-ticket
description: Write or revise concise, self-contained Linear issues with a concrete outcome, minimal rationale, required implementation behavior, testable acceptance criteria, and no speculative extras. Use when drafting, creating, rewriting, clarifying, splitting, or planning Linear tickets, subtickets, follow-ups, and umbrella issues.
---

# Write Linear Tickets

Write the shortest issue that another engineer can understand and implement without conversation history.

## Workflow

1. Read the issue, parent, related work, and comments. Search for duplicates before creating a new issue.
2. Preserve correct completed work. Describe later changes as follow-ups, not corrections, unless the earlier behavior is actually defective.
3. Name the outcome in the title. Avoid vague verbs such as improve, support, align, or handle when a concrete behavior fits.
4. Write only the sections needed, in this order:
   - **Goal** — one sentence naming the resulting behavior.
   - **Why** — one or two short sentences stating the concrete mismatch or gap.
   - **How** — only required behavior; prefer three to six bullets.
   - **Acceptance criteria** — observable cases that prove the goal.
   - **Data model / Interfaces** — only when relevant; place technical structure last.
5. Remove repetition, background narrative, implementation trivia, optional improvements, and unsupported assumptions.
6. Before writing to Linear, verify team, project, parent, labels, status, and existing relationships. Do not change unspecified metadata.

## Writing rules

- Make the issue self-contained; do not assume the reader saw the conversation.
- State the contrast directly: what determines behavior now and what must determine it after the change.
- Use exact domain names and identifiers already present in the code or ticket.
- Keep rationale factual. Avoid phrases such as “complete the flow,” “better align,” “robust,” “seamless,” or “source of truth” when the concrete behavior can be stated instead.
- Keep acceptance criteria independent of implementation details unless the implementation constraint is itself required.
- Do not add rollout, migration, monitoring, compatibility, failure policy, or out-of-scope sections unless the task makes them necessary.
- Never invent priority, estimate, due date, owner, dependencies, or product intent.

## Compact default

```markdown
### Goal

<one sentence>

### Why

<one or two concrete sentences>

### How

* <required behavior>

### Acceptance criteria

- [ ] <observable result>
```
