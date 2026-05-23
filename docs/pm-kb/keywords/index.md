# Keywords Index

> Fast-lookup layer. Maps keywords → summaries → cards.

Purpose: when an agent searches for a term, it finds the right summary and cards immediately.

## Format

Each keyword file maps one concept to its related content:

```markdown
---
keyword: [keyword]
synonyms: [alt-name-1, alt-name-2]
summary_refs:
  - summaries/[topic].md
card_refs:
  - cards/YYYY-MM-DD-xxx.md
---
```
