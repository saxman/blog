---
title: Engineering
---

References I'm tracking on engineering, mostly AI: papers, tools, harnesses, models, and courses, weighted toward AI for scientific research.

## Browse by topic

- [[tags/engineering/ai/agent-skills|Agent skills]]: individual skills and skill libraries, plus the specs for writing them
- [[tags/engineering/ai/registries|Registries]]: directories and marketplaces of skills, MCP servers, and tools
- [[tags/engineering/ai/harnesses|Harnesses]]: agent harnesses and harness engineering
- [[tags/engineering/ai/for-science|AI for science]]: research workbenches and the AI co-scientist framing
- [[tags/engineering/ai/research|Research]]: papers and long-form writing on AI, including evaluations
- [[tags/engineering/ai/models|Models]]: local and on-device models and the runtimes that serve them
- [[tags/engineering/ai/protocols|Protocols]]: protocols for agent communication and context
- [[tags/engineering/ai/tools|Tools]]: AI tools for research and software work
- [[tags/engineering/ai/training|Training]]: courses on AI for researchers and builders

See [[tags/engineering|all engineering tags]].

## Recent posts

```base
filters:
  and:
    - file.inFolder("engineering/posts")
formulas:
  post: file.asLink(title)
  added: date.format("MMM D, YYYY")
views:
  - type: list
    name: Recent posts
    order:
      - formula.post
      - formula.added
    sort:
      - property: date
        direction: DESC
    limit: 5
```

Browse the [[engineering/posts|full archive]].
