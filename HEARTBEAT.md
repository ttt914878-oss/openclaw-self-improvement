# HEARTBEAT.md (World-Class OpenClaw / Lean Token Mode)

## Goal
- 世界一のOpenClaw運用を作る（調査→適用→検証を高速・再現可能に）
- 明朝までに「自己改善ループが自走して成果が出る設計」へ完成させる

## KPI
1) 外部知見20件（出典付き）
2) 有効施策5件を自己適用
3) 委譲率80%以上（軽タスクは gemini-cli-worker）

## Lean Rules
- codexは最小判断のみ。軽タスクは原則 gemini-cli-worker へ委譲
- 読み込み最小化: HEARTBEAT/backlog/直近必要ファイルのみ
- 報告は1時間ごと + 重要イベントのみ（短文）
- reportは原則30〜60分バッチ（毎サイクルは作らない）
- Batch Commit Gate: commitは毎時バッチ（:00前後）でのみ実施
- レポートだけで終わらず、必ず1つは運用へ自己適用
- Context Fragmentation Rule: 長文メモリは全文注入せず、必要断片のみ取得して使う
- 実行フロー可視化: `AGENT_FLOW.md` を正本とし、各エージェントの入力/処理/出力を管理する

## Token Efficiency Protocol (No-Waste)
- 回数削減ではなく、**1サイクル当たりの無駄を削る**ことを最優先
- 各サイクルで必ず記録する: `成果件数 / 推定トークン消費 / 1成果あたりコスト`
- 直近サイクルより効率が悪化した場合、次サイクルで必ず原因1件を潰す
- Codex入力は固定スロット化（HEARTBEAT + backlog + 最新必要断片のみ）
- 長文生成は常に Gemini 側でファイルへ直書きし、Codexへは3行要約+pathのみ返す
- 同一内容の再分析・再説明は禁止。差分のみ扱う
- 目標: 「必要コンテキストは減少、成果は増加」を毎時間達成する

## Autonomous Improvement Loop (Mandatory)
各バッチで必ず以下を順番に実行する:
1) 仮説立案（何を改善すると効果が最大か）
2) 外部調査（gemini-cli-workerで出典付き収集）
3) 設計更新（HEARTBEAT/backlog/AGENT_FLOWの必要箇所）
4) 実装（設定/スクリプト/運用ルール）
5) テスト（想定挙動を満たすか）
6) 評価（KPI増分、トークン効率、失敗率）
7) 改善反映（次バッチ計画へ）

## Cadence
- 60分: backlog実行（研究・実装・テスト）
- 60分: 内部PDCAレビュー（差分/原因/次計画）
- 60分: 外部報告（短文）

## Proactive Self-Audit (Mandatory)
- 毎バッチで「本来もっと早く気づくべきこと」を1件探し、原因を1行で記録
- 原因が実装ギャップなら、同バッチで必ず実装修正（ルール追記だけで終わらない）
- `/new` 前提運用のため、バッチ終了時に `SESSION_SNAPSHOT.md` を更新
