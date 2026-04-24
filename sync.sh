#!/usr/bin/env bash
set -euo pipefail

DEFAULT_RULES_URL="https://raw.githubusercontent.com/beelol/rules/master/AGENTS.md"
REMOTE_URL="git@github.com:beelol/rules.git"
SUBMODULE_PATH=".agent-rules/universal"
START_MARKER="<!-- UNIVERSAL_AGENT_RULES:START -->"
END_MARKER="<!-- UNIVERSAL_AGENT_RULES:END -->"
MANAGED_MARKER="Managed by beelol/rules"

YES=false
DRY_RUN=false
SUBMODULE=false
RULES_URL="$DEFAULT_RULES_URL"
TIMESTAMP="$(date +%Y%m%d%H%M%S)"
TEMP_FILES=()

usage() {
  cat <<'USAGE'
Usage: sync.sh [options]

Install or update universal AI agent rules in the current project.

Options:
  -y, --yes          Accept all prompts with the default yes answer
      --dry-run      Print planned changes without writing files
      --url URL      Rules source URL (default: beelol/rules AGENTS.md on master)
      --submodule    Use git submodule source at .agent-rules/universal
  -h, --help         Show this help

Default mode updates only the managed universal block in root AGENTS.md.
Project-specific instructions outside that block are preserved.
USAGE
}

cleanup() {
  local file
  for file in "${TEMP_FILES[@]:-}"; do
    [[ -n "$file" && -e "$file" ]] && rm -f "$file"
  done
  return 0
}
trap cleanup EXIT

new_temp() {
  local file
  file="$(mktemp)"
  TEMP_FILES+=("$file")
  printf '%s\n' "$file"
}

confirm_yes() {
  local prompt="$1"
  local answer=""

  if [[ "$YES" == true ]]; then
    return 0
  fi

  if [[ -e /dev/tty ]] && { read -r -p "$prompt [Y/n] " answer < /dev/tty; } 2>/dev/null; then
    :
  else
    printf '%s [Y/n] ' "$prompt" >&2
    if ! read -r answer; then
      answer=""
    fi
  fi

  [[ -z "$answer" || "$answer" =~ ^[Yy]$ ]]
}

run_cmd() {
  if [[ "$DRY_RUN" == true ]]; then
    printf 'Would run:'
    printf ' %q' "$@"
    printf '\n'
    return 0
  fi

  "$@"
}

backup_if_needed() {
  local target="$1"

  [[ -f "$target" ]] || return 0
  grep -q "$MANAGED_MARKER" "$target" && return 0

  local backup="${target}.bak.${TIMESTAMP}"
  if [[ "$DRY_RUN" == true ]]; then
    printf 'Would back up %s to %s\n' "$target" "$backup"
    return 0
  fi

  cp "$target" "$backup"
  printf 'Backed up %s to %s\n' "$target" "$backup"
}

write_managed_file() {
  local target="$1"
  local temp
  temp="$(new_temp)"
  cat > "$temp"

  if [[ -f "$target" ]] && cmp -s "$temp" "$target"; then
    printf 'Unchanged %s\n' "$target"
    return 0
  fi

  if [[ "$DRY_RUN" == true ]]; then
    if [[ -f "$target" ]]; then
      printf 'Would update %s\n' "$target"
    else
      printf 'Would create %s\n' "$target"
    fi
    return 0
  fi

  mkdir -p "$(dirname "$target")"
  backup_if_needed "$target"
  mv "$temp" "$target"
  printf 'Updated %s\n' "$target"
}

download_rules() {
  local output="$1"
  printf 'Downloading universal agent rules from %s\n' "$RULES_URL"
  curl -fsSL "$RULES_URL" -o "$output"

  if [[ ! -s "$output" ]]; then
    printf 'Error: downloaded rules file is empty.\n' >&2
    exit 1
  fi
}

prepare_submodule_rules() {
  local output="$1"

  if [[ "$DRY_RUN" == true ]]; then
    printf 'Would add/update submodule %s from %s on branch master\n' "$SUBMODULE_PATH" "$REMOTE_URL"
    printf '# Dry-run placeholder for %s/AGENTS.md\n' "$SUBMODULE_PATH" > "$output"
    return 0
  fi

  if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    printf 'Error: --submodule mode requires a git repository.\n' >&2
    exit 1
  fi

  if [[ -e "$SUBMODULE_PATH" ]]; then
    if git config --file .gitmodules --get-regexp "submodule\\..*\\.path" 2>/dev/null | grep -q "[[:space:]]${SUBMODULE_PATH}$"; then
      printf 'Updating submodule %s\n' "$SUBMODULE_PATH"
      git submodule update --init --remote "$SUBMODULE_PATH"
    else
      printf 'Error: %s exists but is not registered as a git submodule.\n' "$SUBMODULE_PATH" >&2
      exit 1
    fi
  else
    git submodule add -b master "$REMOTE_URL" "$SUBMODULE_PATH"
  fi

  if [[ ! -s "${SUBMODULE_PATH}/AGENTS.md" ]]; then
    printf 'Error: %s/AGENTS.md was not found after submodule setup.\n' "$SUBMODULE_PATH" >&2
    exit 1
  fi

  cp "${SUBMODULE_PATH}/AGENTS.md" "$output"
}

make_managed_block() {
  local rules_file="$1"
  local source_label="$2"
  local output="$3"

  {
    printf '%s\n' "$START_MARKER"
    printf '<!-- %s. Do not edit inside this block. -->\n' "$MANAGED_MARKER"
    printf '<!-- Source: %s -->\n\n' "$source_label"
    cat "$rules_file"
    printf '\n%s\n' "$END_MARKER"
  } > "$output"
}

