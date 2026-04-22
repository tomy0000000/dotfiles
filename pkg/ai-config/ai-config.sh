#!/bin/bash
set -euo pipefail

AGENTS_MD="$(pwd)/pkg/ai-config/AGENTS.md"

# For now, there's no unified AGENTS.md but these are the ones I use
# https://github.com/agentsmd/agents.md/issues/91

# Codex
CODEX_AGENTS_MD="${HOME}/.codex/AGENTS.md"
mkdir -p "${HOME}/.codex"
ln -sf "${AGENTS_MD}" "${CODEX_AGENTS_MD}"
log_info "Linked AGENTS.md to ${CODEX_AGENTS_MD}"

# Claude Code
CLAUDE_AGENTS_MD="${HOME}/.claude/CLAUDE.md"
mkdir -p "${HOME}/.claude"
ln -sf "${AGENTS_MD}" "${CLAUDE_AGENTS_MD}"
log_info "Linked AGENTS.md to ${CLAUDE_AGENTS_MD}"
