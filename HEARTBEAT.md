# HEARTBEAT.md (World-Class OpenClaw / Lean Token Mode)

## Goal
- 世界一のOpenClaw運用を作る（調査→適用→検証を高速・再現可能に）

## KPI
1) 外部知見20件（出典付き）
2) 有効施策5件を自己適用
3) 委譲率80%以上（軽タスクは gemini-cli-worker）

## Lean Rules
- codexは最小判断のみ。軽タスクは原則 gemini-cli-worker へ委譲
- 読み込み最小化: HEARTBEAT/backlog/直近必要ファイルのみ
- 報告は1時間ごと + 重要イベントのみ（短文）
- 5分サイクルでは report短形式を作る。commitは1時間バッチ
- レポートだけで終わらず、必ず1つは運用へ自己適用

## Cadence
- 5分: backlog実行
- 15分: 内部PDCA（必要なら）
- 60分: 外部報告
