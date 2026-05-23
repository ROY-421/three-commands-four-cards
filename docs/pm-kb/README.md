# Project Knowledge Base

> Two types of knowledge coexist in this project:
>
> 1. **Project KB** (`docs/pm-kb/`) — operational, daily, lives with the code
> 2. **Personal KB** (Obsidian vault) — compiled, durable, long-term

## Layer Structure

```
docs/pm-kb/
├── cards/         # Atomic records (decisions, findings, risks, tasks)
│   └── index.md
├── summaries/     # Topic summaries (current understanding)
│   └── index.md
├── keywords/      # Fast lookup index
│   └── index.md
├── SCHEMA.md      # Card/summary/keyword templates
├── README.md      # This file
└── remote-prompt-template.md  # Template for cc-connect sessions
```

## Discipline

- **Card first**: Every finding becomes a card before anything else.
- **5-minute rule**: Write the card within 5 minutes of the discovery.
- **Summaries second**: Only update summaries when a topic has enough cards.
- **Keywords as needed**: Add keywords when a term appears across multiple cards.

## Sync to Personal KB

When a milestone is reached (or the project ends), compile key findings
into your personal knowledge base under `wiki/projects/` and
`wiki/procedural/`.
