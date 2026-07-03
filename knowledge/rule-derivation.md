# Rule Derivation

- Current standard: agents must derive implementation priority from repo evidence before adding code.
- Intended behavior: prefer established project primitives, then configured framework/library patterns, then native capabilities, then narrow custom code.
- Architecture guidance now requires searching for existing same-responsibility code and placing reusable generic code in the nearest shared module.
- Ambiguous repository priority should be surfaced before implementation when it could materially change the solution.
