# Three Commands, Four Cards (T3C4)

> A minimal, battle-tested multi-AI-agent project collaboration protocol.
> **6 magic phrases. 3 files. 1 directory. 3 minutes to bootstrap.**

## What Is This?

You run multiple AI coding agents (Claude Code, Codex, Cursor, etc.) — some on your desktop, some via remote chat (cc-connect, Slack, Discord). They all work on the same project but have **independent memory**. One agent codes. Another checks progress. Neither knows what the other did.

T3C4 solves this with a simple rule: **all agents share the same files = all agents share the same memory.**

No server. No API. No encryption keys. Just files.

## The 6 Magic Phrases

| You say | Agent does |
|---------|-----------|
| **"kickoff"** / "start" | Read CURRENT.md → read latest 3 cards + all open risks → report status → **wait for your confirmation before acting** |
| **"resume"** / "继续" | Quick re-alignment: check CURRENT.md timestamp → read latest 3 cards → report → wait for orders |
| **"wrap"** / "done" | Write new cards for everything learned → update CURRENT.md → summarize |
| **"refresh"** / "sync" | Check CURRENT.md timestamp → re-read if changed → read new cards → report |
| **"status"** / "progress" | Read CURRENT.md → report experiment queue, blockers, next steps |
| **"note this"** / "记一下" | Immediately write the last finding as a card — don't wait for wrap |

These trigger words work in **any language**. Chinese (`开工`/`继续`/`收工`/`刷新`/`进度`/`记一下`) is the first supported locale. See `locales/zh-CN/`.

> **v4.1 change**: On "kickoff", the agent now reports status and **waits for your confirmation** before starting any work. No more acting on its own.

## Quick Start (3 Minutes)

```bash
# 1. Copy the template into your project
cp -r t3c4/* your-project/

# 2. Edit project name
# Open AGENTS.md and CURRENT.md, replace [project-name] with yours

# 3. Fill in CURRENT.md
# - Current objective
# - Task queue (P0/P1/P2)
# - Known risks

# 4. Write your first batch of cards
# docs/pm-kb/cards/YYYY-MM-DD-project-goals.md
# docs/pm-kb/cards/YYYY-MM-DD-data-overview.md

# 5. Write the project overview summary
# docs/pm-kb/summaries/project-overview.md

# 6. Say "kickoff"
# Your agent reads CURRENT.md, knows the plan, reports status, and waits for your confirmation.
```

## How It Works

```
Agent A (desktop)  →  says "wrap" → writes cards + updates CURRENT.md  →  files changed
                                                                           ↓
Agent B (remote)   →  says "refresh" → re-reads CURRENT.md + cards     →  knows what A did
                   →  says "kickoff" → reports status → A confirms      →  works
                                                                           ↓
                   →  says "wrap" → writes cards + updates CURRENT.md  →  files changed
                                                                           ↓
Agent A returns    →  says "refresh" → re-reads CURRENT.md + cards     →  knows what B did
                   →  says "kickoff" → reports status → B confirms      →  works
```

**The filesystem is the shared bus.** Every agent reads from it on start, writes to it on finish. No direct communication needed. Agents always report status and wait for confirmation before acting.

## Directory Structure

```
your-project/
├── AGENTS.md              ← Full protocol
├── CURRENT.md             ← Project status hub (kickoff starts here)
├── refresh.bat            ← Windows one-click context refresh
├── refresh.sh             ← Linux/Mac one-click context refresh
└── docs/pm-kb/            ← Project knowledge base
    ├── README.md          ← KB root
    ├── SCHEMA.md          ← Card / summary / keyword templates
    ├── cards/             ← Atomic knowledge cards (one fact per card)
    │   └── index.md
    ├── summaries/         ← Topic-level synthesis
    │   └── index.md
    ├── keywords/          ← Fast-lookup index
    │   └── index.md
    └── remote-prompt-template.md
```

## The "One Card, One Fact" Rule

Cards are the minimal knowledge unit. Every important finding, decision, risk, or result gets its own card:

