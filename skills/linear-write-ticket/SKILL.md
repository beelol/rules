---
name: linear-write-ticket
description: Write or revise concise, self-contained Linear issues that match the project's existing ticket shape, with a one-sentence goal, a boundary for parent issues, and short observable acceptance criteria for child issues. Use when drafting, creating, rewriting, clarifying, splitting, or planning Linear tickets, subtickets, follow-ups, and umbrella issues.
---

# Write Linear Tickets

Write the shortest issue that another engineer can understand and implement without conversation history.

## Workflow

1. Read the issue, parent, related work, and comments. Search for duplicates before creating a new issue.
2. Read three to five sibling tickets in the same project and copy their section shape, headings, and header lines. Project style beats the defaults below.
3. Decide the ticket's role: parent (groups work), child (one deliverable), follow-up (later work), or verify-first (check what exists, then build only the gap).
4. Name the outcome in the title. Child titles are verb phrases ("Parse email and find one PDF"). Parent titles may be noun phrases ("Email intake system"). Avoid vague verbs such as improve, support, align, or handle.
5. Write only the sections the role needs (see Shapes).
6. Preserve correct completed work. Describe later changes as follow-ups, not corrections, unless the earlier behavior is actually defective.
7. Before writing to Linear, verify team, project, parent, labels, status, and existing relationships. Do not change unspecified metadata.

## Shapes

**Parent issue:** Goal and Boundary. No acceptance criteria; the children carry them.

```markdown
## Goal

Turn one authenticated forwarded email into one accepted PDF for a workflow.

## Boundary

V1 accepts one PDF attachment. Email-body rates and broader attachment discovery are follow-ups.
```

**Child issue:** Goal and three or four acceptance criteria.

```markdown
## Goal

Store one accepted PDF and start one run with the workflow's pinned document recipe.

## Acceptance criteria

- [ ] One receipt maps to one document and one queued run.
- [ ] Retries cannot create duplicate documents or runs.
- [ ] Existing input hydration, budgets, queueing, history, and results are reused.
- [ ] PDF bytes stay out of queue payloads and logs.
```

**Follow-up issue:** start the goal with "Later," and add a Boundary that says it is outside current scope. On a parent that groups follow-ups, state whether the children block the current milestone ("These child tickets do not block the demo.").

**Verify-first issue:** "Verify what [X (ID)](url) and [Y (ID)](url) already provide for <capability>; build only the missing behavior."

**Release-tracked project:** when siblings use them, add these in order. Omit any that do not apply.

```markdown
**Release:** Workflows 1.0.

<One-sentence goal, no heading.>

**Why:** <One sentence naming the concrete failure or gap.> [RFC evidence: <section>](<link>)

### Acceptance criteria

- [ ] Users <observable result>.

**Limits:** <numeric targets: counts, waits, retries, deadlines>.

**Verification:** <specific test cases, and what alerts must include>.

**Dependencies:** None. <Related work: [ID](link).>
```

## Acceptance criteria rules

- Keep to three or four observable results. Each one is checkable without reading the code.
- Write product-facing criteria from the actor's side: "Users can...", "Users see...", "The team can...".
- Cover the edges that matter for the change, not a fixed checklist:
  - what must stay unchanged ("Ordinary workflows remain unchanged.");
  - how bad input fails ("Unknown, paused, or unauthorized targets fail safely."; "Missing config leaves intake disabled.");
  - retries and duplicates ("Provider retries cannot repeat settled work.");
  - data that must stay out of logs or queues.
- Put exact values an engineer must use (domains, URLs, parameter paths) directly in the criteria for configuration and rollout tickets.
- Put numbers in Limits, not in criteria, when the project uses a Limits line.

## Writing rules

- Make the issue self-contained; do not assume the reader saw the conversation.
- The goal is one sentence naming the resulting behavior. Why, when present, is one sentence naming the concrete gap, with a link to the evidence when it exists.
- Use a Boundary to say what this issue does not do and which neighbors stay separate. Prefer it to an "Out of scope" list.
- Link related issues inline as `[short description (ID)](url)`.
- Use exact domain names and identifiers already present in the code or ticket.
- Keep rationale factual. Avoid phrases such as "complete the flow," "better align," "robust," "seamless," or "source of truth" when the concrete behavior can be stated instead.
- Add a How section only when a specific approach is required. Keep acceptance criteria independent of implementation unless the constraint is itself required.
- Remove repetition, background narrative, implementation trivia, optional improvements, and unsupported assumptions.
- Never invent priority, estimate, due date, owner, dependencies, release, limits, or product intent.
