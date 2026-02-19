# AGENT_FLOW.md

## 現在のエージェント構成（2026-02-19）

### 1) main (codex)
- 役割: 方針決定・統合判断・最小編集・最終報告
- 通常入力（固定）:
  - `HEARTBEAT.md`（方針OS）
  - `backlog.md`（NOW/NEXT）
- 条件付き入力:
  - reportは**原則読まない**。読む場合は「必要な短断片のみ」。
- 通常出力:
  - コアMD更新（HEARTBEAT/backlog）
  - 重要イベント報告（短文）

### 2) gemini-cli-worker (codex agent + gemini CLI実行)
- 役割: 検索/要約/比較/下書き/軽いMD編集などの軽タスクを委譲実行
- 通常入力:
  - mainから渡されたタスク文
  - 必要ファイル（明示指定のみ）
- 処理:
  - `exec`でgemini CLI実行（pro-preview優先、厳しければ軽量へ）
- 通常出力:
  - reportファイル（必要時）
  - mainへの返却は最小（3行要約 + パス + KPI増分）

---

## 重要: 長文レポートの扱い（今回の要件）

### 対象
- 例: `2026-02-19-18-48-40-lean-worker.md` のような長文レポート

### ルール
1. **main(codex) は原則読まない**
2. **gemini-cli-worker(codex) も原則読まない**
3. 参照が必要な場合でも、**全文読込は禁止**
   - 必要箇所のみ（数行〜短断片）
4. 通常運用では、長文レポートの代わりに
   - 3行要約
   - ファイルパス
   - KPI増分
   だけを受け渡す

### だれが作って、だれが読むか
- 作成者: そのタスクの実行者（main または gemini-cli-worker）
- 読者: 原則なし（アーカイブ保管）
- 例外読者: 人間（TTT）が明示的に確認する場合

---

## 実行I/Oの明示（二層構造）

### Outer: gemini-cli-worker の codex
- Input: タスク文、必要ファイルパス
- Process: gemini CLI呼び出し、結果整形（本来は最小ハンドオフへ圧縮）
- Output: 3行要約 + パス + KPI増分

### Inner: gemini CLI（Geminiモデル）
- Input: prompt（必要ならstdin）
- Process: 調査/要約/比較/生成
- Output: テキスト結果（Outerが受け取り整形）

## フロー図（実運用・強制版）

```text
main(codex)
  └─ sessions_spawn(task)
      └─ gemini-cli-worker(codex/outer)
          ├─ exec: scripts/gemini_strict_report.sh --query ...
          │   └─ Gemini(inner)
          │       ├─ Input: prompt
          │       ├─ Process: 調査/生成
          │       └─ Output: 長文（stdout→reportファイルへ直書き）
          ├─ outerが受け取るのは script の短いメタ出力のみ
          │   ├─ REPORT_PATH=...
          │   ├─ SUMMARY_1=...
          │   ├─ SUMMARY_2=...
          │   └─ SUMMARY_3=...
          └─ mainへ最小返却（3行+path+KPI）
```

## 重要インシデント（2026-02-19-18-48-40-lean-worker.md）
- 当該ファイルは **gemini-cli-worker が生成**。
- ただしこの時は「Outer圧縮」が甘く、Innerの生テキスト（長文）がほぼそのまま保存された。
- 再発防止として、`scripts/gemini_strict_report.sh` を強制利用し、
  1) Gemini長文はreportへ直書き（セッションに流さない）
  2) outer/mainが扱うのは3行+pathのみ
  3) 長文reportの再読は禁止（必要時のみ断片参照）
  に統一する。

---

## 観測ルール（省トークン）
- 各サイクルで読むのは `HEARTBEAT.md` / `backlog.md` / 必要最小断片のみ
- 長文reportの再読は禁止
- 30〜60分バッチで必要最小の統合のみ行う
