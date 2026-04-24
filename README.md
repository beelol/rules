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
ovmd sync
```

`ovmd sync` does not require project config. It uses CLI flags, then `.overmind.toml`, then global config, then Overmind's built-in default source.

Use this repository as a local or submodule source:

```bash
ovmd sync --source .agent-rules/universal
ovmd sync --watch
```

## Rendered Targets

The `universal` pack renders into the native agent rule locations used by common coding agents:

```text
AGENTS.md
CLAUDE.md
GEMINI.md
.cursor/rules/AGENTS.mdc
.cursorrules
.clinerules/AGENTS.md
.roo/rules/AGENTS.md
.agent/rules/AGENTS.md
```

Overmind replaces only the section between `OVERMIND:START` and `OVERMIND:END`. Keep project-specific instructions outside that block.

## Editing Rules

Edit files under `packs/universal/rules/`, then rebuild generated artifacts with:

```bash
ovmd pack build --source .
```
