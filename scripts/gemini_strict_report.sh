#!/usr/bin/env bash
set -euo pipefail

# Strict pipeline: Gemini long output -> file, worker returns only 3-line summary + path.
# Usage:
#   gemini_strict_report.sh --query "..." [--model gemini-3-pro-preview] [--outdir reports/$(date +%Y/%m/%d)]

QUERY=""
MODEL="gemini-3-pro-preview"
OUTDIR="/home/ttt05/.openclaw/workspace/reports/$(date +%Y/%m/%d)"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --query) QUERY="$2"; shift 2;;
    --model) MODEL="$2"; shift 2;;
    --outdir) OUTDIR="$2"; shift 2;;
    *) echo "Unknown arg: $1" >&2; exit 2;;
  esac
done

if [[ -z "$QUERY" ]]; then
  echo "--query is required" >&2
  exit 2
fi

mkdir -p "$OUTDIR"
TS="$(date +%F-%H-%M-%S)"
REPORT_PATH="$OUTDIR/${TS}-gemini-report.md"
ERR_PATH="$OUTDIR/${TS}-gemini-report.err.log"

PROMPT=$(cat <<EOF
You are a research worker.
Task: ${QUERY}
Output requirements:
- Write a concise but useful markdown report.
- Start with a section "## Summary" and include exactly 3 bullet lines in that section.
- Then include evidence links and actionable steps.
EOF
)

# Long text is redirected to file; do not print to stdout.
if ! gemini -m "$MODEL" -p "$PROMPT" > "$REPORT_PATH" 2> "$ERR_PATH"; then
  # fallback model
  MODEL="gemini-3-flash-preview"
  if ! gemini -m "$MODEL" -p "$PROMPT" > "$REPORT_PATH" 2>> "$ERR_PATH"; then
    echo "STATUS=FAILED"
    echo "REPORT_PATH=$REPORT_PATH"
    echo "ERROR_LOG=$ERR_PATH"
    exit 1
  fi
fi

# Extract only 3 summary bullets; never emit full report.
mapfile -t bullets < <(awk '
  /^## Summary/{flag=1; next}
  /^## /{if(flag) exit}
  flag && /^[-*] / {print}
' "$REPORT_PATH" | head -n 3)

echo "STATUS=OK"
echo "MODEL=$MODEL"
echo "REPORT_PATH=$REPORT_PATH"
for i in 0 1 2; do
  line="${bullets[$i]:-- (summary unavailable)}"
  echo "SUMMARY_$((i+1))=$line"
done
