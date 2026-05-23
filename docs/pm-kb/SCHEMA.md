# Knowledge Base Write Schema

## Naming

- Information cards: `YYYY-MM-DD-<slug>.md`
- Summary pages: `<topic-slug>.md`
- Keyword pages: `<keyword-slug>.md`

## Card Template

```markdown
---
id: card-YYYY-MM-DD-xxx
type: decision | task | risk | meeting | finding | reference
status: open | active | done | blocked | archived
date: YYYY-MM-DD
project: [project-name]
keywords: [tag1, tag2]
source: user | meeting | doc | code | web
summary: One-line description
---

## Context

## Details

## Implication

## Next
```

## Summary Template

```markdown
---
topic: [topic-name]
status: active
keywords: [tag1, tag2]
card_refs:
  - cards/YYYY-MM-DD-xxx.md
---

## Current view

## Open questions

## Next actions
```

## Keyword Template

```markdown
---
keyword: [keyword]
synonyms: [synonym1, synonym2]
summary_refs:
  - summaries/[topic].md
card_refs:
  - cards/YYYY-MM-DD-xxx.md
---

## Definition

## Related summaries

## Related cards
```
