# Feature-Based Architecture

- Organize product code by feature first, not by technical layer first.
- Keep files that change together close together: UI, state, validation, API calls, tests, and feature-specific helpers should live under the same feature directory when practical.
- Search for existing code with the same responsibility before adding a new component, helper, service, hook, model, command, or test utility. Reuse or extend the existing local pattern when it fits.
- Use shared directories only for code that is genuinely reused across multiple features or is intended to become a stable cross-feature primitive.
- Prefer small, explicit feature modules over broad catch-all folders like `components`, `utils`, or `services`.
- When adding new code, follow the nearest existing feature boundary. If no boundary exists yet, create one conservatively around the user-facing capability being changed.
- Do not bury generic reusable code inside a feature file, page, route, command, or entrypoint. Move it to the nearest established shared module and export it through the repo's normal discovery path.
- Keep single-concern files aligned with the surrounding structure. Split UI, state, validation, data access, and pure helpers when the codebase already separates those responsibilities.
