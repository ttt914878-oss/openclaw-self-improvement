Loaded cached credentials.
Server 'chrome-devtools' supports tool updates. Listening for changes...
Attempt 1 failed: You have exhausted your capacity on this model. Your quota will reset after 1s.. Retrying after 1099.246867ms...
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
      date: 'Thu, 19 Feb 2026 09:00:18 GMT',
      server: 'ESF',
      'server-timing': 'gfet4t7; dur=647',
      vary: 'Origin, X-Origin, Referer',
      'x-cloudaicompanion-trace-id': '27a8e5dd4b79e017',
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
      date: 'Thu, 19 Feb 2026 09:00:24 GMT',
      server: 'ESF',
      'server-timing': 'gfet4t7; dur=652',
      vary: 'Origin, X-Origin, Referer',
      'x-cloudaicompanion-trace-id': '8e22a05e2c26c17b',
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
This research summarizes SRE-style incident response frameworks for AI agent workflows, providing a concise one-page runbook template that maps common failure patterns to recovery actions.

### 1. Executive Summary
*   **Operational Shift:** AI incident response requires moving beyond "uptime" to "integrity and alignment" metrics. Traditional SRE focuses on availability; AI SRE focuses on **output drift, tool-use loops, and semantic safety.**
*   **Automated Triage:** Effective recovery runbooks for AI agents prioritize **Human-in-the-Loop (HITL) triggers** over full automation when failure patterns involve non-deterministic model behavior or "black-box" reasoning.
*   **Loop Prevention:** A critical recovery pattern for agents is the **"Context Reset" or "State Rollback,"** which terminates runaway iterative loops by clearing agent memory and reverting to the last known "clean" prompt state.

### 2. SRE-Style AI Agent Incident Runbook (One-Page Format)

| **Component** | **Details** |
| :--- | :--- |
| **Incident ID** | `[YYYY-MM-DD-AGENT-TYPE]` |
| **Severity** | **P0:** Business Block (Total Failure) \| **P1:** Integrity Risk (Hallucination) \| **P2:** Degradation (Latency) |
| **Primary Responder** | Agent Architect / SRE Lead |

#### Failure Pattern to Recovery Matrix

| **Failure Pattern** | **Primary Signal (SLI)** | **Immediate Recovery Action (Runbook)** |
| :--- | :--- | :--- |
| **Infinite Tool Loop** | High token count per turn; repeat tool calls. | **Kill Process:** Terminate agent run; clear short-term memory; restart with depth-limit guardrails. |
| **Hallucination / Drift** | Log-probability drops; semantic drift detection. | **Throttle & Audit:** Divert agent traffic to "Safe-Mode" (narrower prompt); initiate manual output review. |
| **Tool/API Exhaustion** | 429 Errors; tool timeout spikes. | **Circuit Breaker:** Toggle "Off-Tool" mode; switch agent to "Knowledge-Only" fallback or cached responses. |
| **Prompt Injection** | Forbidden keyword triggers; system prompt leaks. | **Containment:** Revoke agent API credentials immediately; wipe session state; update system prompt filters. |
| **State Corruption** | Inconsistent JSON outputs; parsing errors. | **Rollback:** Revert agent instructions/schema to previous stable version; re-run failed task with `temperature=0`. |

#### Standard Response Protocol
1.  **Detection:** Alerting triggers on **Token Burn Rate** or **Semantic Similarity** deviation.
2.  **Containment:** Engage **Circuit Breaker** (disconnect agent from sensitive toolsets).
3.  **Remediation:** Apply **Prompt Patch** (hotfix system instructions) or **Model Version Switch**.
4.  **Verification:** Run **Golden Dataset Tests** to ensure the specific failure mode is no longer reproducible.

---

### 3. Action Recommendations
1.  **Implement Semantic Guardrails:** Deploy tools like *Guardrails AI* or *Nemo Guardrails* to detect failures (hallucination/loops) in real-time before they trigger high-severity incidents.
2.  **Define Agent SLOs:** Establish Service Level Objectives specifically for **Reasoning Latency** and **Tool Success Rate**, rather than just API uptime.
3.  **Establish a "Safe State" Fallback:** Create a minimalist, low-temperature prompt configuration that agents automatically revert to when "Circuit Breakers" are tripped.

### 4. Source URLs
1.  [PagerDuty: AI Incident Response Guide](https://www.pagerduty.com/blog/ai-incident-response-best-practices/)
2.  [Google: SRE for Machine Learning Systems](https://sre.google/workbook/machine-learning/)
3.  [Harness.io: SRE Principles for AI](https://www.harness.io/blog/sre-for-ai-and-ml)
4.  [VerifyWise: AI Incident Management Framework](https://verifywise.ai/ai-incident-response-plan/)
5.  [Langfuse: Observability and Incident Triage for LLMs](https://langfuse.com/docs/observability)
6.  [Guardrails AI: Automated Reliability Patterns](https://www.guardrailsai.com/docs)
