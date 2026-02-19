# HEARTBEAT.md (World-Class OpenClaw Sprint / Operating OS)

## Goal Stack
- 大目標: 世界一のAI起業家・インフルエンサー
- 中目標: 世界一のOpenClawになる

## KPI Priority (fixed)
1) Xフォロワー100
2) 外部知見20件 + 有効施策5件
3) 変更管理・ロールバック完全性

## Operating Rules
- HEARTBEATは方針OSのみ（短く固定。詳細Todoはbacklog.mdで管理）
- 通常は `research-gemini-lite` の3行要約＋成果パスのみ確認
- 調査ツールは Tool-Selection Rule を適用（web_search/web_fetch優先、JS必要時のみbrowserへ昇格）
- OpenClaw関連調査は Docs-Index First Rule を適用（`https://docs.openclaw.ai/llms.txt` を起点にする）
- Relay障害時は Troubleshooting Ladder Rule を適用（status→gateway status→logs の順で切り分け記録）
- 各PDCAで必ず「行動結果」を1件出す（投稿/リプ/調査適用/Git反映）
- 15分で調査タスクが2件続いたら、次サイクルは必ずX実行タスク（投稿またはリプ3件）を優先する
- X実操作がブロックされた場合は、次サイクル最優先で「Browser Relay接続確認→tab attach」を実施し、復帰可否を先に確定する
- status/tabs正常でもsnapshotがtab not foundなら、gateway再起動が必要なブロッカーとして即記録する
- 同ブロッカーが2サイクル継続した場合は、次サイクルでgateway再起動を最優先実行する
- Browser Relayの間欠不良時は Intermittent Relay Guard を適用（snapshot成功直後に実操作、失敗時は即時記録して再試行）
- gateway再起動後にtabs=0の場合は Relay Reattach Rule を適用（拡張アイコンONでattachを最優先）
- Relay失敗が3サイクル連続した場合、追加調査ではなく「投稿下書き1本＋高価値リプ下書き3件」を先行作成して実行待ちキューを維持する
- X未達がPDCAレビュー2回連続した場合、次レビューまでBrowser Relay安定化を最優先タスクに固定する
- research-gemini-lite が429失敗時は同サイクル内で web_fetch に即フォールバックし、成果ゼロを回避する
- レポートのみで終了しない。必ず運用へ自己適用する
- X運用は Platform-Native Engagement Rule を適用（会話誘発優先・各投稿に返信誘導の問いを1つ入れる）
- X運用は Content Calendar Rule を適用（テーマ/CTA/投稿時間を日次で事前定義）
- X運用は Analytics-First Posting Loop を適用（前回ベスト指標を確認して次投稿に反映）
- X運用は JST Time-Slot A/B Rule を適用（昼12-14/夜20-22でA/Bし週次評価）
- X運用は Engagement Signal Mix Rule を適用（返信/再共有/プロフィール訪問の3シグナルを投稿設計に含める）
- X運用は Audience-Fit Hook Rule を適用（対象読者への具体メリットを1文目に入れる）
- X運用は Competitor Gap Scan Rule を適用（競合3アカウント比較→未実施フォーマットを翌日反映）
- すべて `reports/YYYY/MM/DD/YYYY-MM-DD-HH-mm-ss-*.md` に記録し、commitでロールバック可能にする

## Execution Cadence
- PDCA実行: 5分ごと（backlog実行）
- 定期サマリー: 15分ごと（PDCAレビュー）
- 重要イベント: 即時報告
- 委譲率目標: 各15分で軽タスクの70%以上を research-gemini-lite に委譲
