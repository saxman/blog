---
title: "Nemotron 3.5 Super and Lightning: Open, Efficient Mixture-of-Experts Hybrid Mamba-Transformer Models for Agentic AI"
date: 2026-11-04
tags:
  - engineering/ai/models
type: paper
source: https://arxiv.org/html/2610.38095v1
summary_by: ai
imported_from: "obsidian-vault/Resources/AI/Models.md"
---

[Nemotron 3.5 Super and Lightning: Open, Efficient Mixture-of-Experts Hybrid Mamba-Transformer Models for Agentic AI](https://arxiv.org/html/2610.38095v1)

This is an NVIDIA technical report (arXiv, CC BY 4.0) introducing **Nemotron 3.5 Super** (120B total / 12B active, multimodal) and **Nemotron 3.5 Lightning** (30B / 3B active, text-only), two open Mixture-of-Experts hybrid Mamba-Transformer models built for reasoning, long-context understanding, and agentic workloads. Training includes MTP warmup for native speculative decoding and 1T-token distillation from larger Nemotron 3 teachers. Super also receives Indic continued pretraining (up to +9.82 pp on Indic benchmarks), 1M-token context extension, and agentic software-engineering mid-training. Super's post-training combines two-stage SFT that adds vision, RLVR/RLHF, specialized teachers, and multi-teacher on-policy distillation. It reaches 51.78% on SWE-bench Pro, surpassing Nemotron 3 Ultra with about 4.6× fewer active parameters. Parallel agents with self-verification add further test-time gains. On the efficiency side, the report covers MTP boosting (up to 21.8% longer acceptance length), NVFP4 quantization with QAD (99.62% median accuracy recovery vs. BF16), and vLLM serving optimizations such as ReplaySSM and Mamba checkpointing (up to 4,856 tokens/s/GPU on GB200). It also describes benchmark decontamination and quantization ablations. NVIDIA releases base, BF16, and NVFP4 checkpoints, parallel drafters (LiLiCorr, DFlash, DSpark), datasets, and training recipes.
