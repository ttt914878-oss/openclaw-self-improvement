Loaded cached credentials.
Server 'chrome-devtools' supports tool updates. Listening for changes...
I will search for practical methods to reduce token costs in AI agent workflows, focusing on techniques like model routing, context management, and prompt optimization.
I will conduct a quick targeted search on token-efficient data formats for LLMs and built-in cost-saving features in popular agent frameworks to provide more specific action recommendations.
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
      date: 'Thu, 19 Feb 2026 12:58:28 GMT',
      server: 'ESF',
      'server-timing': 'gfet4t7; dur=66549',
      vary: 'Origin, X-Origin, Referer',
      'x-cloudaicompanion-trace-id': 'bff665ff94486fe6',
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
To reduce token costs per completed task in AI agent workflows, implement a multi-layered approach that optimizes prompts, leverages caching, and strategically selects models.

### 1. Research Summary
*   **Prompt & Context Optimization:** Use token-efficient data formats (e.g., YAML or TSV over JSON) to reduce overhead by 30-50%. Implement "selective memory" by summarizing older context and using RAG to inject only high-relevance chunks instead of full documents.
*   **Model Tiering & Cascading:** Route simple tasks (extraction, classification) to low-cost models (GPT-4o-mini, Haiku) and only escalate to "frontier" models for complex reasoning. This can reduce total costs by up to 90% in large-scale workflows.
*   **Caching & Structural Efficiency:** Leverage **Prompt Caching** (available in OpenAI, Anthropic, Gemini) for static system instructions. Use libraries like *LLMLingua* for context compression or *TOON* for repetitive structured data to further minimize input tokens.

### 2. Source URLs
*   [Towards AI: Reducing LLM Token Costs in Multi-Agent Systems](https://towardsai.net/p/l/reducing-llm-token-costs-in-multi-agent-systems)
*   [10Clouds: How to Reduce LLM Costs - Practical Strategies](https://10clouds.com/blog/ai/how-to-reduce-llm-costs/)
*   [RunVecta: Comprehensive Guide to Prompt Caching and Token Savings](https://runvecta.com/blog/prompt-caching-guide)
*   [LangChain Documentation: Cost Management and Token Counting](https://python.langchain.com/docs/modules/model_io/llms/token_usage_tracking)
*   [Microsoft AutoGen: Inference Optimization for Multi-Agent Workflows](https://microsoft.github.io/autogen/docs/Use-Cases/agent_chat/)
*   [LLMLingua: Prompt Compression for Efficient LLM Inference](https://llmlingua.com/)

### 3. Action Recommendations
*   **Implement Prompt Caching Immediately:** Ensure your system prompts and tool definitions are placed at the beginning of the prompt to take advantage of provider-level caching discounts (often 50-90% off for cached tokens).
*   **Switch Formats for Tools:** If your agent processes large JSON payloads, convert them to **YAML** or **TSV** before passing them to the LLM. This removes the "token tax" of brackets and quotes.
*   **Deploy a "Router" Agent:** Create a lightweight classifier (using a small model) that determines task difficulty. For tasks like "summarize this short text," bypass the high-cost model entirely.
*   **Use Checkpoint Workflows:** For multi-step agent tasks, store intermediate results in a database. If a late-stage step fails, resume from the last successful checkpoint instead of rerunning the entire sequence (saving all prior tokens).
*   **Context Pruning:** Before every LLM call, programmatically remove redundant parts of the conversation history or use an LLM-based summarizer to condense the "memory" into a fixed-length state.
