---
title: "allenai/asta-autodiscovery"
date: 2026-11-03
tags:
  - engineering/ai/for-science
type: project
source: https://github.com/allenai/asta-autodiscovery
summary_by: ai
imported_from: "obsidian-vault/Resources/AI/For Science.md"
---

[allenai/asta-autodiscovery](https://github.com/allenai/asta-autodiscovery)

Data-driven scientific discovery via Bayesian surprise
Asta AutoDiscovery is an open-source (Apache-2.0) project from the Allen Institute for AI (allenai) for data-driven scientific discovery via Bayesian surprise, with a public deployment at autodiscovery.allen.ai. The repository is mostly Python and TypeScript and contains the discovery engine, an API, a web UI, and a standalone CLI that can be pip-installed to run AutoDiscovery against local datasets. Runs explore experiments as a search tree (MCTS) and produce a self-contained HTML report, built from the web UI's run view, that updates live as the run progresses. Users must explicitly choose an LLM provider and model (OpenAI, Anthropic, Azure OpenAI, Google Vertex AI, or GitHub Copilot via litellm), since version 2.0.0 removed the default model. The local stack runs via Docker (`make dev`) or as host processes (`make dev-host`), and Make targets cover testing, linting, and documentation.
