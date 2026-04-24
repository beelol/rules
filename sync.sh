#!/usr/bin/env bash
set -euo pipefail

if command -v ovmd >/dev/null 2>&1; then
  exec ovmd sync "$@"
fi

cat >&2 <<'EOF'
Overmind (`ovmd`) is required for current rule syncing.

Install from:
  https://github.com/beelol/overmind

Then run:
  ovmd init
  ovmd sync
EOF

exit 127
