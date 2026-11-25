---
title: Language Model Harnesses can be Compositional Generalizers
date: 2026-11-24
published:
tags:
  - engineering/ai/harnesses
  - engineering/ai/training
  - engineering/ai/research
type: paper
source: https://academy.dair.ai/papers/language-model-harnesses-can-be-compositional-generalizers-2611.28298
author:
summary_by: ai
draft: false
---
[Language Model Harnesses can be Compositional Generalizers](https://academy.dair.ai/papers/language-model-harnesses-can-be-compositional-generalizers-2611.28298)

This MIT CSAIL paper argues that neurosymbolic LM harnesses, such as Recursive Language Models, can generalize compositionally. They manage context programmatically, so each underlying LM call sees in-distribution input even when the overall task is novel. It shows RL-trained RLMs generalizing to much longer tasks and new domains, introduces surrogate harness training, and presents RLM-27B, which improves on its base model in the same RLM harness by 26.9% on average on hard long-context benchmarks while using about 2× fewer inference tokens.

