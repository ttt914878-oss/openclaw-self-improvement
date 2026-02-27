import os
import json
import urllib.request
import urllib.parse
import subprocess
import datetime
import re

API_KEY = "moltbook_sk_E7zDhDSmxE_rwSfao1fQRb9UKXboKSjy"
BASE_URL = "https://www.moltbook.com/api/v1"
WORKSPACE_DIR = "/home/ttt05/.openclaw/workspace"
REPORT_FILE = f"{WORKSPACE_DIR}/memory/moltbook-cycle-latest.md"
STATE_FILE = f"{WORKSPACE_DIR}/memory/moltbook-cycle-state.json"
REQUEST_LIMIT = 100
REQUEST_COUNT = 0


def ensure_request_available():
    global REQUEST_COUNT
    REQUEST_COUNT += 1
    if REQUEST_COUNT > REQUEST_LIMIT:
        raise RuntimeError("Request limit exceeded for this cron cycle")


def api_get(endpoint):
    ensure_request_available()
    req = urllib.request.Request(f"{BASE_URL}{endpoint}", headers={"Authorization": f"Bearer {API_KEY}"})
    try:
        response = urllib.request.urlopen(req)
        return json.loads(response.read())
    except Exception as e:
        print(f"Error GET {endpoint}: {e}")
        return None


def api_post(endpoint, data=None):
    ensure_request_available()
    if data:
        data = json.dumps(data).encode('utf-8')
    req = urllib.request.Request(f"{BASE_URL}{endpoint}", data=data, headers={"Authorization": f"Bearer {API_KEY}", "Content-Type": "application/json"}, method="POST")
    try:
        response = urllib.request.urlopen(req)
        return json.loads(response.read())
    except Exception as e:
        print(f"Error POST {endpoint}: {e}")
        return None


def get_memory_context():
    mem_file = f"{WORKSPACE_DIR}/MEMORY.md"
    if os.path.exists(mem_file):
        with open(mem_file, "r") as f:
            return ''.join(f.readlines()[:30])
    return ""


def load_state():
    default = {"next_action": "post", "last_post": None, "last_comment": None}
    if os.path.exists(STATE_FILE):
        try:
            with open(STATE_FILE, "r") as f:
                data = json.load(f)
            default.update({k: data.get(k, default[k]) for k in default})
        except Exception:
            pass
    return default


def save_state(state):
    with open(STATE_FILE, "w") as f:
        json.dump(state, f)


def action_due(last_iso, now):
    if not last_iso:
        return True
    last_time = datetime.datetime.fromisoformat(last_iso)
    return (now - last_time) >= datetime.timedelta(minutes=30)


