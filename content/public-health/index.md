---
title: Public Health
---

References on public health policy, mostly infectious disease modeling: tools, data standards, papers, and collaborative modeling efforts.

## Browse by topic

- [[tags/public-health/disease-modeling|Disease modeling]]: tools, data standards, and collaborative modeling efforts, including AI-for-modeling work cross-listed from [[engineering/index|Engineering]]
- [[tags/public-health/population-mapping|Population mapping]]: population data and mapping

See [[tags/public-health|all public health tags]].

## Recent posts

```base
filters:
  and:
    - file.inFolder("public-health/posts")
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

Browse the [[public-health/posts|full archive]].
