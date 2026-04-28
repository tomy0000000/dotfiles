# `ai-config`

Shares a single `AGENTS.md` across AI coding agents and installs reusable skills.

## Configures

- `~/.codex/AGENTS.md` — symlinked to `pkg/ai-config/AGENTS.md`
- `~/.claude/CLAUDE.md` — symlinked to `pkg/ai-config/AGENTS.md`
- Skills installed globally via `npx skills add` for `universal` + `claude-code` agents:
  - `find-skills` from `vercel-labs/skills`
  - `skill-creator` from `anthropics/skills`
  - every skill under `pkg/ai-config/skills/`
