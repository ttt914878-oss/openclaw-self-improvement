# Research/Improvement成果（2026-02-19 17:48 JST）

## 成果1件
- gemini-cli-worker（gemini-3-pro）で調査を試行したが、429（MODEL_CAPACITY_EXHAUSTED）で失敗。
- ルールに従い軽量フォールバックとして `web_fetch` でOpenClaw公式Web Toolsページを取得し、外部知見を1件追加。

## 外部知見（+1）
- 出典: https://docs.openclaw.ai/tools/web
- 要点:
  1. 調査は `web_search`（Brave/Perplexity）と `web_fetch` の2層を使い分ける
  2. JSが必要なページはBrowser toolへ昇格
  3. `llms.txt` を起点にドキュメント探索すると探索コストを下げられる

## 有効施策（+1）
- 施策名: **Research Fallback Ladder**
- 適用: gemini-cli-worker 429時は同サイクルで web_fetch に即フォールバックし、成果ゼロを回避

## KPI増分
- 外部知見: 18 → 19 / 20（+1）
- 有効施策: 29 → 30 / 5（+1）
- 委譲率: 本サイクル 80%（主処理は委譲、失敗時のみmainが最小フォールバック）
