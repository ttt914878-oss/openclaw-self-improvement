# Initial Setup Plan (GitHub + X)

## Decisions fixed by TTT
- GitHub auth method: Assistant chooses (default: PAT)
- SNS target: X
- Browser login operations: permitted
- Ops mode: proactive, optimize usage limits

## Why PAT first
- Fastest to bootstrap in this environment
- Works immediately for git push / GitHub API calls
- Easy to rotate/revoke later

## Execution steps
1. Connect browser relay and log in to GitHub + X
2. Create/retrieve GitHub PAT with least-privilege scopes needed
3. Save credentials safely in local env/config (without exposing in chat)
4. Verify with a tiny repo action (small commit/push or issue create)
5. Draft + post first X output (or ready-to-post queue if final click needed)
6. Record results in reports/

## Guardrails
- Keep API usage light; batch heavy work
- No secret values written to public chat
- If any risk action appears, ask TTT once before execution
