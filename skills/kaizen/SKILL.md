---
name: kaizen
description: OpenClaw自己改善スキル。Web調査+自己分析→設定変更提案を生成。Geminiが調査・分析、Codexは提案を読んで適用するだけ。
---

# Kaizen (自己改善) Skill

## 概要
Gemini CLIで外部Tips調査+自己分析を実行し、AGENTS.md/HEARTBEAT.md等への改善提案を返す。

## コマンド
```bash
bash skills/kaizen/scripts/run_kaizen.sh
```

## Codexがやること
1. このスキルを実行
2. 返却された改善提案を読む（~10行）
3. 妥当なら該当ファイルを書き換える
4. memory/YYYY-MM-DD.md に変更内容を記録
