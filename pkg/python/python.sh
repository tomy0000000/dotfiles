#!/bin/bash
set -euo pipefail

# Stow config
stow --no-folding --dir 'pkg/python' --target "${HOME}" 'stow'
