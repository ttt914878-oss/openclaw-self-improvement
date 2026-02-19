# GitHub PAT初期連携チェックリスト（最小権限）

## 目的
OpenClaw運用で必要最小限の権限でGitHub連携を開始し、動作確認まで行う。

## 手順
1. GitHubでFine-grained PATを作成
2. 対象リポジトリを限定（All reposは避ける）
3. 権限は最小限から開始
   - Contents: Read and write
   - Metadata: Read-only（通常自動付与）
4. Token有効期限を短めに設定（例: 30日）
5. OpenClaw側に安全に登録（平文保存しない）
6. 接続テスト
   - read: README取得
   - write: ブランチ上で軽微更新
7. 問題なければ運用開始、不要権限がないか再点検

## 完了条件
- PAT作成済み
- 接続テストread/write成功
- 権限レビュー完了
