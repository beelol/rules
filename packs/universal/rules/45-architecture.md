# Feature-Based Architecture

- Organize product code by feature first, not by technical layer first.
- Keep files that change together close together: UI, state, validation, API calls, tests, and feature-specific helpers should live under the same feature directory when practical.
- Use shared directories only for code that is genuinely reused across multiple features.
- Prefer small, explicit feature modules over broad catch-all folders like `components`, `utils`, or `services`.
- When adding new code, follow the nearest existing feature boundary. If no boundary exists yet, create one conservatively around the user-facing capability being changed.
