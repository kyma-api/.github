<div align="center">
  <img src="https://kymaapi.com/logo.png" alt="Kyma API" width="88" />

  <h1>Kyma API</h1>

  <p><strong>Kyma API gives your app one key for 100+ models across chat, embeddings, image, and audio, with published prices and measured uptime for every model.</strong></p>

  <p>
    <a href="https://kymaapi.com">Website</a> ·
    <a href="https://docs.kymaapi.com">Docs</a> ·
    <a href="https://kymaapi.com/pricing">Pricing</a> ·
    <a href="https://kymaapi.com/rankings">Rankings</a> ·
    <a href="https://kymaapi.com/status">Status</a>
  </p>
</div>

---

## Quickstart

Keep the OpenAI SDK you already use and change the base URL and key:

```python
from openai import OpenAI
client = OpenAI(base_url="https://kymaapi.com/v1", api_key="YOUR_KYMA_KEY")
print(client.chat.completions.create(model="qwen-3.6-plus", messages=[{"role": "user", "content": "Hello!"}]).choices[0].message.content)
```

With the Anthropic SDK, set `base_url` to `https://kymaapi.com` and call `messages.create` as usual. New accounts get $0.50 of free credit with no card required, and it can be spent on the free-tier models. More setup options are in the [docs quickstart](https://docs.kymaapi.com/quickstart).

## What you get

- One API key and one balance for every model.
- A published price for each model, listed on [Pricing](https://kymaapi.com/pricing).
- Uptime measured for each model, published on [Status](https://kymaapi.com/status).
- Public model rankings built from real customer usage, on [Rankings](https://kymaapi.com/rankings).
- If a model's route fails, requests fall back automatically.

## Use it from the tools you already have

Kyma API works with OpenClaw, Cursor, Claude Code, Cline, Roo Code, Continue, Aider, OpenCode, and other OpenAI- or Anthropic-compatible clients.

- **MCP:** connect any MCP client to `https://mcp.kymaapi.com/mcp`. You sign in with OAuth, and each connection has a spend cap you set.
- **Agent Skills:** run `npx skills add kyma-api/kyma-skills` to add four skills to your agent: connect a tool, pick a model by price and uptime, check spend and credits, and send a test completion.

## Repositories

| Repository | What it contains |
| --- | --- |
| [`kyma-mcp-plugin`](https://github.com/kyma-api/kyma-mcp-plugin) | The MCP server guide, the stdio bridge, and plugin manifests for coding agents. |
| [`kyma-skills`](https://github.com/kyma-api/kyma-skills) | Agent Skills: `connect-my-tool`, `pick-a-model`, `check-spend-and-credits`, `send-a-test-completion`. |
| [`openclaw-provider`](https://github.com/kyma-api/openclaw-provider) | The plugin that adds Kyma API models to OpenClaw. |

---

<p align="center"><sub>Questions: <a href="mailto:hello@kymaapi.com">hello@kymaapi.com</a></sub></p>
