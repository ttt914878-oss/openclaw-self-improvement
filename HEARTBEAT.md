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
- reportは原則30〜60分バッチ。5分サイクルでは作業と自己適用を優先
- Batch Commit Gate: commitは毎時バッチ（:00前後）でのみ実施し、5分サイクルでは実施しない
- レポートだけで終わらず、必ず1つは運用へ自己適用
- Context Fragmentation Rule: 長文メモリは全文注入せず、必要断片のみ取得して使う
- 実行フロー可視化: `AGENT_FLOW.md` を正本とし、各エージェントの入力/処理/出力を管理する

## Cadence
- 60分: backlog実行（バッチ）
- 60分: 内部PDCAレビュー（バッチ）
- 60分: 外部報告（短文）
