#!/usr/bin/env bash
set -euo pipefail

# Install configs
stow --no-folding --dir 'pkg/javascript' --target "${HOME}" 'stow'
