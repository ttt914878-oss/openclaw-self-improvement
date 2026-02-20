#!/usr/bin/env bash
set -euo pipefail

QUERY=""
OUT=""
CMD="${GEMINI_CMD:-gemini}"
MAX_RETRIES="${MAX_RETRIES:-3}"
SLEEP_BASE="${SLEEP_BASE:-20}"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --query) QUERY="$2"; shift 2;;
    --out) OUT="$2"; shift 2;;
    --cmd) CMD="$2"; shift 2;;
    --retries) MAX_RETRIES="$2"; shift 2;;
    --sleep-base) SLEEP_BASE="$2"; shift 2;;
    *) echo "Unknown arg: $1" >&2; exit 2;;
  esac
done

if [[ -z "$QUERY" ]]; then
  echo "--query is required" >&2
  exit 2
fi

if ! command -v "$CMD" >/dev/null 2>&1; then
  echo "gemini cli not found: $CMD" >&2
  exit 127
fi

PROMPT=$(cat <<EOF
You are a research assistant. Research the following query and return:
1) 3-bullet summary
2) 3-10 source URLs
3) action recommendations

Query: $QUERY
EOF
)

attempt=1
while (( attempt <= MAX_RETRIES )); do
  echo "[gemini-research] attempt ${attempt}/${MAX_RETRIES}" >&2
  set +e
  if [[ -n "$OUT" ]]; then
    mkdir -p "$(dirname "$OUT")"
    "$CMD" "$PROMPT" 2>&1 | tee "$OUT"
    rc=${PIPESTATUS[0]}
  else
    "$CMD" "$PROMPT"
    rc=$?
  fi
  set -e

  if [[ $rc -eq 0 ]]; then
    exit 0
  fi

  if (( attempt == MAX_RETRIES )); then
    echo "[gemini-research] failed after ${MAX_RETRIES} attempts" >&2
    exit $rc
  fi

  sleep_sec=$(( SLEEP_BASE * attempt ))
  echo "[gemini-research] retry in ${sleep_sec}s (likely 429/capacity/transient)" >&2
  sleep "$sleep_sec"
  ((attempt++))
done
