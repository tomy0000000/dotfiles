# `ai-config`

Shares a single `AGENTS.md` across AI coding agents and installs reusable skills.

## Configures

- `~/.codex/AGENTS.md`: symlink to `pkg/ai-config/AGENTS.md`
- `~/.claude/CLAUDE.md`: symlink to `pkg/ai-config/AGENTS.md`
- Skills installed globally via `npx skills add` (universal + claude-code agents):
  - `vercel-labs/skills` → `find-skills`
  - `anthropics/skills` → `skill-creator`
  - `pkg/ai-config/skills/*`
