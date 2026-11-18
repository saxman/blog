---
title: "AgentBaton: Efficient Model Collaboration in Agentic Tasks"
date: 2026-11-04
tags:
  - engineering/ai/research
type: paper
source: https://arxiv.org/html/2610.35959v1
summary_by: ai
imported_from: "obsidian-vault/Resources/AI/Engineering.md"
draft: true
---

[AgentBaton: Efficient Model Collaboration in Agentic Tasks](https://arxiv.org/html/2610.35959v1)

AgentBaton is a research paper (arXiv, cs.MA) studying how expensive capable language models and cheaper efficient models can collaborate within a single long-horizon agentic task through one-time model handoffs. It evaluates handoff direction and context transfer (in-context history vs. an inspectable logfile) on Terminal-Bench 2.1 and DeepSWE v1.1. Efficient-to-capable handoffs generally underperform with little savings, while capable-to-efficient handoffs at the right stage largely preserve accuracy at much lower cost. Suitable handoff points typically follow three patterns: a substantive artifact exists, it has received real feedback, and the remaining work is localized. Based on these findings, the authors train AgentBaton, a lightweight Qwen 3.5 2B detector that monitors the capable model's progress after each turn and triggers a handoff online. Across 11 model pairs, AgentBaton cuts API costs by 65.9% on average, largely preserves accuracy (gains of up to 8.8 points), outperforms query-level and per-turn routing baselines such as MTRouter, and extends the accuracy–cost Pareto frontier across reasoning-effort settings.
