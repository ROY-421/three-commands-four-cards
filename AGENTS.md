# Project Rules

This file defines project-level working rules for `[project-name]`.

> To collaborators: drop this file into your project root. Your AI assistant reads it and knows how to work with you. Remember 4 words: **"kickoff", "wrap", "refresh", "status"**.

## Knowledge Base Rule

Use `docs/pm-kb/` as the durable project management knowledge base.

Important project information should be saved there, not left only in chat.

## Three-Layer Knowledge Structure

Maintain the knowledge base in three layers:

1. `docs/pm-kb/keywords/`
   Fast lookup layer. Use it for keywords, aliases, and links.

2. `docs/pm-kb/summaries/`
   Synthesis layer. Use it for current project understanding by topic.

3. `docs/pm-kb/cards/`
   Atomic record layer. Use it for individual facts, decisions, risks, tasks,
   findings, meeting notes, references, and operational notes.

## Write Order

When saving new information:

1. Create or update an information card in `cards/`.
2. Update the related topic summary in `summaries/`.
3. Add or update keyword links in `keywords/` when useful.

Do not put raw notes directly into summaries unless they have first been
captured as cards.

## Card Rules

- One card should record one thing.
- Include date, status, type, keywords, source, and a short summary.
- Prefer concise facts first, then implications and next actions.
- Link related summaries or cards when relevant.
- Preserve sources for official rules, data format findings, submission
  requirements, and team decisions.
- When a card is replaced by a newer finding, set its status to `superseded`
  and add `superseded_by` pointing to the new card. Don't delete old cards.

## What Must Be Recorded

Record these items in the knowledge base:

- Team setup, member changes, audit or submission status.
- Competition rules, deadlines, platform instructions, and official notices.
- Data source parsing status, gaps, and real sample findings.
- Algorithm decisions, evaluation results, threshold choices, and risks.
- Container, runtime, dependency, and submission readiness issues.
- Important user decisions or project conventions.

---

## Workflow: Session Protocol

This protocol applies to ALL AI agents, whether running locally (Codex, Claude Code)
or remotely (via cc-connect).

### Session Start

Every agent MUST read these before starting work, in order:

1. **`CURRENT.md`** — Current objectives, experiment queue, decisions, risks
2. **`AGENTS.md`** (this file) — Project rules and workflow protocol
3. **`docs/pm-kb/summaries/project-overview.md`** — Project full picture
4. **`docs/pm-kb/cards/`** most recent 3 cards + ALL cards with `status: open` and
   `type: risk` or `status: blocked` — Latest findings + unresolved issues

Estimated time: 2-3 minutes.

### During Session

- Any finding, decision, risk, or result → **write a card within 5 minutes**
  (file: `docs/pm-kb/cards/YYYY-MM-DD-brief-topic.md` using the SCHEMA template)
- Update `CURRENT.md` experiment table when status changes
- Do not leave important information only in chat history

### Session End

Before the session ends, the agent MUST:

1. **Write new cards** for everything learned during the session
2. **Update `CURRENT.md`**: experiment status, decisions, next steps
3. If remote (cc-connect): summarize what needs manual follow-up by the user

---

## Multi-Agent Coordination Protocol

**Important**: There may be TWO AI agents working on this project simultaneously:
- **Local agent** (Codex/Claude Code on desktop)
- **Remote agent** (cc-connect Claude Code)

They share the same filesystem but have independent memory. This protocol
prevents them from conflicting or missing each other's work.

### 1. Context Staleness Rule

Your in-memory context is **stale** if any of these are true:
- `CURRENT.md` modification time > your session start time
- A card file exists that you haven't read
- You haven't checked context in the last 15 minutes

**Before starting ANY non-trivial task** (code change, experiment, config edit),
run this check:

```bash
ls -la CURRENT.md
ls -t docs/pm-kb/cards/2*.md | head -5
```

If anything changed since you last checked → **re-read CURRENT.md + recent cards first**.

### 2. The "refresh" Command

When the user says **"refresh"** or **"sync"**, do this:

```
1. Run refresh.sh (or refresh.bat on Windows)
2. If CURRENT.md changed since session start → re-read it fully
3. Read the 3 newest cards + all open risk/blocked cards in docs/pm-kb/cards/
4. Read docs/pm-kb/summaries/project-overview.md
5. Report to user: "Context refreshed. Current status: [one-line summary]"
```

### 3. Write Conflict Prevention

**Never edit a file that another agent might be editing simultaneously.**

Safe to write freely:
- `docs/pm-kb/cards/YYYY-MM-DD-*.md` → new card (unique name per agent, no conflict)
- Running experiments (different output dirs)

**Check before writing**:
- `CURRENT.md` → read it first; if someone updated it since your last read,
  merge their changes, don't overwrite
- Source code files → avoid simultaneous edits to the same function

**Rule of thumb**: If you didn't create the file in this session, re-read it
before editing.

### 4. Agent Role Separation (Recommended)

If both agents are running simultaneously, give them distinct focuses:

| Agent | Natural role | Best for |
|-------|-------------|----------|
| **Codex / Claude Code (local)** | Code writing, experiments | Training runs, code changes, data analysis |
| **cc-connect (remote)** | Monitoring, light tasks | Check status, read logs, write cards, small edits |

### 5. The 4 Magic Phrases

| You say | Agent does |
|---------|-----------|
| **"kickoff"** / "start" | Read CURRENT.md + recent cards + report status |
| **"refresh"** / "sync" | Re-read CURRENT.md + latest cards |
| **"wrap"** / "done" | Write cards + update CURRENT.md + summarize |
| **"status"** / "progress" | Read CURRENT.md + recent cards, report experiment state |

These trigger words work in **any language**. See `locales/` for supported languages.
Chinese (`开工`/`收工`/`刷新`/`进度`) is the first supported locale.

## Current Entry Points

- Knowledge base root: `docs/pm-kb/README.md`
- Schema: `docs/pm-kb/SCHEMA.md`
- Project overview: `docs/pm-kb/summaries/project-overview.md`
- Current status: `CURRENT.md`
