#!/bin/bash
set -euo pipefail

# Stow config
stow --no-folding --dir 'pkg/ansible' --target "${HOME}" 'stow'
