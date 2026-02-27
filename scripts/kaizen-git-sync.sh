#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

DMAINT="kaizen-git-sync"

commit_message_override=""
dry_run=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    -m|--message)
      if [[ $# -lt 2 ]]; then
        echo "${DMAINT}: --message requires an argument" >&2
        exit 1
      fi
      commit_message_override="$2"
      shift 2
      ;;
    --dry-run|-n)
      dry_run=true
      shift
      ;;
    --help|-h)
      echo "Usage: scripts/kaizen-git-sync.sh [--message '...'] [--dry-run]"
      exit 0
      ;;
    *)
      if [[ -n "$commit_message_override" ]]; then
        echo "${DMAINT}: unexpected argument '$1'" >&2
        exit 1
      fi
      commit_message_override="$1"
      shift
      ;;
  esac

done

if [[ -z "$commit_message_override" && -n "${KAIZEN_GIT_MESSAGE:-}" ]]; then
  commit_message_override="${KAIZEN_GIT_MESSAGE:-}"
fi

git_status_before=$(git status --porcelain)

if [[ -z "$git_status_before" ]]; then
  echo "${DMAINT}: no changes detected, skipping git sync" >&2
  exit 0
fi

function generate_commit_message() {
  local source_file=""

  if [[ -f memory/moltbook-cycle-latest.md ]]; then
    source_file="memory/moltbook-cycle-latest.md"
  elif [[ -f memory/kaizen-log.md ]]; then
    source_file="memory/kaizen-log.md"
  fi

  if [[ -z "$source_file" ]]; then
    return 1
  fi

  local excerpt
  excerpt=$(tail -n 400 "$source_file")

  if ! command -v gemini >/dev/null 2>&1; then
    echo "${DMAINT}: gemini CLI not installed, cannot auto-generate commit message" >&2
    return 1
  fi

  local prompt
  prompt=$(printf 'Sam just completed another Kaizen cycle and updated documentation, logs, or scripts. The excerpt below contains the most recent Kaizen notes. Respond with exactly one line: a concise (<=72 chars) git commit message that captures these improvements in imperative voice and prefixed with "kaizen:".

Excerpt:
%s

End of excerpt.' "$excerpt")

  local gemini_response
  if ! gemini -p "$prompt" --output-format text >/tmp/${DMAINT}_response.txt 2>/tmp/${DMAINT}_error.txt; then
    echo "${DMAINT}: gemini CLI failed to generate a message" >&2
    cat /tmp/${DMAINT}_error.txt >&2
    rm -f /tmp/${DMAINT}_response.txt /tmp/${DMAINT}_error.txt
    return 1
  fi

  gemini_response=$(sed '/^[[:space:]]*$/d' /tmp/${DMAINT}_response.txt | head -n 1 || true)
  rm -f /tmp/${DMAINT}_response.txt /tmp/${DMAINT}_error.txt

  if [[ -z "$gemini_response" ]]; then
    return 1
  fi

  printf '%s' "${gemini_response//\r/}" | head -c 72
}

if [[ -n "$commit_message_override" ]]; then
  commit_message="$commit_message_override"
else
  commit_message=""
  if ! commit_message=$(generate_commit_message); then
    commit_message="kaizen: document improvements"
  fi
fi

git add -A

if $dry_run; then
  git status -sb
  echo "${DMAINT}: dry-run mode — commit message would be: $commit_message"
  exit 0
fi

pushed=false

if git diff --cached --quiet --ignore-submodules --exit-code; then
  echo "${DMAINT}: no staged changes after add, aborting" >&2
  exit 1
fi

GIT_COMMIT_ACTION=(git commit -m "$commit_message")
"${GIT_COMMIT_ACTION[@]}"

if git push origin HEAD; then
  pushed=true
fi

if [[ "$pushed" == true ]]; then
  echo "${DMAINT}: committed and pushed with message: $commit_message"
else
  echo "${DMAINT}: committed locally but failed to push" >&2
  exit 1
fi
