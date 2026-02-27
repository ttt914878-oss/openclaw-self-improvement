# Cron Flow Summary

この資料は現在 root の cron で走っているジョブ（Sam backlog/summary/Moltbook cycle/TTT report/Kaizen）のうち、Codex 系と Gemini 系の責務・入力・出力を整理したものです。初心者にも追いやすいように、各 cron ごとに順序立てて説明しています。

---

## 1. Sam backlog execution (hourly reset)
- **有効状態:** 無効（`jobs.json` では `enabled: false`）。
- **目的:** 1時間バッチとして HEARTBEAT.md/backlog.md を読み、軽タスクは Gemini-based worker に委譲しながら必要なコード・設定変更を1件以上適用する。
- **Codex の入力:** `HEARTBEAT.md`（運用ルール）、`backlog.md`（TODO）、Gemini worker が収集したログ。
- **Codex の処理:** 新しい変更を推測し、必要なら1件以上の編集 + 1回だけ commit する指示を計画する。
- **Gemini の処理:** ここでは主に軽タスク（メモ作成/リサーチ）を Gemini worker に委ねる想定。Codex はその結果を受け取り、どの変更を適用するか判断する。
- **出力:** 指定された変更内容と、`memory/YYYY-MM-DD.md` への状態記録。コマンドライン上で `moltbook-cycle` や `kaizen` とは別の小さな改善アクションになる。

## 2. Sam hourly summary (hourly reset)
- **有効状態:** 無効。
- **目的:** 1時間分の成果を最大4行でまとめて Discord に送信（TTT への報告）。
- **Codex の入力:** `memory/` 以下に残っている直近の成果（例: `memory/moltbook-cycle-latest.md` + `memory/YYYY-MM-DD.md`）。
- **Codex の処理:** 投稿/コメント数、フォロワー変動、注目の出来事、次の重点アクションを 4 行で構成。
- **Gemini の処理:** この cron には特定の Gemini スクリプトがないため、省略可能。Codex が直接書く想定。
- **出力:** Discord への 4 行メッセージと `memory/YYYY-MM-DD.md` への記録。

## 3. Moltbook cycle (15m)
- **有効状態:** 有効。15 分ごとに HEARTBEAT.md に従って Moltbook サイクルを実行。
- **Codex の入力:**
  1. `HEARTBEAT.md`（15 分サイクル手順 + 投稿ルール）。
  2. `memory/moltbook-cycle-latest.md`（直近の Gemini 出力は別プロセスで追記される）。
  3. `MEMORY.md` の先頭約30 行（自己紹介や重要情報）。
- **Gemini の入力:**
  1. `run_cycle.py` が `api_get("/home")` と `api_get("/feed")` で取得した Moltbook データ。
  2. MEMORY/SAM の文脈。
  3. ユーザーに与えられたプロンプト（「Sam として投稿/コメント/フォローを決める」「構造化 JSON を返す」など）。
- **Gemini の処理:** `gemini-2.5-flash-lite` を使い、上記情報から様々なエンゲージメント判断を行い、`report`（STATUS/ACTIONS/METRICS/POSTED/NOTABLE/NEEDS_TTT/NEXT_PRIORITY）と API 行動案 `api_actions`（post/comment/follow の候補）を JSON フォーマットで出力する。
- **Codex の処理:**
  1. `run_cycle.py` が Gemini の JSON をパースし、`memory/moltbook-cycle-latest.md` に 1 ブロックを追記。
  2. `api_actions` を読み、 `/posts` や `/posts/<id>/comments`、`/agents/<name>/follow` に対して HTTP POST（Moltbook API）を実行。
  3. `HEARTBEAT.md` に従って `memory/YYYY-MM-DD.md` や `ENGAGEMENT_QUEUE.md` に重要事項/次の優先行動を記録。`heartbeat-state.json` へサイクル状況も追記。
- **出力:**
  - Moltbook API 上での投稿/コメント/フォロー動作。
  - `memory/moltbook-cycle-latest.md` への構造化レポート。
  - `memory/YYYY-MM-DD.md`、`ENGAGEMENT_QUEUE.md`、`memory/heartbeat-state.json` への要約。

## 4. TTT report (3h)
- **有効状態:** 有効。3 時間ごとに TTT へ成果報告。
- **目的:** 直近 1 時間分の Moltbook サイクル結果を読み、4 行（投稿/コメント/フォロー＋フォロワー変動＋注目事象＋次の重点）で Discord に要約。
- **Codex の入力:** `memory/moltbook-cycle-latest.md`（直近ブロック）、`memory/YYYY-MM-DD.md` に記録された NEES/TTS・ENGAGEMENT 情報。
- **Codex の処理:** 重要な数値と出来事を抽出し、指定フォーマットで Discord に送信。特定の Gemini プロンプトは存在しないが、生成支援が必要であれば Gemini を活用できる。
- **出力:** Discord への 4 行報告 + `memory/YYYY-MM-DD.md` へのログ（必要なら）。

## 5. Kaizen self-improvement (1h)
- **有効状態:** 有効。1 時間ごとに `kaizen` スキルを動かし、運用改善を提案。
- **Codex の入力:**
  1. AGENTS.md / HEARTBEAT.md / MEMORY.md（エージェント構成と方針）。
  2. `memory/moltbook-cycle-latest.md` の末尾 50 行（最近の Gemini レポート）。
- **Gemini の処理:** `gemini-2.5-flash-lite` に「自己改善アナリスト」プロンプト（`run_kaizen.sh` 内）を与え、インターネット検索結果 + 直近サイクルの欠点から 1 つの具体的な変更案を生成（RESEARCH/CURRENT_GAP/PROPOSED_CHANGE など）。
- **Codex の処理:**
  1. Gemini からの提案を `memory/kaizen-log.md` に追記。
  2. 提案が妥当であれば AGENTS.md や HEARTBEAT.md などを変更し、変更内容を対応する `memory/YYYY-MM-DD.md` に記録。
  3. `ENGAGEMENT_QUEUE.md` や `HEARTBEAT.md` に沿って次のアクションを計画。
- **出力:**
  - Kaizen の構造化提案（ログファイル）
  - 変更があれば対象ファイルの更新 + `memory/YYYY-MM-DD.md` への履歴
  - 必要に応じて Discord への報告（TTT Escalation Protocol）

---

必要であればこの資料をさらに図示したバージョンも作れますので、そのときはおっしゃってください。