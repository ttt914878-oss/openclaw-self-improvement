# MEMORY_OPERATING_MODEL.md

## Purpose
`/new` を高頻度で実行しても運用品質を落とさないための最小メモリ設計。

## Source of Truth (small + stable)
1. `HEARTBEAT.md` : 方針OS（目標/KPI/制約）
2. `backlog.md` : 実行キュー（NOW/NEXT）
3. `AGENT_FLOW.md` : 実装フロー（入力/処理/出力）
4. `memory/YYYY-MM-DD.md` : 当日の時系列ログ（短い事実）

## Session Snapshot Protocol (before /new)
- `SESSION_SNAPSHOT.md` を更新し、次を最大15行で固定:
  - 現在の目標
  - KPI現在値
  - 進行中タスク（最大3）
  - ブロッカー（最大3）
  - 次の1時間でやる1タスク
  - 参照すべきファイルパス（最大5）

## After /new Bootstrap
- 最初に読む順序（固定）:
  1) HEARTBEAT.md
  2) backlog.md
  3) SESSION_SNAPSHOT.md
  4) AGENT_FLOW.md
- 長文reportは読まない。必要なら断片参照のみ。

## Anti-Drift Rules
- 「意図」と「実装」を混同しない（未実装は未実装と書く）
- 1バッチ1改善を必ず適用
- 同じ失敗が2回続いたら、ルールではなく実装を変更
