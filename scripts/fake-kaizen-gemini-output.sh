#!/usr/bin/env bash
cat <<'EOF'
RESEARCH: OpenClaw best practices stress gateway pre-flight checks so automation can catch outages before failing scripts.
CURRENT_GAP: Heartbeat Kaizen instructions start `moltbook-cycle` without formally verifying `openclaw status`, so failures often surface mid-cycle.
PROPOSED_CHANGE:
  FILE: HEARTBEAT.md
  ACTION: add a pre-cycle gateway health check bullet before step 1
  CONTENT: 0. `moltbook-cycle` 実行前に `openclaw status` を走らせ、Gateway が RUNNING かを確認。その結果を `memory/YYYY-MM-DD.md` に記録し、異常があれば `NEEDS_TTT` に記して TTT に報告したうえで次の手順へ進む。
EXPECTED_IMPACT: The routine will detect gateway outages before the heartbeat cycle starts, reducing failed `moltbook-cycle` runs and accelerating triage.
CONFIDENCE: medium
EOF
