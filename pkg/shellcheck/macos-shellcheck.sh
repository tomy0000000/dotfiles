#!/bin/bash
set -euo pipefail

# Install shellcheck if not installed yet
exist shellcheck || brew install shellcheck

# Stow config
stow --no-folding --dir 'pkg/shellcheck' --target "${HOME}" 'stow'
