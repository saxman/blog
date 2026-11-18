---
title: "You don’t need long context"
date: 2026-11-04
tags:
  - engineering/ai/research
type: paper
source: https://arxiv.org/html/2611.05306v1
summary_by: ai
imported_from: "obsidian-vault/Resources/AI/Engineering.md"
draft: true
---

[You don’t need long context](https://arxiv.org/html/2611.05306v1)

"You don't need long context" is an arXiv research paper by NVIDIA researchers. It argues that long-context language models are largely unnecessary. The authors note that later tokens cost more to generate: serving at 256K versus 16K context costs 3.6–7x more per token on open-weight models. They test three context-management regimes on two frontier models, Claude Opus 4.5 and GPT 5.6 Sol: full-history accumulation, end-of-conversation compaction (EoCC), and single-action compaction (SAC). On six long-horizon benchmarks (SWE-bench, Terminal-Bench, FRAMES, τ²-bench, BFCLv3), EoCC keeps accuracy roughly on par while cutting estimated costs 2–9x. On seven long-input benchmarks (LongBench v2, LOONG, AA-LCR, NIAH, RULER, Counting-Stars, BABILong), selective file reading via Bash tools plus compaction matches or substantially improves accuracy, by up to +40 points, at far lower cost. SAC, which takes just one action per context, nearly preserves baseline accuracy on SWE-bench Verified and Terminal-Bench. Building on this, the paper proposes Semantic State Space Models (SSSMs): models post-trained to carry a compact natural-language state between turns instead of a growing history. Appendices cover compaction design, the cost model, open-weight results, and the prompts used.
