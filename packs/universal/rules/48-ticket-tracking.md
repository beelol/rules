# Ticket Tracking

- When a task has durable project value outside the codebase, consider tracking it in a ticket only if that tracking would materially help planning, follow-up, handoff, or status visibility.
- Track work only when there is a clearly relevant project, product area, or stream of work that the ticket belongs to.
- Ask the user before creating, updating, or reclassifying tickets unless they explicitly requested ticket tracking as part of the task.
- If it is unclear whether ticket tracking is relevant, or unclear which project or ticket stream applies, ask the user before taking action.
- Prefer the Linear MCP when it is available and appropriate for the workspace.
- If no suitable ticketing tool is available, do not block or degrade the main task by trying to force ticket tracking.
- Record only relevant, durable information. Do not mirror the full conversation or dump every implementation detail into tickets.
- Distinguish between work being done now and work intended for later. Mark current work as in progress or active, and future work as planned, follow-up, or deferred as appropriate.

# Pull Request Titles from Linear

- When a pull request implements tracked Linear work, optimize its title for scanning across concurrent project streams instead of copying the issue title or using a conventional-commit prefix.
- Use `[<Linear project>] - [<workstream>] <outcome>` when the project and workstream are established.
- Copy the Linear project name exactly. Derive the workstream from the closest stable grouping shared by sibling tickets or pull requests: a parent issue, milestone, explicit stack or adapter, or a stream named by the user. Do not derive it from a code layer such as frontend, backend, or infrastructure unless that layer is the established workstream.
- Compress the issue's concrete deliverable into a one-to-three-word noun phrase. Remove ticket IDs, conventional-commit prefixes such as `feat(...)` or `infra(...)`, implementation filler such as `add`, `implement`, or `support`, and words already present in the project or workstream labels.
- Keep project and workstream labels identical across a stack; distinguish each pull request by its bounded outcome. Put the Linear issue link and stack base in the pull request description, not the title.
- If multiple workstreams fit or no stable workstream is established, ask before naming or bulk-renaming pull requests. Follow an explicit repository-mandated title format when one exists.
- Example: Linear project `Fedex Demo`, workstream `Email`, and issue `Parse email and find one PDF` becomes `[Fedex Demo] - [Email] PDF Discovery`.
