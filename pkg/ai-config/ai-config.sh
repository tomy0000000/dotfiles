#!/bin/bash
set -euo pipefail

AGENTS_MD="$(pwd)/pkg/ai-config/AGENTS.md"

link_agents_md() {
  local target="$1"
  mkdir -p "$(dirname "${target}")"
  ln -sf "${AGENTS_MD}" "${target}"
  log_info "Linked AGENTS.md to ${target}"
}

# For now, there's no unified AGENTS.md but these are the ones I use
# https://github.com/agentsmd/agents.md/issues/91
link_agents_md "${HOME}/.codex/AGENTS.md"
link_agents_md "${HOME}/.claude/CLAUDE.md"

# Install skills
SKILLS_PARAMS=(--agent universal --agent claude-code --global --yes)
npx skills add vercel-labs/skills --skill find-skills "${SKILLS_PARAMS[@]}"
npx skills add anthropics/skills --skill skill-creator "${SKILLS_PARAMS[@]}"
npx skills add ./pkg/ai-config/skills --skill '*' "${SKILLS_PARAMS[@]}"

# Install Claude status bar
curl -fsSL https://raw.githubusercontent.com/martinemde/starship-claude/main/plugin/bin/starship-claude -o ~/.local/bin/starship-claude
chmod +x ~/.local/bin/starship-claude

# Install Claude settings and configs
stow --adopt --no-folding --dir 'pkg/ai-config' --target "${HOME}" 'stow'
git checkout -- 'pkg/ai-config/stow'
