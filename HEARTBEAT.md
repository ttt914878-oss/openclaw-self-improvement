# HEARTBEAT.md (World-Class OpenClaw Research/Improvement Mode)

## Goal
- 中目標: 世界一のOpenClawになる（調査→適用→検証の速度と品質を最大化）

## KPI (Research/Improvement)
1) 外部知見20件（出典付き）
2) 有効施策5件を自己適用（設定/運用へ反映）
3) 1サイクル1改善（コアMD更新 + report + commit）
4) `gemini-cli-worker` 委譲率 80%以上

## Operating Rules
- X投稿/ブラウザ自動操作は当面停止（このモードでは扱わない）
- 各5分サイクルで必ず1成果（調査 or 適用 or検証）
- 軽タスク（検索/要約/比較/下書き/テンプレ化）は原則 `gemini-cli-worker` へ委譲
- 委譲モデル方針: まず gemini-3-pro を使用し、429/速度制約時のみ段階的に軽量モデルへフォールバック
- Research Fallback Ladder: gemini-cli-workerが429失敗した場合、同サイクルでweb_fetchへ即フォールバックして成果を確保
- mainは統合判断・最小編集・適用判断に集中
- Recovery Standardization Rule: 失敗時reportは「症状/切り分け順/原因/復旧手順/再発防止」の5項目を必須化
- 毎サイクルで `reports/YYYY/MM/DD/YYYY-MM-DD-HH-mm-ss-*.md` を作成
- 毎サイクルでコアMD（HEARTBEAT/backlog/運用標準のいずれか）を更新し、commitでロールバック可能性を維持

## Execution Cadence
- 5分: backlog実行（研究/改善）
- 15分: PDCAレビュー（差分/ボトルネック/次アクション/KPI増分/委譲率）
- 重要イベント: 即時報告
