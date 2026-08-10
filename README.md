# X



A modern digital agency platform with FastAPI backend and React frontend, featuring portfolio management, service listings, and more.

## Table of Contents

- [Overview](#overview)
- [Quick Start](#quick-start)
- [Model Routing](#model-routing)
- [Project Layout](#project-layout)
- [Development](#development)
- [Related Repositories](#related-repositories)

## Overview

A modern digital agency platform with FastAPI backend and React frontend, featuring portfolio management, service listings, and more.

| | |
|---|---|
| **Stack** | — |
| **Frameworks** | — |
| **Tests** | none detected |
| **Commits** | 2 |
| **Last activity** | 2026-08-10 |
| **Visibility** | public |

## Quick Start

### Install

```bash
# No dependency manifest detected — see source layout below.
```

### Run

```bash
# Entry point not auto-detected; inspect the layout below.
```

## Model Routing

Agent work in this repo routes through Azure AI Foundry. See [`AGENTS.md`](./AGENTS.md)
for the full contract.

| Purpose | Deployment | Endpoint |
|---|---|---|
| Default / general | `gpt-5.6-sol` | `/openai/v1/chat/completions` |
| Deep reasoning | `claude-opus-5` | `/openai/v1/responses` **only** |
| Embeddings | `text-embedding-3-small` | `/openai/v1/embeddings` |

```bash
export AZURE_FOUNDRY_API_KEY=...        # never commit this
export AZURE_FOUNDRY_BASE_URL=https://<resource>.openai.azure.com/openai/v1
```

> **Gotcha:** Claude deployments on Azure return `404 api_not_supported` on
> `/chat/completions`. They answer **only** via the Responses API.

## Project Layout

```
AGENTS.md
BUILD_AND_DEPLOY_SUMMARY.md
CONTRIBUTING.md
DEPLOYMENT.md
LICENSE
Makefile
QUICKSTART.md
README.md
ai-tools/
api-reference/
backend/
build.sh
deploy.sh
development.mdx
```

## Development

```bash
# lint / format before committing
# no linter configured

# run the CI check locally
gh workflow run hermes-azure-check.yml
```

Secrets live in environment variables and CI secrets — never in tracked files.

## Related Repositories

Part of a 84-repository workspace sharing one agentic contract:

- **[agentic-harness](https://github.com/sahiixx/agentic-harness)** — patterns, contracts, and reference implementations
- `AGENTS.md` in every repo pins identical model routing

---

<sub>README maintained by the agentic harness · last regenerated 2026-08-10</sub>
