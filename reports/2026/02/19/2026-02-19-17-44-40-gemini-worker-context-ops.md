Loaded cached credentials.
Server 'chrome-devtools' supports tool updates. Listening for changes...
I will search the local codebase for "OpenClaw" and related optimization terms to understand the current context and internal standards.
I will read the key internal report on context optimization and then perform a web search to identify additional external best practices and practical tactics for OpenClaw memory hygiene and token efficiency.
Attempt 1 failed with status 429. Retrying with backoff... GaxiosError: [{
  "error": {
    "code": 429,
    "message": "No capacity available for model gemini-3-flash-preview on the server",
    "errors": [
      {
        "message": "No capacity available for model gemini-3-flash-preview on the server",
        "domain": "global",
        "reason": "rateLimitExceeded"
      }
    ],
    "status": "RESOURCE_EXHAUSTED",
    "details": [
      {
        "@type": "type.googleapis.com/google.rpc.ErrorInfo",
        "reason": "MODEL_CAPACITY_EXHAUSTED",
        "domain": "cloudcode-pa.googleapis.com",
        "metadata": {
          "model": "gemini-3-flash-preview"
        }
      }
    ]
  }
}
]
    at Gaxios._request (/home/ttt05/.npm-global/lib/node_modules/@google/gemini-cli/node_modules/gaxios/build/src/gaxios.js:142:23)
    at process.processTicksAndRejections (node:internal/process/task_queues:105:5)
    at async OAuth2Client.requestAsync (/home/ttt05/.npm-global/lib/node_modules/@google/gemini-cli/node_modules/google-auth-library/build/src/auth/oauth2client.js:429:18)
    at async CodeAssistServer.requestStreamingPost (file:///home/ttt05/.npm-global/lib/node_modules/@google/gemini-cli/node_modules/@google/gemini-cli-core/dist/src/code_assist/server.js:173:21)
    at async CodeAssistServer.generateContentStream (file:///home/ttt05/.npm-global/lib/node_modules/@google/gemini-cli/node_modules/@google/gemini-cli-core/dist/src/code_assist/server.js:29:27)
    at async file:///home/ttt05/.npm-global/lib/node_modules/@google/gemini-cli/node_modules/@google/gemini-cli-core/dist/src/core/loggingContentGenerator.js:143:26
    at async retryWithBackoff (file:///home/ttt05/.npm-global/lib/node_modules/@google/gemini-cli/node_modules/@google/gemini-cli-core/dist/src/utils/retry.js:128:28)
    at async GeminiChat.makeApiCallAndProcessStream (file:///home/ttt05/.npm-global/lib/node_modules/@google/gemini-cli/node_modules/@google/gemini-cli-core/dist/src/core/geminiChat.js:444:32)
    at async GeminiChat.streamWithRetries (file:///home/ttt05/.npm-global/lib/node_modules/@google/gemini-cli/node_modules/@google/gemini-cli-core/dist/src/core/geminiChat.js:265:40)
    at async Turn.run (file:///home/ttt05/.npm-global/lib/node_modules/@google/gemini-cli/node_modules/@google/gemini-cli-core/dist/src/core/turn.js:67:30) {
  config: {
    url: 'https://cloudcode-pa.googleapis.com/v1internal:streamGenerateContent?alt=sse',
    method: 'POST',
    params: { alt: 'sse' },
    headers: {
      'Content-Type': 'application/json',
      'User-Agent': 'GeminiCLI/0.29.2/gemini-3-pro-preview (linux; x64) google-api-nodejs-client/9.15.1',
      Authorization: '<<REDACTED> - See `errorRedactor` option in `gaxios` for configuration>.',
      'x-goog-api-client': 'gl-node/22.22.0'
    },
    responseType: 'stream',
    body: '<<REDACTED> - See `errorRedactor` option in `gaxios` for configuration>.',
    signal: AbortSignal { aborted: false },
    paramsSerializer: [Function: paramsSerializer],
    validateStatus: [Function: validateStatus],
    errorRedactor: [Function: defaultErrorRedactor]
  },
  response: {
    config: {
      url: 'https://cloudcode-pa.googleapis.com/v1internal:streamGenerateContent?alt=sse',
      method: 'POST',
      params: [Object],
      headers: [Object],
      responseType: 'stream',
      body: '<<REDACTED> - See `errorRedactor` option in `gaxios` for configuration>.',
      signal: [AbortSignal],
      paramsSerializer: [Function: paramsSerializer],
      validateStatus: [Function: validateStatus],
      errorRedactor: [Function: defaultErrorRedactor]
    },
    data: '[{\n' +
      '  "error": {\n' +
      '    "code": 429,\n' +
      '    "message": "No capacity available for model gemini-3-flash-preview on the server",\n' +
      '    "errors": [\n' +
      '      {\n' +
      '        "message": "No capacity available for model gemini-3-flash-preview on the server",\n' +
      '        "domain": "global",\n' +
      '        "reason": "rateLimitExceeded"\n' +
      '      }\n' +
      '    ],\n' +
      '    "status": "RESOURCE_EXHAUSTED",\n' +
      '    "details": [\n' +
      '      {\n' +
      '        "@type": "type.googleapis.com/google.rpc.ErrorInfo",\n' +
      '        "reason": "MODEL_CAPACITY_EXHAUSTED",\n' +
      '        "domain": "cloudcode-pa.googleapis.com",\n' +
      '        "metadata": {\n' +
      '          "model": "gemini-3-flash-preview"\n' +
      '        }\n' +
      '      }\n' +
      '    ]\n' +
      '  }\n' +
      '}\n' +
      ']',
    headers: {
      'alt-svc': 'h3=":443"; ma=2592000,h3-29=":443"; ma=2592000',
      'content-length': '630',
      'content-type': 'application/json; charset=UTF-8',
      date: 'Thu, 19 Feb 2026 08:46:04 GMT',
      server: 'ESF',
      'server-timing': 'gfet4t7; dur=5655',
      vary: 'Origin, X-Origin, Referer',
      'x-cloudaicompanion-trace-id': '5e61c371c5b1da21',
      'x-content-type-options': 'nosniff',
      'x-frame-options': 'SAMEORIGIN',
      'x-xss-protection': '0'
    },
    status: 429,
    statusText: 'Too Many Requests',
    request: {
      responseURL: 'https://cloudcode-pa.googleapis.com/v1internal:streamGenerateContent?alt=sse'
    }
  },
  error: undefined,
  status: 429,
  [Symbol(gaxios-gaxios-error)]: '6.7.1'
}
I will perform a web search for "OpenClaw context optimization memory hygiene token efficiency" to find any additional community-driven or official tactics that can complement the existing internal knowledge.
Based on internal documentation and external research of the OpenClaw ecosystem, here are the practical tactics for context optimization, memory hygiene, and token efficiency.

### 1) 3-Bullet Summary
*   **Tiered Memory Architecture:** OpenClaw maintains efficiency by externalizing persistent data to Markdown files (`MEMORY.md`), using structured folder systems with root indexes to prevent "context drifting," and archiving older logs (e.g., every 7 days) to maintain a lean active window.
*   **Proactive Token Governance:** Efficiency is achieved through "Context Window Guards" (triggering alerts at 80% capacity), prompt caching for static schemas, and dynamic model routing—delegating low-complexity tasks to "mini" models while reserving premium reasoning for core logic.
*   **Automated Compaction & Snapshotting:** The system utilizes staged summarization (via the `/compact` command) and mandatory "pre-compaction memory flushes" to ensure key facts are preserved in long-term storage before conversation history is pruned or compressed.

### 2) Source URLs
*   [Official OpenClaw Documentation](https://docs.openclaw.ai/) - Core architectural overview.
*   [OpenClaw GitHub: Context Management](https://github.com/openclaw/openclaw/tree/main/docs) - Technical deep-dive on memory handling.
*   [OpenClaw Tools & Web Integration](https://docs.openclaw.ai/tools/web) - Best practices for API and tool efficiency.
*   [OpenClaw Troubleshooting Guide](https://docs.openclaw.ai/automation/troubleshooting.md) - Common context and memory failure patterns.
*   [OpenClaw Security Audit SOP](https://docs.openclaw.ai/security) - Guidelines for local disk and session hygiene.

### 3) Action Recommendations

**Context Optimization & Token Efficiency**
*   **Enable Prompt Caching:** Configure the agent to utilize LLM provider caching for static system prompts and tool schemas; this reduces overhead for every subsequent call in a session.
*   **Implement Dynamic Tool Loading:** Instead of sending all tool definitions, configure the agent to inject specific schemas only when a task-relevant skill is identified (Context Triangulation).
*   **Calibrate Reasoning Levels:** Use `/think low` or `minimal` for routine data processing and reserve `/think high` for complex debugging or architectural decisions to save on output tokens.
*   **Tiered Routing:** Route classification, extraction, and short-form summaries to cost-effective models (e.g., Llama 3.1 8B or GPT-4o-mini).

**Memory Hygiene & Practical Tactics**
*   **Structured Indexing:** Avoid a flat `MEMORY.md`. Use a structured directory (e.g., `memory/archive/`) and maintain a root `INDEX.md` that acts as a Table of Contents for the agent to quickly "look up" relevant history without loading full files.
*   **Pre-Compaction Flush:** Before running a session compaction, automate a "memory dump" where the agent extracts and appends crucial new facts to the persistent memory store.
*   **Git-Backed Config Hygiene:** Track the `~/.openclaw` directory in Git (excluding secrets) to allow for instant rollback of behavioral changes or system prompt regressions.
*   **Automated Health Checks:** Set up a cron job to run `openclaw security audit` and a 3-hour "Heartbeat" loop for daily brief updates to keep the agent's internal state synchronized with external progress.
