# short
- task: gemini-cli-workerに軽タスク委譲（省トークン施策1件）
- source: https://openclaw.ai
- insight: 長文は全文注入せず、必要断片のみ取得（surgical retrieval）
- apply: read時はoffset/limit優先（Context Fragmentation Ruleを実行継続）
- kpi: 外部知見 +1 / 委譲率 本サイクル100%
- note: 1時間バッチ方針によりcommit未実施
