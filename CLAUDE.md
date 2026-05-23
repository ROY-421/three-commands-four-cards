# CLAUDE.md — Project Work Rules

This project uses the T3C4 (Three Commands, Four Cards) standard workflow protocol.

## 1. Entry Point

Read `AGENTS.md` first. It contains the full working rules:
- Kickoff / Wrap session protocol
- Multi-agent coordination
- Card knowledge base
- Magic Phrases

## 2. Quick Reference

| User says | You do |
|-----------|--------|
| **"kickoff"** / "start" | Read CURRENT.md + AGENTS.md + recent cards → report status |
| **"wrap"** / "done" | Write cards + update CURRENT.md + summarize |
| **"refresh"** / "sync" | Check if CURRENT.md changed → re-read |
| **"status"** / "progress" | Read CURRENT.md → report state |

## 3. Key Paths

| File | Purpose |
|------|---------|
| `CURRENT.md` | Current status (kickoff starts here) |
| `AGENTS.md` | Full protocol |
| `docs/pm-kb/cards/` | Information cards directory |
