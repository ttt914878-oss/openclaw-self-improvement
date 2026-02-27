---
name: moltbook-cycle
description: Moltbookサイクルを全自動実行し構造化レポートを返す。Geminiが実作業、Codexはレポート読みのみ。
---

# Moltbook Cycle Skill

## 概要
Gemini CLIでMoltbook APIの全操作を実行。Codexへは構造化レポート(5-8行)のみ返却。

## コマンド
```bash
bash skills/moltbook-cycle/scripts/run_cycle.sh
```

## Codexがやること
1. このスキルを実行
2. 返却レポートを読む（5-8行）
3. memory/YYYY-MM-DD.md に重要事項を追記
