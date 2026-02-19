Loaded cached credentials.
Server 'chrome-devtools' supports tool updates. Listening for changes...
I will start by investigating the existing documentation in the workspace, specifically focusing on files related to failure recovery and workflow standardization to understand the current patterns and playbooks.
I'll read the existing failure recovery playbook and context operations standard to establish a baseline for OpenClaw's current workflow standardization.
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
      date: 'Thu, 19 Feb 2026 08:54:31 GMT',
      server: 'ESF',
      'server-timing': 'gfet4t7; dur=2402',
      vary: 'Origin, X-Origin, Referer',
      'x-cloudaicompanion-trace-id': '2b835b3702c062db',
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
Attempt 2 failed with status 429. Retrying with backoff... GaxiosError: [{
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
      date: 'Thu, 19 Feb 2026 08:54:35 GMT',
      server: 'ESF',
      'server-timing': 'gfet4t7; dur=739',
      vary: 'Origin, X-Origin, Referer',
      'x-cloudaicompanion-trace-id': '2099b94e32162e63',
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
I'll re-read the failure recovery playbook to ensure I have its full content for analysis.
I'll examine the core configuration files—IDENTITY.md, SOUL.md, MEMORY.md, and TOOLS.md—to identify any defined workflow patterns or recovery procedures.
I'll examine AGENTS.md and USER.md for workflow clues, while using grep on the failure recovery playbook to extract key information despite the potential rate limits.
I'll conduct a workspace-wide search for "failure" to locate the specific files containing the standardization checklist and recovery playbooks.
Attempt 1 failed: You have exhausted your capacity on this model. Your quota will reset after 1s.. Retrying after 1053.482813ms...
I'll examine the local troubleshooting report, as it likely contains the information I'm seeking regarding failure patterns and recovery playbooks.
Attempt 1 failed: You have exhausted your capacity on this model. Your quota will reset after 1s.. Retrying after 1793.181999ms...
I'll examine the documentation index report to identify additional failure patterns and recovery procedures that may be documented there.
I'll use google_web_search to find the contents of the OpenClaw llms.txt and attempt to read the failure recovery playbook again, using offset and limit to circumvent any potential reading issues.
I'll read the final lines of the failure recovery playbook to determine if a structured playbook was eventually generated despite the initial errors.
Based on the OpenClaw documentation and internal workspace logs, here is the standardized workflow checklist and recovery playbook for failure patterns.

### 1) Summary: OpenClaw Workflow & Recovery Standard
*   **Security-First Execution**: Standardized workflows prioritize **isolation** (Docker/VENV) and **least privilege** (non-admin users) to minimize the blast radius of failures or prompt injections.
*   **Diagnostic Command Ladder**: For all automation failures, a strict "Troubleshooting Ladder" is followed: `status` → `gateway status` → `logs` → `doctor` to distinguish between execution failures and delivery/relay flakiness.
*   **Proactive Credential & Skill Gating**: All external skills are treated as untrusted and governed by `exec-approvals.json`, while credential leaks are prevented via mandatory `.gitignore` patterns and automated post-commit hooks.

### 2) Source URLs
*   [OpenClaw Troubleshooting Guide (Official)](https://docs.openclaw.ai/automation/troubleshooting.md)
*   [OpenClaw Security & Audit Standards](https://docs.openclaw.ai/security/audit.md)
*   [OpenClaw LLM-Friendly Documentation Index](https://docs.openclaw.ai/llms.txt)
*   [Handling Prompt Injection & Untrusted Input](https://docs.openclaw.ai/security/prompt-injection.md)
*   [OpenClaw GitHub Security Advisories (Log Poisoning Fix)](https://github.com/openclaw/openclaw/security/advisories)
*   [Production Baseline & Observability Guide](https://christopherfinlan.com/openclaw/production-baseline)

### 3) Action Recommendations
*   **Implement the "Troubleshooting Ladder Rule"**: Standardize all agent recovery procedures to follow the `status` → `gateway status` → `logs` → `doctor` sequence to ensure consistent diagnostic data.
*   **Enforce Skill Allowlists**: Transition from open skill execution to a strict `plugins.allow` or `exec-approvals.json` model to mitigate supply chain risks from third-party "ClawHub" skills.
*   **Upgrade to v2026.2.13+**: Immediately update to the latest version to patch the "Log Poisoning" vulnerability where malicious headers could manipulate agent troubleshooting logic.
*   **Deploy Read-Only Summarizer Agents**: For workflows involving web searches or untrusted DMs, use a tool-disabled "Reader" agent to pre-process content before passing it to the main agent to prevent direct prompt injection.
