---
title: "Anthropic says one AI agent beats many subagents now that models can handle complexity alone"
date: 2026-11-04
tags:
  - engineering/ai/research
type: link
source: https://the-decoder.com/anthropic-says-one-ai-agent-beats-many-subagents-now-that-models-can-handle-complexity-alone/
summary_by: ai
imported_from: "obsidian-vault/Resources/AI/Engineering.md"
draft: true
---

[Anthropic says one AI agent beats many subagents now that models can handle complexity alone](https://the-decoder.com/anthropic-says-one-ai-agent-beats-many-subagents-now-that-models-can-handle-complexity-alone/)

This THE DECODER news article by Matthias Bastian (Oct 25, 2026) reports Anthropic's guidance that a single AI agent loading context on demand often outperforms multi-agent setups in quality, cost, and latency. In one comparison, the single-agent design ran about twice as fast. Drawing on enterprise deployments, Anthropic's Applied AI team says newer models can handle orchestration in one loop, and that many specialized sub-agents add latency, cost, and information loss at each handoff. It warns against designs that mirror the org chart ("Conway's Law" for agents) and against contradictory "Frankenprompts." Instead, it recommends packaging workflows as skills, loading tools on demand via tool search, querying knowledge bases only when needed, and having a small central team own the system prompt. Tool selection tends to degrade beyond 30 to 50 tool definitions, so skill libraries need dedicated owners. Sub-agents still make sense when context degradation is measurable, when tasks need to run in parallel, or when tool selection struggles. Anthropic has released a migration kit on GitHub and cautions against merging agents blindly. The article notes that the findings align with research from Vals and comments by OpenAI's Eric Provencher questioning agent swarms.
