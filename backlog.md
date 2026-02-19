# backlog.md

## NOW（次の15分で実行・優先順）
- [ ] P1: Browser Relay安定化タスク（最優先）
  - 実行: Service-Recover手順（status/tabs/snapshot→必要時gateway再起動）
  - 完了条件: running=true, tabs>=1, `browser snapshot` 成功
  - 期待効果: X投稿/リプ実行の復帰率向上
- [ ] P2: 高価値リプ 3件（競合ギャップ観点の技術コメント）
  - 完了条件: 返信URL 3件
  - 前提: P1完了（attach確認）
  - 実行理由: 投稿送信失敗の継続により、先にX実行KPIを回復
  - 期待効果: 露出増とReply→Follow比改善
- [ ] P3: X投稿 1本を実行（Single-Shot Submit Rule）
  - 実行: Audience-Fit Hook + Soft-CTA + 返信誘導の問いを投入し、snapshot直後に送信1回のみ
  - 完了条件: 投稿URL取得
  - 前提: P2完了後に再実行
  - 期待効果: プロフィール訪問増（X100に直結）

## NEXT（次サイクル候補）
- [ ] Chrome拡張でXタブattach完了後、P2/P3を即実行（最優先・毎サイクル再確認・再接続後ただちに実行）
- [x] attach未完了時のユーザー向け1行依頼テンプレを固定化
- [x] Relay不安定時の「投稿下書き1本/リプ3件」先行キュー運用
- [ ] Xプロフィール最適化（Who/What/Benefit/CTA + 固定ポスト導線）
- [ ] OpenClaw Tips収集を累計20件まで拡張（残3）
- [ ] 投稿時間帯JSTのA/Bテスト（昼/夜）を1セット実施
- [ ] 週次メトリクス（Profile Visits / Follow Conversion / Reply→Follow）更新
- [ ] X投稿フォーマットA/Bテスト
- [ ] ブロッカー復旧手順の短縮版テンプレ化（1ページ）

## LATER（本日後半）
- [ ] 週次メトリクスレビュー枠の固定化
- [ ] 失敗パターン集の更新

## Rule
- 各5分PDCAでNOWから最低1件消化
- 消化後はチェック更新し、必要ならNEXT→NOWへ昇格
