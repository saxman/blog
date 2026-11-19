---
title: "Scaling Managed Agents: Decoupling the brain from the hands"
date: 2026-11-19
published: 2026-04-07
tags:
  - engineering/ai/harnesses
type: article
source: https://www.anthropic.com/research/managed-agents
author:
  - Anthropic
summary_by: ai
draft: false
---
[Scaling Managed Agents with stable interfaces](https://www.anthropic.com/research/managed-agents)

This Anthropic engineering article describes the architecture of Claude Managed Agents, a hosted service for running long-horizon agents. The system separates the session log, the harness, and the sandbox behind stable interfaces, much as operating systems abstract hardware. This separation lets each component fail, scale, or be replaced independently. The article reports gains in reliability, security (credentials are kept out of sandboxes), and latency, with p50 time-to-first-token dropping about 60%.

