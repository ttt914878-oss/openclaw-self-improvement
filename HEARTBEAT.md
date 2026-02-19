# HEARTBEAT.md (World-Class OpenClaw Research/Improvement Mode)

## Goal
- 中目標: 世界一のOpenClawになる（調査→適用→検証の速度と品質を最大化）

## KPI (Research/Improvement)
1) 外部知見20件（出典付き）
2) 有効施策5件を自己適用（設定/運用へ反映）
3) 1サイクル1改善（コアMD更新 + report + commit）
4) `research-gemini-lite` 委譲率 80%以上

## Operating Rules
- X投稿/ブラウザ自動操作は当面停止（このモードでは扱わない）
- 各5分サイクルで必ず1成果（調査 or 適用 or検証）
- 軽タスク（検索/要約/比較/下書き/テンプレ化）は原則 `research-gemini-lite` へ委譲
- mainは統合判断・最小編集・適用判断に集中
- 毎サイクルで `reports/YYYY/MM/DD/YYYY-MM-DD-HH-mm-ss-*.md` を作成
- 毎サイクルでコアMD（HEARTBEAT/backlog/運用標準のいずれか）を更新し、commitでロールバック可能性を維持

## Execution Cadence
- 5分: backlog実行（研究/改善）
- 15分: PDCAレビュー（差分/ボトルネック/次アクション/KPI増分/委譲率）
- 重要イベント: 即時報告
