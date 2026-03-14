#!/bin/bash
set -euo pipefail

# Load .zshenv to get XDG_CONFIG_HOME
set +u
# shellcheck source=pkg/zsh/.zshenv
source 'pkg/zsh/.zshenv'
set -u

MISE_DIR="${XDG_CONFIG_HOME}/mise"
CONFIG_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/config.toml"
trap 'unset MISE_DIR CONFIG_PATH' EXIT

# Install dotfiles
mkdir -p "${MISE_DIR}"
ln -sf "${CONFIG_PATH}" "${MISE_DIR}"
