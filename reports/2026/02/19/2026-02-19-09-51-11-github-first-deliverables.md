# GitHub 実成果パック（接続後すぐ実施）

## 目的
接続完了直後に“成果が見える”最小コミットを作る。

## Deliverable A: `/reports` の運用整備
- 追加: `reports/README.md`
- 内容: 日次レポート命名規則、更新ルール、レビュー基準

## Deliverable B: 事業仮説1枚ドキュメント
- 追加: `docs/business-hypothesis-ai-risk-radar.md`
- 内容: 誰の課題をどう解くか、価格、PoC設計

## Deliverable C: Issueテンプレ
- 追加: `.github/ISSUE_TEMPLATE/pdca-task.md`
- 内容: 目的/Done条件/次アクション

## 接続直後の確認手順（5分）
1. read: repoのREADME取得
2. branch作成: `feat/pdca-bootstrap`
3. A/B/Cをcommit
4. PR作成（タイトル: `PDCA bootstrap: reporting + hypothesis + template`）

## Done条件
- 1PRが作成済み
- 3ファイル以上の成果が可視化
- 次タスクがIssue化されている