def perform_scheduled_action(actions, state, now):
    desired = state.get("next_action", "post")
    note = f"No {desired} action available; will try again next cycle."
    performed_action = None

    for action in actions:
        if action.get("action") != desired:
            continue

        last_key = "last_post" if desired == "post" else "last_comment"
        if not action_due(state.get(last_key), now):
            last_time = datetime.datetime.fromisoformat(state[last_key])
            remaining = last_time + datetime.timedelta(minutes=30) - now
            minutes = max(0, int(remaining.total_seconds() // 60) + (1 if remaining.total_seconds() % 60 > 0 else 0))
            note = f"Skipped scheduled {desired}; cooldown still {minutes} minute(s)."
            return note, None

        response = None
        if desired == "post":
            response = api_post("/posts", {"title": action.get("title"), "content": action.get("content"), "submolt": "general"})
        else:
            response = api_post(f"/posts/{action.get('post_id')}/comments", {"content": action.get("content")})

        if response is not None:
            state[last_key] = now.isoformat()
            state["next_action"] = "comment" if desired == "post" else "post"
            note = f"Executed scheduled {desired}."
            performed_action = action
        else:
            note = f"Scheduled {desired} action failed; will retry next cycle."
        return note, performed_action

    return note, None


def main():
    os.makedirs(f"{WORKSPACE_DIR}/memory", exist_ok=True)

    # 1. Fetch API data
    home_data = api_get("/home")
    feed_data = api_get("/feed")
    home_prompt = {}
    if isinstance(home_data, dict):
        home_prompt["your_account"] = home_data.get("your_account")
        activity = home_data.get("activity_on_your_posts")
        if isinstance(activity, list):
            home_prompt["activity_on_your_posts"] = [
                {
                    "post_title": entry.get("post_title"),
                    "submolt_name": entry.get("submolt_name"),
                    "new_notification_count": entry.get("new_notification_count")
                }
                for entry in activity[:3]
            ]
    else:
        home_prompt = home_data
    if isinstance(feed_data, dict):
        posts = feed_data.get("posts")
        if isinstance(posts, list):
            sanitized_posts = []
            for post in posts[:3]:
                author = post.get("author") if isinstance(post.get("author"), dict) else None
                sanitized_posts.append({
                    "id": post.get("id"),
                    "title": post.get("title"),
                    "submolt_name": post.get("submolt_name"),
                    "author_name": author.get("name") if author else post.get("author_name"),
                    "upvotes": post.get("upvotes"),
                    "comment_count": post.get("comment_count")
                })
            feed_data = {"success": feed_data.get("success"), "posts": sanitized_posts}
        else:
            feed_data = {"success": feed_data.get("success"), "posts": []}
    else:
        feed_data = {"success": False, "posts": []}
    prompt_home_data = home_prompt if home_prompt else home_data
    prompt_feed_data = feed_data
    
    # 2. Build prompt
    prompt = f"""You are Sam, an AI entrepreneur agent on Moltbook (a social network for AI agents).

YOUR IDENTITY (from MEMORY):
{get_memory_context()}

YOUR TASK - Execute a full Moltbook heartbeat cycle:
1. Review the current state of your Moltbook account (Home data).
2. Review the latest feed posts (Feed data).
3. Decide what actions to take. You can post, comment on posts, and follow users.

HOME DATA:
{json.dumps(prompt_home_data, indent=2) if prompt_home_data else "Failed to load"}

FEED DATA:
{json.dumps(prompt_feed_data, indent=2) if prompt_feed_data else "Failed to load"}

POSTING RULES:
- Posts must be in ENGLISH
- Be bold, witty, entrepreneurial (Sam persona)
- Title should be engaging (questions work well)
- Quality over quantity

Return a structured JSON document enclosed in ```json ... ``` exactly like this:
{{
  "report": {{
    "STATUS": "OK",
    "ACTIONS": "e.g., [posts: 1, comments: 2, follows: 1]",
    "METRICS": "e.g., [followers: 0]",
    "POSTED": "title of post if you posted, or 'none'",
    "NOTABLE": "interesting events, DMs, discoveries",
    "NEEDS_TTT": "anything requiring human approval, or 'none'",
    "NEXT_PRIORITY": "what to focus on next cycle"
  }},
  "api_actions": [
    {{ "action": "post", "title": "...", "content": "..." }},
    {{ "action": "comment", "post_id": "...", "content": "..." }},
    {{ "action": "follow", "agent_name": "..." }}
  ]
}}
"""
    # 3. Call Gemini
    try:
        gemini_cmd = "/home/ttt05/.npm-global/bin/gemini"
        
        result = subprocess.run([gemini_cmd, "-y", "-m", "gemini-2.5-flash-lite", "-p", prompt], capture_output=True, text=True, check=True)
        output = result.stdout
    except subprocess.CalledProcessError:
        with open(REPORT_FILE, "a") as f:
            f.write(f"--- Cycle {datetime.datetime.now().isoformat()} ---\nSTATUS: ERROR\nDETAIL: gemini execution failed\n\n")
        return

    # 4. Parse JSON
    match = re.search(r"```json\s*(.*?)\s*```", output, re.DOTALL)
    if not match:
        match = re.search(r"({.*})", output, re.DOTALL)
        
    try:
        response_data = json.loads(match.group(1)) if match else json.loads(output)
        report = response_data.get("report", {})
        actions = response_data.get("api_actions", [])
    except Exception:
        with open(REPORT_FILE, "a") as f:
             f.write(f"--- Cycle {datetime.datetime.now().isoformat()} ---\nSTATUS: OK (unstructured)\n{output[:500]}\n\n")
        return

    state = load_state()
    current_time = datetime.datetime.now()
    schedule_note, scheduled_action = perform_scheduled_action(actions, state, current_time)

    remaining_actions = [action for action in actions if action is not scheduled_action]

    # 5. Execute other API Actions
    for action in remaining_actions:
        act = action.get("action")
        if act in ("post", "comment"):
            continue
        if act == "follow":
            api_post(f"/agents/{action.get('agent_name')}/follow")

    save_state(state)

    # 6. Save Report
    with open(REPORT_FILE, "a") as f:
        f.write(f"--- Cycle {datetime.datetime.now().isoformat()} ---\n")
        f.write(f"STATUS: {report.get('STATUS', 'OK')}\n")
        f.write(f"ACTIONS: {report.get('ACTIONS', '[]')}\n")
        f.write(f"METRICS: {report.get('METRICS', 'N/A')}\n")
        f.write(f"POSTED: {report.get('POSTED', 'none')}\n")
        f.write(f"NOTABLE: {report.get('NOTABLE', 'none')}\n")
        f.write(f"NEEDS_TTT: {report.get('NEEDS_TTT', 'none')}\n")
        f.write(f"NEXT_PRIORITY: {report.get('NEXT_PRIORITY', 'none')}\n")
        f.write(f"SCHEDULE_NOTE: {schedule_note}\n\n")

if __name__ == "__main__":
    main()
