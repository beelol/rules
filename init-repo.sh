#!/usr/bin/env bash
set -euo pipefail

DEFAULT_REMOTE="git@github.com:beelol/rules.git"
BRANCH="master"
COMMIT_MESSAGE="Initial commit: Add universal agent rules"
YES=false
DRY_RUN=false
REMOTE_URL="$DEFAULT_REMOTE"

usage() {
  cat <<'USAGE'
Usage: init-repo.sh [options]

Bootstrap the universal agent rules repository in the current directory.

Options:
  -y, --yes           Accept all prompts with the default yes answer
      --dry-run       Print planned git/setup commands without changing files
      --remote URL    Git remote URL (default: git@github.com:beelol/rules.git)
  -h, --help          Show this help

This script expects AGENTS.md, README.md, sync.sh, and init-repo.sh to exist.
USAGE
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

ensure_required_files() {
  local missing=false
  local file

  for file in AGENTS.md README.md sync.sh init-repo.sh; do
    if [[ ! -f "$file" ]]; then
      printf 'Missing required file: %s\n' "$file" >&2
      missing=true
    fi
  done

  if [[ "$missing" == true ]]; then
    printf 'Create the missing files before running init-repo.sh.\n' >&2
    exit 1
  fi
}

ensure_git_identity() {
  if git config user.name >/dev/null 2>&1 && git config user.email >/dev/null 2>&1; then
    return 0
  fi

  printf 'Git user.name or user.email is not configured for this repository.\n' >&2
  printf 'Configure git identity, then rerun this script.\n' >&2
  exit 1
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
    --remote)
      if [[ $# -lt 2 ]]; then
        printf 'Error: --remote requires a value.\n' >&2
        exit 1
      fi
      REMOTE_URL="$2"
      shift 2
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
  printf 'Dry run enabled. No repository files will be modified.\n'
fi

ensure_required_files

if confirm_yes "Make shell scripts executable?"; then
  run_cmd chmod +x sync.sh init-repo.sh
fi

if confirm_yes "Initialize git repository?"; then
  if [[ -d .git ]]; then
    printf 'Git repository already initialized.\n'
  else
    run_cmd git init
  fi
fi

if confirm_yes "Set branch to ${BRANCH}?"; then
  run_cmd git branch -M "$BRANCH"
fi

if confirm_yes "Commit universal agent rules files?"; then
  if [[ "$DRY_RUN" == true ]]; then
    printf 'Would stage AGENTS.md README.md sync.sh init-repo.sh\n'
    printf 'Would commit with message: %s\n' "$COMMIT_MESSAGE"
  else
    ensure_git_identity
    git add AGENTS.md README.md sync.sh init-repo.sh
    if git diff --cached --quiet; then
      printf 'No staged changes to commit.\n'
    else
      git commit -m "$COMMIT_MESSAGE"
    fi
  fi
fi

if confirm_yes "Add or update origin remote ${REMOTE_URL}?"; then
  if [[ "$DRY_RUN" == true ]]; then
    printf 'Would add or update origin remote to %s\n' "$REMOTE_URL"
  elif git remote get-url origin >/dev/null 2>&1; then
    git remote set-url origin "$REMOTE_URL"
    printf 'Updated origin remote to %s\n' "$REMOTE_URL"
  else
    git remote add origin "$REMOTE_URL"
    printf 'Added origin remote %s\n' "$REMOTE_URL"
  fi
fi

if confirm_yes "Push ${BRANCH} to origin?"; then
  run_cmd git push -u origin "$BRANCH"
else
  cat <<EOF
Push later with:
git push -u origin ${BRANCH}
EOF
fi
