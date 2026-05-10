#!/bin/bash
set -euo pipefail

AGENTS_MD="$(pwd)/pkg/ai-config/AGENTS.md"
STARSHIP_CLAUDE_DIR="${HOME}/.local/bin"
STARSHIP_CLAUDE_PATH="${STARSHIP_CLAUDE_DIR}/starship-claude"

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
mkdir -p "${STARSHIP_CLAUDE_DIR}"
curl -fsSL https://raw.githubusercontent.com/martinemde/starship-claude/main/plugin/bin/starship-claude -o "${STARSHIP_CLAUDE_PATH}"
chmod +x "${STARSHIP_CLAUDE_PATH}"

# Install Claude settings and configs
stow --adopt --no-folding --dir 'pkg/ai-config' --target "${HOME}" 'stow'
git checkout -- 'pkg/ai-config/stow'
