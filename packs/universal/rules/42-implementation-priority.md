# Repository-Derived Implementation Priority

- Before adding code, derive the local implementation ladder from the repository: nearby usage, imports, package manifests, config files, directory structure, generated code, and tests.
- Prefer the highest-level established project primitive that fully fits the need before dropping to lower-level tools. Reuse existing feature APIs, components, helpers, framework conventions, and configured libraries before creating custom code.
- When multiple supported approaches exist, follow the repo's observed priority. For example, in a UI codebase with a design system, utility styles, configured style tokens, and CSS modules, prefer the design-system component first, then existing utility/token patterns, then a narrow style extension, then a module-level stylesheet.
- Prefer native platform, language, framework, and protocol features over custom reimplementations when they satisfy the requirement with comparable clarity, accessibility, performance, and maintainability.
- Introduce bespoke code only after existing primitives, extension points, configuration, and native capabilities cannot meet the requirement. Keep the custom layer as small, explicit, and locally conventional as possible.
- If the discovered priority is ambiguous enough to change the implementation, pause and ask; otherwise state the inferred priority briefly when it materially affects the solution.
