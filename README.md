# Universal Agent Rules

Source rules for Overmind (`ovmd`) and compatible AI coding agents.

This repository is intentionally lightweight so projects can use it as a rule source or git submodule without vendoring CLI source code.

## Layout

```text
packs/universal/
  manifest.toml
  rules/
  templates/
AGENTS.md
sync.sh
```

- `packs/universal/rules/` contains modular rule files.
- `packs/universal/templates/` contains target wrappers rendered by `ovmd`.
- `AGENTS.md` is the generated universal baseline for tools that read a single root file.
- `sync.sh` is a compatibility shim for older installs.

## Usage

Install Overmind from `beelol/overmind`, then run this from a project root:

```bash
ovmd init
ovmd sync
```

Use this repository as a local/submodule source:

```bash
ovmd init --source .agent-rules/universal
ovmd sync --watch
```

## Editing Rules

Edit files under `packs/universal/rules/`, then rebuild generated artifacts with:

```bash
ovmd pack build --source .
```
