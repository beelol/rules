# Universal Agent Rules

Baseline AI coding-agent instructions for projects that use Cursor, Claude Code, Cline/Roo-style tools, Antigravity/Gemini-style tools, and other `AGENTS.md` readers.

`AGENTS.md` is the canonical source. Project repos can add their own instructions below the managed universal block, and `sync.sh` will preserve those local instructions when updating the baseline.

## Quick Install

From a project root:

```bash
curl -fsSL https://raw.githubusercontent.com/beelol/rules/master/sync.sh | bash
```

Accept every default:

```bash
curl -fsSL https://raw.githubusercontent.com/beelol/rules/master/sync.sh | bash -s -- --yes
```

Preview changes without writing:

```bash
curl -fsSL https://raw.githubusercontent.com/beelol/rules/master/sync.sh | bash -s -- --dry-run
```

## What Sync Creates

`sync.sh` updates only the managed universal block in root `AGENTS.md`:

```markdown
# Agent Instructions

<!-- UNIVERSAL_AGENT_RULES:START -->
...managed baseline from beelol/rules...
<!-- UNIVERSAL_AGENT_RULES:END -->

## Project Instructions

Add project-specific instructions here.
```

It also writes small compatibility wrappers:

- `CLAUDE.md`
- `GEMINI.md`
- `.cursor/rules/universal-agent-rules.mdc`
- `.cursorrules`
- `.clinerules/universal-agent-rules.md`
- `.agent/rules/universal-agent-rules.md`

Existing files are backed up before first managed conversion as `<file>.bak.<timestamp>`.

## Managed-Copy Mode

Managed-copy mode is the default and most reliable option because supported agents can read root `AGENTS.md` directly or through native wrappers.

```bash
./sync.sh
```

Useful options:

```bash
./sync.sh --yes
./sync.sh --dry-run
./sync.sh --url file:///absolute/path/to/AGENTS.md
```

## Submodule Mode

Submodule mode keeps the baseline repository checked out at `.agent-rules/universal`, then still updates root `AGENTS.md` as the agent-readable entrypoint.

```bash
./sync.sh --submodule
```

This records the universal rules source as a git submodule while keeping project-specific instructions in the project-owned root `AGENTS.md`.

## Bootstrap This Repo

This repository uses SSH for git operations and HTTPS only for raw downloads.

```bash
./init-repo.sh
```

Defaults:

- Remote: `git@github.com:beelol/rules.git`
- Branch: `master`
- Commit message: `Initial commit: Add universal agent rules`

Push manually if needed:

```bash
git push -u origin master
```

## Rule Editing Policy

- Edit `AGENTS.md` in this repo to change the universal baseline.
- In downstream projects, edit only the local project-specific section outside the managed universal block.
- Re-run `sync.sh` in downstream projects to update the baseline.
