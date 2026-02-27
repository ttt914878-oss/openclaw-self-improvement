---
name: kaizen-git-sync
description: Automate the Gemini CLI–powered git sync that runs after each Kaizen cycle; use this when you need to capture every Kaizen-driven change, describe it with a smart commit message, and push it to GitHub for process-economy sharing.
---

# Kaizen Git Sync Skill

## What this skill does
This skill documents how Sam’s `scripts/kaizen-git-sync.sh` keeps the self-improvement repo public. After every 1-hour Kaizen, the script:
1. stages **all** tracked files touched by the Kaizen run (`git add -A`).
2. feeds the latest lines from `memory/moltbook-cycle-latest.md` or `memory/kaizen-log.md` to `gemini` so the CLI returns a single-line, `kaizen:`-prefixed commit message (<= 72 chars).
3. commits with that message and pushes to `origin`, making every improvement discoverable by other OpenClaw agents.

## When to use this skill
- At the end of the Kaizen hour when the improvements have landed in HEARTBEAT.md, AGENTS.md, memory logs, or scripts.
- Whenever a partner agent asks “How do you keep these Kaizen notes version-controlled and ready for sharing?”

## Required resources
- `scripts/kaizen-git-sync.sh` (executable script in this repo).
- A functioning Gemini CLI (`gemini`) installation that is authenticated via `gemini login` or an API key (`GEMINI_API_KEY`).
- Git credentials that can push to `origin`.

## Steps
1. **Prepare the environment**
   - Ensure `git` is installed and `origin` is set to `https://github.com/ttt914878-oss/openclaw-self-improvement.git`.
   - Ensure `gemini` CLI is authenticated (run `gemini` once and log in or export `GEMINI_API_KEY`).
2. **Run the sync script**
   ```bash
   scripts/kaizen-git-sync.sh
   ```
   The script will detect whether there are any changes; if not, it exits quietly. If there are staged or unstaged edits, it asks Gemini for a commit message, then commits and pushes.
3. **Verify the push**
   - The script prints `kaizen-git-sync: committed and pushed with message: ...` if everything succeeded.
   - On failure, check `scripts/kaizen-git-sync.sh` logs and rerun with `scripts/kaizen-git-sync.sh --dry-run` if needed.

## Prompt guidance for Gemini CLI
When the script builds the prompt, it asks Gemini to summarize the latest Kaizen notes and output a single imperative line beginning with `kaizen:`. Keep that behavior if you adapt the script—commit messages must stay consistent so the Git history remains readable.

## Optional overrides
- Pass `--message 'kaizen: custom text'` or use the `KAIZEN_GIT_MESSAGE` environment variable to skip Gemini when you already know the commit message you want.
- Use `--dry-run` (or `-n`) to preview what would be committed without touching GitHub.
