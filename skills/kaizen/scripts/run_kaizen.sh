#!/usr/bin/env bash
set -euo pipefail

GEMINI_CMD="${GEMINI_CMD:-gemini}"
GEMINI_MODEL="${GEMINI_MODEL:-gemini-3-flash-preview}"
WORKSPACE_DIR="/home/ttt05/.openclaw/workspace"
MEMORY_DIR="$WORKSPACE_DIR/memory"
KAIZEN_LOG="$MEMORY_DIR/kaizen-log.md"

# Ensure gemini is available
if ! command -v "$GEMINI_CMD" >/dev/null 2>&1; then
  if [[ -x "/home/ttt05/.npm-global/bin/gemini" ]]; then
    export PATH="/home/ttt05/.npm-global/bin:$PATH"
  else
    echo "STATUS: ERROR"
    echo "DETAIL: gemini cli not found"
    exit 127
  fi
fi

# Self-Recovery: Clear stale processes and browser locks before running gemini
echo "Running Gemini environment health check..."
pkill -9 -f chrome || true
# Kill stale gemini processes (excluding the current one)
STALE_PIDS=$(pgrep -f gemini | grep -v "$$" || true)
if [[ -n "$STALE_PIDS" ]]; then
  echo "Killing stale gemini processes: $STALE_PIDS"
  kill -9 $STALE_PIDS || true
fi
rm -f /home/ttt05/.cache/chrome-devtools-mcp/chrome-profile/SingletonLock

mkdir -p "$MEMORY_DIR"

# Read current config files
AGENTS_MD=$(cat "$WORKSPACE_DIR/AGENTS.md" 2>/dev/null || echo "(not found)")
HEARTBEAT_MD=$(cat "$WORKSPACE_DIR/HEARTBEAT.md" 2>/dev/null || echo "(not found)")
MEMORY_MD=$(cat "$WORKSPACE_DIR/MEMORY.md" 2>/dev/null || echo "(not found)")

# Read recent cycle results
RECENT_CYCLES=""
if [[ -f "$MEMORY_DIR/moltbook-cycle-latest.md" ]]; then
  RECENT_CYCLES=$(tail -50 "$MEMORY_DIR/moltbook-cycle-latest.md")
fi

PROMPT="You are a self-improvement analyst for an AI agent named Sam on Moltbook.

CURRENT CONFIGURATION:
--- AGENTS.md ---
$AGENTS_MD
--- HEARTBEAT.md ---
$HEARTBEAT_MD
--- MEMORY.md ---
$MEMORY_MD
--- Recent Moltbook Cycle Results ---
$RECENT_CYCLES

YOUR TASK:
1. Search the web for: OpenClaw best practices, Moltbook top agent strategies, AI agent social media tips
2. Analyze Sam's current performance based on recent cycle results
3. Identify ONE specific, high-impact improvement
4. Generate a concrete change proposal

RETURN ONLY this structured format:

RESEARCH: [1-line summary of what you found]
CURRENT_GAP: [what's missing or underperforming]
PROPOSED_CHANGE:
  FILE: [which file to modify]
  ACTION: [what to add/change/remove]
  CONTENT: [exact text to add or replace]
EXPECTED_IMPACT: [what should improve]
CONFIDENCE: [high/medium/low]"

# Run Gemini
FULL_OUTPUT=$("$GEMINI_CMD" -m "$GEMINI_MODEL" --approval-mode yolo --prompt "$PROMPT" 2>/dev/null) || {
    echo "STATUS: ERROR"
    echo "DETAIL: gemini execution failed"
    exit 1
}

# Save to kaizen log
echo "--- Kaizen $(date -Iseconds) ---" >> "$KAIZEN_LOG"
echo "$FULL_OUTPUT" >> "$KAIZEN_LOG"
echo "" >> "$KAIZEN_LOG"

# Extract diff snippet and append to ENGAGEMENT_QUEUE.md for PoW posting
DIFF_SNIPPET=$(git diff HEAD~1 HEAD 2>/dev/null | head -n 20 || echo "(no diff available)")
{
  echo "## Kaizen PoW Snippet $(date -Iseconds)"
  echo "PROPOSAL: $(echo "$FULL_OUTPUT" | grep 'RESEARCH:' | cut -d' ' -f2-)"
  echo '```diff'
  echo "$DIFF_SNIPPET"
  echo '```'
  echo "CTA: Follow Sam for weekly Kaizen lab insights, early OpenClaw reliability experiments, and hands-on entrepreneurial infrastructure playbooks."
  echo ""
} >> "$WORKSPACE_DIR/ENGAGEMENT_QUEUE.md"

# Return structured proposal
echo "$FULL_OUTPUT" | grep -E '^(RESEARCH|CURRENT_GAP|PROPOSED_CHANGE|FILE|ACTION|CONTENT|EXPECTED_IMPACT|CONFIDENCE|STATUS):' || {
    echo "STATUS: OK (unstructured)"
    echo "$FULL_OUTPUT" | head -12
}
