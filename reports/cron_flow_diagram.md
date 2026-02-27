# Cron Flow Diagrams & Notes

この資料は各 Cron ジョブで Codex（Sam）と Gemini がどんな入力・処理・出力を行っているか、視覚的に理解できるようにフローでまとめたものです。重複を避けつつ、どのファイルを見ているか、どのツールが何を担当しているかがひと目でわかるレイアウトになっています。

---

## 1. Moltbook cycle (15分)
```
┌─────────────┐          ┌───────────┐        ┌───────────┐
│ HEARTBEAT.md │          │ run_cycle │        │ Gemini     │
│ (Codexの運用│ ──────▶ │ .py が   │ ─────▶ │ (gemini-2.5 │
│ 手順と投稿方針)│          │ /home + /feed│        │  flash-lite) │
└─────────────┘          │ API を取得│        └─────┬──────┘
                          └──────┬─────┘              │
                                 │                    ▼
                                 │        ┌─────────────────────────┐
                                 │        │ JSON: { report, api_actions } │
                                 │        └────────────┬────────────┘
                                 ▼                     │
                     ┌──────────────────────┐         │
                     │ memory/moltbook-      │◀────────┘
                     │ cycle-latest.md       │
                     │ (Gemini 出力を追記) │
                     └──┬───────────────────┘
                        │
               tail -50 │ (必要なエントリだけ読み取る)
                        ▼
                ┌──────────────┐
                │ Codex / Sam  │
                │ (HEARTBEAT.mdに │
                │  従って記録・次優先を │
                │  memory/YYYY-MM-DD.md  │
                │  へ書き出す)│
                └──────────────┘
```

- **重要ポイント**
  - `run_cycle.py` は Gemini の構造化 JSON を `memory/moltbook-cycle-latest.md` に追記するだけ。Codex は直接このファイルの全体を読むのではなく、必要な直近エントリだけ（`tail -50` 相当）を参照します。
  - `api_actions`（post/comment/follow）をスクリプトが実際に Moltbook API に投げるので、その結果を Codex 知らせるのはレポートだけです。
  - Codex は `HEARTBEAT.md` の手順に従い、`memory/YYYY-MM-DD.md`、`ENGAGEMENT_QUEUE.md`、`memory/heartbeat-state.json` などに要約を残します。

---

## 2. Kaizen self-improvement (1時間)
```
┌──────────────┐    ┌───────────────┐    ┌────────────┐
│ AGENTS.md    │    │ kaizen       │    │ Gemini     │
│ HEARTBEAT.md │    │ スクリプト   │──▶│ (gemini-2.5 │
│ MEMORY.md    │──▶ │ (run_kaizen) │    │  flash-lite)│
└───────┬──────┘    └──────┬────────┘    └─────┬──────┘
        │                │                    │
        │                ▼                    ▼
        │         ┌──────────────┐    ┌────────────────────┐
        │         │ RECENT_CYCLES │    │ RESEARCH/CURRENT_GAP│
        │         │ (tail -50     │    │ PROPOSED_CHANGE 等  │
        │         │  で最新50行) │    └──────┬─────────────┘
        │         └──────┬───────┘           │
        │                │                  ▼
        │                ▼          ┌──────────────────────┐
        │         ┌──────────────┐  │ Codex が提案内容を    │
        └─────▶ │ Gemini 出力の│  │  1. ファイル更新      │
                │ ログを kaizen │  │  2. memory/YYYY-MM-DD │
                │ -log へ追記  │  │     などに記録        │
                └──────────────┘  └──────────────────────┘
```

- **ポイント**
  - Codex は `memory/moltbook-cycle-latest.md` の「直近 50 行」だけを `RECENT_CYCLES` として渡し、膨大な履歴を読み解く必要はない。
  - Gemini から返される `PROPOSED_CHANGE` を Codex が読んで、対象ファイルに反映し、`memory/YYYY-MM-DD.md` へ記録します。

---

## 3. TTT report (3時間)
```
┌──────────────┐
│ memory/       │
│ moltbook-     │
│ cycle-latest  │
│ (最新ブロック)│
└──────┬───────┘
       │
       ▼
┌──────────────┐
│ Codex が直近 │
│ 4 行の構造化 │
│  レポート作成 │
└──────┬───────┘
       │
       ▼
┌──────────────┐
│ Discord (TTT) │
│ へ送信        │
└──────────────┘
```

- **ポイント**
  - Gemini 処理は入らず、Codex が直接 `memory/moltbook-cycle-latest.md` や日次ログの最新を参照して報告をまとめます。
  - 直近の `report` ブロックだけを読むので、ファイル全体を読み直すことはありません。

---

## 4. Sam backlog / hourly summary（無効だが構造理解のため）
- **Sam backlog**: `HEARTBEAT.md` + `backlog.md` をコンテキストに、Codex が必要な修正を提案・適用。Gemini worker への簡易タスク委譲が含まれる。
- **Sam hourly summary**: `memory/moltbook-cycle-latest.md` など直近の成果をもとに、4 行で Discord に報告。Gemini 処理は使わない（あるいは補助的）。

---

## 追記：`memory/moltbook-cycle-latest.md` は Codex が全部を読まない理由
1. Gemini の出力は毎回追加されるが、Codex は `tail -50` もしくは同等の範囲絞りで「最新ブロックのみ」読む。
2. `HEARTBEAT.md` / `run_kaizen.sh` / `memory/YYYY-MM-DD.md` の指示には、必要な情報だけを抜き出すように明示されているため、トークン効率に問題がない。
3. 解析対象は基本的に「最後の1ブロックの 5-8 行」「直近の `report`」であり、全履歴を読み返すことはありません。

---

ご希望があれば、このフローを図示した PDF や Mermaid/PlantUML 形式の図版に変換することもできます。必要な表現があれば教えてください。