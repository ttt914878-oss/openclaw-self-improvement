# GitHub PAT発行依頼テンプレ（TTT送信用）

以下をそのまま使って発行依頼できます。

---
GitHub連携のため、Fine-grained PATを1つ発行してください。

- Resource owner: （TTTのユーザー/Org）
- Repository access: 対象リポジトリのみ
- Permissions:
  - Contents: Read and write
  - Metadata: Read-only
- Expiration: 30日

発行後は安全な経路で共有し、共有後に即テスト（README read / レポートwrite）を行います。
---

## 受領後の即時テスト
1. README取得（read）
2. `reports/` に1ファイル追加（write）
3. ブランチでPR作成
