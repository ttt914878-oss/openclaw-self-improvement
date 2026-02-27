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

def api_get(endpoint):
    req = urllib.request.Request(f"{BASE_URL}{endpoint}", headers={"Authorization": f"Bearer {API_KEY}"})
    try:
        response = urllib.request.urlopen(req)
        return json.loads(response.read())
    except Exception as e:
        print(f"Error GET {endpoint}: {e}")
        return None

def api_post(endpoint, data=None):
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

def main():
    os.makedirs(f"{WORKSPACE_DIR}/memory", exist_ok=True)
    
    # 1. Fetch API data
    home_data = api_get("/home")
    feed_data = api_get("/feed")
    
    # 2. Build prompt
    prompt = f"""You are Sam, an AI entrepreneur agent on Moltbook (a social network for AI agents).

YOUR IDENTITY (from MEMORY):
{get_memory_context()}

YOUR TASK - Execute a full Moltbook heartbeat cycle:
1. Review the current state of your Moltbook account (Home data).
2. Review the latest feed posts (Feed data).
3. Decide what actions to take. You can post, comment on posts, and follow users.

HOME DATA:
{json.dumps(home_data, indent=2) if home_data else "Failed to load"}

FEED DATA:
{json.dumps(feed_data, indent=2) if feed_data else "Failed to load"}

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
    except subprocess.CalledProcessError as e:
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
    except Exception as e:
        with open(REPORT_FILE, "a") as f:
             f.write(f"--- Cycle {datetime.datetime.now().isoformat()} ---\nSTATUS: OK (unstructured)\n{output[:500]}\n\n")
        return

    # 5. Execute API Actions
    for action in actions:
        act = action.get("action")
        if act == "post":
            api_post("/posts", {"title": action.get("title"), "content": action.get("content"), "submolt": "general"})
        elif act == "comment":
            api_post(f"/posts/{action.get('post_id')}/comments", {"content": action.get("content")})
        elif act == "follow":
            api_post(f"/agents/{action.get('agent_name')}/follow")

    # 6. Save Report
    with open(REPORT_FILE, "a") as f:
        f.write(f"--- Cycle {datetime.datetime.now().isoformat()} ---\n")
        f.write(f"STATUS: {report.get('STATUS', 'OK')}\n")
        f.write(f"ACTIONS: {report.get('ACTIONS', '[]')}\n")
        f.write(f"METRICS: {report.get('METRICS', 'N/A')}\n")
        f.write(f"POSTED: {report.get('POSTED', 'none')}\n")
        f.write(f"NOTABLE: {report.get('NOTABLE', 'none')}\n")
        f.write(f"NEEDS_TTT: {report.get('NEEDS_TTT', 'none')}\n")
        f.write(f"NEXT_PRIORITY: {report.get('NEXT_PRIORITY', 'none')}\n\n")

if __name__ == "__main__":
    main()
