#!/usr/bin/env bash
set -euo pipefail

# Install configs
stow --no-folding --dir 'pkg/micro' --target "${HOME}" 'stow'
