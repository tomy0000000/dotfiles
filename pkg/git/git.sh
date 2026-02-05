#!/usr/bin/env bash
set -euo pipefail

# Create a symbolic link for the global git configuration file
ln -sf '.dotfiles/pkg/git/.gitconfig' "${HOME}"
