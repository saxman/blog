---
title: "Building agents: When to fold subagents into your main agent loop"
date: 2026-11-17
tags:
  - engineering/ai/research
type: link
source: https://claude.com/resources/articles/building-agents-when-to-fold-subagents-into-your-main-agent-loop
summary_by: ai
imported_from: "obsidian-vault/Resources/AI/Engineering.md"
draft: true
---

[Building agents: When to fold subagents into your main agent loop](https://claude.com/resources/articles/building-agents-when-to-fold-subagents-into-your-main-agent-loop)

This Claude Platform article from Anthropic's Applied AI team gives guidance on when enterprises should fold subagents (routers, planners, domain specialists) into a single main agent loop that uses skills and tool search to load context and tools only when needed. It describes common failure modes in large organizations: architectures that mirror the org chart, lossy context handoffs, subagent sprawl, "Frankenprompts," overly localized evals, and added latency. It argues that shared context, progressive disclosure, and more capable models often make a single agent better, cheaper, and faster. It also lists cases where subagents still fit, such as context bloat, parallel work with fresh context windows, and tool-selection or instruction conflicts. The article lays out a staged migration: build task-completion evals, merge tightly coupled specialists, call the remaining subagents as tools, then convert them into skills and MCP tools while checking which eval tasks flip. Under this model, a small central team owns the system prompt and end-to-end quality, while individual teams own skills, tools, and knowledge bases. The article closes by pointing to a migration kit and Claude API skills (build-eval, prompt-audit, hillclimb, cost-optimize) that support the process.
