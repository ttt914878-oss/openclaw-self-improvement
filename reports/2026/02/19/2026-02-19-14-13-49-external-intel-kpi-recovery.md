# External Intel KPI Recovery Report
- Date: 2026-02-19 (JST)
- Scope: OpenClaw運用Tips / productivity / context management / cron heartbeat best practices
- Method: Gemini CLIによる外部公開情報サーベイ + OpenClaw適用観点で再構成

## 1) 運用Tips 10件（出典URL付き）

1. **HEARTBEAT.mdで進捗/次アクションを毎回更新する**  
   - 要点: 長時間タスク時の文脈喪失を防ぐため、状態をファイルへ外部化する。  
   - 出典: https://simonwillison.net/2023/Apr/14/worst-case-scenario-programming/

2. **無視対象ファイルを定義してコンテキストを軽量化する**  
   - 要点: `node_modules`/ビルド成果物/ログを除外し、トークン浪費とノイズを削減。  
   - 出典: https://aider.chat/docs/usage/ignore.html

3. **SOUL.md（役割・制約）を明文化して出力ぶれを抑える**  
   - 要点: ペルソナ、禁止事項、出力スタイルを固定し、再現性を高める。  
   - 出典: https://learn.microsoft.com/en-us/azure/ai-services/openai/concepts/system-message

4. **小さく刻んだ変更＋Gitコミットで安全性を担保する**  
   - 要点: 破壊的変更時に即ロールバック可能な運用にする。  
   - 出典: https://aider.chat/docs/usage/watch.html

5. **Cronで定期実行し、非同期に進捗を前進させる**  
   - 要点: 30–60分ごとに「状況確認→1改善」を回し、停滞を減らす。  
   - 出典: https://github.com/Significant-Gravitas/AutoGPT/discussions/4130

6. **複雑タスクは「計画→実行」の段階分離を徹底する**  
   - 要点: 先に方針化してから編集し、手戻りや誤編集を低減。  
   - 出典: https://arxiv.org/abs/2201.11903

7. **プロジェクト前提（言語/バージョン/制約）を固定ファイル化する**  
   - 要点: 実行環境不一致のコード生成を減らす。  
   - 出典: https://docs.cursor.com/context/rules-for-ai

8. **失敗ログをエージェント入力に直結して自己修復ループ化する**  
   - 要点: テスト失敗→ログ要約→修正案→再テストを自動化。  
   - 出典: https://medium.com/@jrod7/self-healing-code-is-here-ca8388484e55

9. **大規模変更前に影響範囲調査フェーズを設ける**  
   - 要点: 実装前に依存関係・関連箇所を列挙し、事故を抑える。  
   - 出典: https://adr.github.io/

10. **ファイル全読込ではなく範囲指定読込を優先する**  
    - 要点: 必要箇所のみ読む運用でコスト/遅延を抑制。  
    - 出典: https://www.anthropic.com/blog/context-window-optimization

## 2) 即適用候補 3件（効果/リスク/適用手順）

### A. HEARTBEAT運用の標準化
- 効果: 長時間作業での目的逸脱・重複作業を削減。引き継ぎもしやすい。
- リスク: 更新漏れがあると逆に誤誘導。テンプレ未整備だと品質がぶれる。
- 適用手順:
  1. `HEARTBEAT.md`テンプレを作成（目的/現在地/次アクション/ブロッカー）。
  2. 「作業開始前・終了時に更新」を運用ルール化。
  3. 重要タスクはPR/レポート提出時にHEARTBEAT整合を確認。

### B. `.geminiignore`（または同等）で不要コンテキスト除外
- 効果: トークン消費とノイズを削減し、回答品質と応答速度を改善。
- リスク: 必要ファイルまで除外し、誤判断を誘発する可能性。
- 適用手順:
  1. 除外初期セットを定義（`.git/`, `node_modules/`, `dist/`, `*.log`, `tmp/`）。
  2. 代表タスクで差分比較（精度/速度/トークン）を実施。
  3. 誤除外が出たら即見直し、除外リストを最小化。

### C. Cron定期実行 + 最大試行回数ガード
- 効果: 人手不在時も小さな改善を継続し、滞留タスクを減らす。
- リスク: 無限再試行によるコスト増、誤修正の連鎖。
- 適用手順:
  1. 単発実行スクリプト（1サイクルのみ）を作成。
  2. `crontab`で30–60分周期実行、`max_attempts`を明示。
  3. 異常時通知（Slack/メール）と停止条件（同一失敗N回）を実装。

## 3) OpenClawへの適用メモ
- OpenClaw固有情報が限定的なため、CLIエージェント一般知見を**OpenClawのHEARTBEAT/SOUL運用**にマッピングして整理。
- 優先導入順は **HEARTBEAT標準化 → ignore最適化 → cron自動化** が低リスク・高効果。

## 4) 参考URL一覧（重複なし）
- https://simonwillison.net/2023/Apr/14/worst-case-scenario-programming/
- https://aider.chat/docs/usage/ignore.html
- https://learn.microsoft.com/en-us/azure/ai-services/openai/concepts/system-message
- https://aider.chat/docs/usage/watch.html
- https://github.com/Significant-Gravitas/AutoGPT/discussions/4130
- https://arxiv.org/abs/2201.11903
- https://docs.cursor.com/context/rules-for-ai
- https://medium.com/@jrod7/self-healing-code-is-here-ca8388484e55
- https://adr.github.io/
- https://www.anthropic.com/blog/context-window-optimization
