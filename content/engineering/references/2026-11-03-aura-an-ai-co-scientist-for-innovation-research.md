---
title: "AURA: An AI Co-Scientist for Innovation Research"
date: 2026-11-03
tags:
  - engineering/ai/for-science
type: project
source: https://medium.com/99p-labs/aura-an-ai-co-scientist-for-innovation-research-ea2f095b1d15
summary_by: ai
imported_from: "obsidian-vault/Resources/AI/For Science.md"
draft: true
---

[AURA: An AI Co-Scientist for Innovation Research](https://medium.com/99p-labs/aura-an-ai-co-scientist-for-innovation-research-ea2f095b1d15)

AURA is an AI co-scientist built by a student team mentored by 99P Labs. It generates ranked, testable innovation hypotheses ("bets") for mobility research domains like eVTOL and robotaxi, rather than literature reviews. It adapts Google DeepMind's multi-agent co-scientist architecture and Andrej Karpathy's autoresearch "ratchet" loop. Its LangGraph pipeline (clarification, query generation, search) feeds a loop of agents for generation, reflection, tournament ranking, evolution and meta-review, which ends in a domain-specific Innovation Brief. A DomainProfile layer injects domain-aware scoring weights, seed questions and source strategies into every agent. Bets are scored on seven axes and ranked with LLM-judged Elo tournaments, and the results are shown in a ReactFlow canvas and Recharts dashboards. The write-up covers an eVTOL medical-response demo and lessons learned: making the UI weight sliders actually change rankings by squaring scores and using a margin-based K-factor, and migrating from five to seven axes. It also admits known gaps, including a stale-Elo measurement bug and an unwired analytics table. Planned next steps are fixing those gaps, adding non-mobility domains, and comparing bets across domains.
