---
title: "EmbeddingGemma 2: Unified and Efficient Multimodal Representations"
date: 2026-11-04
tags:
  - engineering/ai/models
type: paper
source: https://arxiv.org/html/2610.37364v1
summary_by: ai
imported_from: "obsidian-vault/Resources/AI/Models.md"
draft: true
---

[EmbeddingGemma 2: Unified and Efficient Multimodal Representations](https://arxiv.org/html/2610.37364v1)

EmbeddingGemma 2 is an open, 744M-parameter multimodal embedding model from Google's EmbeddingGemma Team. It maps text, images, audio, video, and interleaved combinations of them into a single unified vector space. It is built on Gemma 4 and distilled from Gemini Embedding 2. The architecture is modular: a 271M bidirectional transformer backbone (with simplified per-layer embeddings that drop the dedicated lookup table), a 167M vision encoder, and a 305M audio encoder, which can be loaded selectively for text-only, vision-language, or audio-language use. Training follows a three-stage curriculum: text pre-finetuning, then multimodal pre-finetuning with distillation, then multimodal finetuning with contrastive, spread-out, and Matryoshka losses. This is followed by checkpoint merging and quantization-aware training. The model supports adjustable vision token budgets, truncatable embeddings (768/512/256/128 dimensions), and int4 quantized checkpoints for on-device use. Across MTEB (multilingual, English, code), MMEB-v2, MIEB(lite), MAEB, and MSEB, it sets a new Pareto frontier, often matching or beating specialist models and models several times larger. Ablations justify the key design choices.
