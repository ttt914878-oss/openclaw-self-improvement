#!/usr/bin/env bash
set -euo pipefail

# Quick integrity check for hourly autonomous loop artifacts.
# Usage: hourly_batch_check.sh [--date YYYY-MM-DD]

DAY="$(date +%F)"
while [[ $# -gt 0 ]]; do
  case "$1" in
    --date) DAY="$2"; shift 2;;
    *) echo "Unknown arg: $1" >&2; exit 2;;
  esac
done

ROOT="/home/ttt05/.openclaw/workspace"
BACKLOG="$ROOT/backlog.md"
SNAPSHOT="$ROOT/SESSION_SNAPSHOT.md"
MEMORY_DAY="$ROOT/memory/${DAY}.md"
REPORT_DIR="$ROOT/reports/${DAY//-//}"

ok=1

[[ -f "$BACKLOG" ]] || { echo "MISSING: $BACKLOG"; ok=0; }
[[ -f "$SNAPSHOT" ]] || { echo "MISSING: $SNAPSHOT"; ok=0; }
[[ -f "$MEMORY_DAY" ]] || { echo "MISSING: $MEMORY_DAY"; ok=0; }
[[ -d "$REPORT_DIR" ]] || { echo "MISSING: $REPORT_DIR"; ok=0; }

if [[ $ok -eq 1 ]]; then
  last_report="$(ls -1 "$REPORT_DIR"/*hourly-batch*.md 2>/dev/null | tail -n 1 || true)"
  if [[ -z "$last_report" ]]; then
    echo "WARN: no hourly batch report found in $REPORT_DIR"
  else
    echo "LAST_HOURLY_REPORT=$last_report"
  fi
  echo "CHECK=OK"
  exit 0
fi

echo "CHECK=NG"
exit 1