update_agents_md() {
  local rules_file="$1"
  local source_label="$2"
  local block_file
  local output_file

  block_file="$(new_temp)"
  output_file="$(new_temp)"
  make_managed_block "$rules_file" "$source_label" "$block_file"

  if [[ -f AGENTS.md ]] && grep -q "$START_MARKER" AGENTS.md && grep -q "$END_MARKER" AGENTS.md; then
    awk -v start="$START_MARKER" -v end="$END_MARKER" -v block="$block_file" '
      index($0, start) {
        while ((getline line < block) > 0) {
          print line
        }
        close(block)
        skipping = 1
        next
      }
      index($0, end) {
        skipping = 0
        next
      }
      !skipping {
        print
      }
    ' AGENTS.md > "$output_file"
  else
    {
      printf '# Agent Instructions\n\n'
      cat "$block_file"
      printf '\n## Project Instructions\n\n'
      if [[ -f AGENTS.md ]]; then
        cat AGENTS.md
      else
        printf 'Add project-specific instructions here.\n'
      fi
    } > "$output_file"

    if [[ -f AGENTS.md ]]; then
      backup_if_needed AGENTS.md
    fi
  fi

  if [[ -f AGENTS.md ]] && cmp -s "$output_file" AGENTS.md; then
    printf 'Unchanged AGENTS.md\n'
    return 0
  fi

  if [[ "$DRY_RUN" == true ]]; then
    if [[ -f AGENTS.md ]]; then
      printf 'Would update AGENTS.md managed universal block\n'
    else
      printf 'Would create AGENTS.md with managed universal block\n'
    fi
    return 0
  fi

  mv "$output_file" AGENTS.md
  printf 'Updated AGENTS.md\n'
}

write_wrappers() {
  if confirm_yes "Write Claude Code wrapper CLAUDE.md?"; then
    write_managed_file "CLAUDE.md" <<'EOF'
<!-- Managed by beelol/rules. Edit the Project Instructions section in AGENTS.md for local rules. -->
@AGENTS.md
EOF
  fi

  if confirm_yes "Write Gemini wrapper GEMINI.md?"; then
    write_managed_file "GEMINI.md" <<'EOF'
<!-- Managed by beelol/rules. Edit the Project Instructions section in AGENTS.md for local rules. -->
@AGENTS.md
EOF
  fi

  if confirm_yes "Write Cursor project rule .cursor/rules/universal-agent-rules.mdc?"; then
    write_managed_file ".cursor/rules/universal-agent-rules.mdc" <<'EOF'
---
description: Universal baseline agent rules
globs:
alwaysApply: true
---

Managed by beelol/rules. Follow the project root `AGENTS.md` for universal baseline and project-specific instructions. Do not edit the managed universal block in `AGENTS.md`; add local instructions below it.
EOF
  fi

  if confirm_yes "Write legacy Cursor .cursorrules?"; then
    write_managed_file ".cursorrules" <<'EOF'
Managed by beelol/rules. Follow the project root AGENTS.md for universal baseline and project-specific instructions. Do not edit the managed universal block in AGENTS.md; add local instructions below it.
EOF
  fi

  if confirm_yes "Write Cline rule .clinerules/universal-agent-rules.md?"; then
    write_managed_file ".clinerules/universal-agent-rules.md" <<'EOF'
# Universal Agent Rules

Managed by beelol/rules. Follow the project root `AGENTS.md` for universal baseline and project-specific instructions. Do not edit the managed universal block in `AGENTS.md`; add local instructions below it.
EOF
  fi

  if confirm_yes "Write Antigravity-style rule .agent/rules/universal-agent-rules.md?"; then
    write_managed_file ".agent/rules/universal-agent-rules.md" <<'EOF'
# Universal Agent Rules

Managed by beelol/rules. Follow the project root `AGENTS.md` for universal baseline and project-specific instructions. Do not edit the managed universal block in `AGENTS.md`; add local instructions below it.
EOF
  fi
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    -y|--yes)
      YES=true
      shift
      ;;
    --dry-run)
      DRY_RUN=true
      shift
      ;;
    --url)
      if [[ $# -lt 2 ]]; then
        printf 'Error: --url requires a value.\n' >&2
        exit 1
      fi
      RULES_URL="$2"
      shift 2
      ;;
    --submodule)
      SUBMODULE=true
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      printf 'Error: unknown option %s\n\n' "$1" >&2
      usage >&2
      exit 1
      ;;
  esac
done

if [[ "$DRY_RUN" == true ]]; then
  printf 'Dry run enabled. No project files will be modified.\n'
fi

rules_file="$(new_temp)"
source_label="$RULES_URL"

if [[ "$SUBMODULE" == true ]]; then
  if confirm_yes "Add or update universal rules submodule at ${SUBMODULE_PATH}?"; then
    prepare_submodule_rules "$rules_file"
    source_label="${SUBMODULE_PATH}/AGENTS.md"
  else
    printf 'Skipped submodule setup.\n'
    exit 0
  fi
elif [[ "$DRY_RUN" == true ]]; then
  printf '# Dry-run placeholder for %s\n' "$RULES_URL" > "$rules_file"
else
  download_rules "$rules_file"
fi

if confirm_yes "Update root AGENTS.md managed universal block?"; then
  update_agents_md "$rules_file" "$source_label"
fi

write_wrappers

printf 'Sync complete.\n'
