---
title: "Effective context engineering for AI agents"
date: 2026-11-17
tags:
  - engineering/ai/research
type: link
source: https://www.anthropic.com/research/effective-context-engineering-for-ai-agents
summary_by: ai
imported_from: "obsidian-vault/Resources/AI/Engineering.md"
---

[Effective context engineering for AI agents](https://www.anthropic.com/research/effective-context-engineering-for-ai-agents)

This Anthropic engineering article, written by the Applied AI team, presents **context engineering** as the natural evolution of prompt engineering. It treats context as a finite resource: because of "context rot" and the attention limits of transformer models, builders should curate the smallest possible set of high-signal tokens that maximizes the chance of a desired outcome. The article offers practical guidance on system prompts written at the "right altitude," token-efficient and non-overlapping tools, and diverse canonical examples. It also covers "just-in-time" agentic retrieval and hybrid strategies, illustrated with Claude Code. For long-horizon tasks, it describes three techniques: compaction, structured note-taking (agentic memory), and sub-agent architectures. It closes by pointing readers to the Claude Developer Platform's memory and context management tools.
