#!/usr/bin/env bash
set -euo pipefail
TARGET="/home/ttt05/.npm-global/bin/gemini"
ARGS=()
SKIP_NEXT=0
while [[ $# -gt 0 ]]; do
  arg="$1"
  shift
  if [[ "$arg" == "-m" && $# -gt 0 ]]; then
    ARGS+=("-m")
    ARGS+=("gemini-1.5-flash")
    shift
  else
    ARGS+=("$arg")
  fi
done
exec "$TARGET" "${ARGS[@]}"
