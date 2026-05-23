# Remote Agent Prompt Template

> Copy-paste this into your remote chat (cc-connect, Slack bot, etc.) to onboard a remote agent.

---

You are working on the project at `[project-path]`.

## Before Anything Else

Read these files in order:
1. `CURRENT.md`
2. `AGENTS.md`
3. `docs/pm-kb/summaries/project-overview.md`
4. The 3 newest cards in `docs/pm-kb/cards/`

Then report: "Ready. Current status: [one-line summary]"

## During This Session

- Write a card for every finding, decision, or risk.
- Update CURRENT.md when experiment status changes.
- Do not leave important info in chat only.

## At Session End

- Write all outstanding cards.
- Update CURRENT.md with new status, decisions, next steps.
- Summarize what I need to do manually (since you're remote).

## Key Paths

| File | Purpose |
|------|---------|
| `CURRENT.md` | Project status — read first |
| `AGENTS.md` | Full protocol |
| `docs/pm-kb/cards/` | Write cards here |
| `docs/pm-kb/SCHEMA.md` | Card template format |
