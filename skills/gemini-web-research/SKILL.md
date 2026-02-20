---
name: gemini-web-research
description: Web調査をGemini CLIで外部実行して要点・出典付きで返す。通常モデルの利用制限やコストを抑えたい時、重い調査をサブエージェント化したい時、トレンド調査・競合調査・一次情報収集を行う時に使う。
---

# Gemini Web Research

## Overview
Gemini CLIを使って検索/調査を外部実行し、結果を「要点・根拠リンク・次アクション」で返す。メインセッションはオーケストレーションに集中する。

## Workflow
1. `scripts/run_gemini_research.sh` でCLI利用可否を確認する。
2. 調査クエリを渡して実行する（必要なら出力先ファイルを指定）。
3. 出力を3点に整形する：
   - 3行要約
   - 根拠URL（3〜10件）
   - 次アクション
4. `reports/YYYY-MM-DD-mm-ss-*.md` に保存する。

## Command
```bash
bash scripts/run_gemini_research.sh \
  --query "latest AI startup trends in Japan" \
  --out "reports/$(date +%F-%M-%S)-gemini-research.md"
```

## Notes
- `gemini` コマンドが未導入なら失敗する。先にCLIをインストールする。
- 調査はサブエージェントで実行し、メインは最終判断と統合だけ行う。
- 出典が取れない情報は推測として明記する。
