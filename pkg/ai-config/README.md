# `ai-config`

Shares a single `AGENTS.md` across AI coding agents and installs reusable skills.

## Configures

- A global `GLOBAL-AGENTS.md`
  - Copied from [multica-ai/andrej-karpathy-skills](https://github.com/multica-ai/andrej-karpathy-skills)
  - symlinked from `~/.codex/AGENTS.md` for Codex
  - symlinked from `~/.claude/CLAUDE.md` for Claude Code
- Skills installed globally via `npx skills add` for `universal` + `claude-code` agents:
  - `find-skills` from `vercel-labs/skills`
  - `skill-creator` from `anthropics/skills`
  - every skill under `pkg/ai-config/skills/`
- Claude settings
- Claude status line with `starship-claude`