```markdown
---
id: card-2026-05-23-something
type: decision | task | risk | meeting | finding | reference
status: open | active | done | blocked | archived
date: 2026-05-23
keywords: [tag1, tag2]
source: user | meeting | doc | code | web
summary: One-line description
---

## Context

## Details

## Implication

## Next
```

**When to write a card:**
- You made a decision that affects future work
- You found a bug or data issue worth remembering
- An experiment completed with a meaningful result
- Requirements changed
- You learned something non-obvious

**When NOT to write a card:**
- Trivial progress updates (update CURRENT.md instead)
- Things already obvious from the code
- Temporary notes that won't matter tomorrow

## Multi-Agent Safety Rules

1. **Cards are always safe to write** — filenames are timestamped, agents can't conflict
2. **CURRENT.md needs care** — read before editing, merge don't overwrite
3. **Context is stale after 15 minutes** — another agent may have changed things
4. **Recommended split**: desktop agent codes & runs experiments, remote agent checks status & writes cards

## Language Support

T3C4 is trigger-language-agnostic. The protocol defines **actions** (start-session, end-session, refresh-context, check-status), not specific words. You can map any language's natural phrases to these actions.

| Action | English | 中文 |
|--------|---------|------|
| start-session | kickoff, start | 开工 |
| resume-session | resume, continue | 继续 |
| end-session | wrap, done | 收工 |
| refresh-context | refresh, sync | 刷新上下文 |
| check-status | status, progress | 看看进度 |
| record-finding | note this, remember | 记一下 |

See `locales/zh-CN/` for the full Chinese protocol.

## Compared to Alternatives

| | T3C4 | OpenFused | Agent-Boss | gitmem |
|---|------|-----------|------------|--------|
| **Transport** | Files | Files + FUSE | HTTP server | Files + Git |
| **Bootstrap time** | 3 min | 15 min | 30 min | 10 min |
| **Requires server** | No | No | Yes | No (needs Git) |
| **Encryption** | No | Ed25519 + age | No | Git-native |
| **Multi-language** | Yes | No | No | No |
| **Opinionated** | Yes (prescriptive) | No (framework) | Semi | Semi |
| **Best for** | Personal multi-agent | Secure team mesh | Team dashboard | Org knowledge base |

T3C4 is deliberately minimal. It doesn't do encryption, federation, or HTTP APIs — because for a single person running 2-3 agents on the same project, you don't need any of that. You just need files.

## FAQ

**Q: Do agents automatically read CURRENT.md?**
A: No. But when you say **"kickoff"** or **"refresh"**, they do. These are the triggers.

**Q: What if two agents edit CURRENT.md at the same time?**
A: Very unlikely — you wouldn't say "wrap" simultaneously. If it happens, the rule is: read before editing, merge don't overwrite.

**Q: Do I have to use `docs/pm-kb/`?**
A: Not strictly, but consistency matters. Same paths across projects means agents never need to guess.

**Q: Cards pile up over time. What do I do?**
A: Cards are atomic units — no need to delete. When a project ends, compile valuable cards into a knowledge base summary and archive the rest.

**Q: What's the difference between "kickoff" and "resume"?**
A: "kickoff" does a full context load (CURRENT.md + AGENTS.md + summaries + 5 recent cards + all open risks). "resume" is a quick re-alignment (check timestamp + 3 latest cards) — use it when your agent already has most of the context.

## Philosophy

- **Files over APIs** — Every agent can read files. Not every agent can call your HTTP endpoint.
- **Convention over configuration** — `AGENTS.md`, `CURRENT.md`, `docs/pm-kb/cards/`. Same names, every project.
- **Facts over narratives** — Cards are atomic facts. Summaries are synthesized views. Separate them.
- **Human-readable first** — All files are plain Markdown. You can read them without an agent.

## Adopted By

| Project | Status |
|---------|--------|
| ChatDoc (Meteorological AI Office Platform) | ✅ Production |
| Meteorology Competition Entries (Radar, Hail, etc.) | ✅ Active |

---

## License

MIT — use it, fork it, ship it.

## Author

Created by [Deng Rongyao](https://github.com/ROY-421) after running multi-agent workflows on meteorological research projects since 2025. Battle-tested across competition entries, research papers, and daily operations.
