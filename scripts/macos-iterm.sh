#!/bin/bash
set -euo pipefail

# Import preferences from dotfiles
# shellcheck disable=SC2088
defaults write com.googlecode.iterm2 PrefsCustomFolder -string '~/.dotfiles/iterm'
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true

# Install the iTerm2 shell integration
#
# Copied and edited from
# https://iterm2.com/shell_integration/install_shell_integration_and_utilities.sh
#
# Main differences
# 1. source .iterm2_shell_integration.zsh in iterm.zsh instead of .zshrc
# 2. Install utilites to /opt/iterm2/bin instead of ~/.iterm2
SHELL=${SHELL##*/}
FILENAME="${HOME}/.iterm2_shell_integration.${SHELL}"
URL="https://iterm2.com/shell_integration/zsh"
UTILITIES=(imgcat imgls it2api it2attention it2check it2copy it2dl it2getvar it2git it2setcolor it2setkeylabel it2tip it2ul it2universion it2profile)

echo "Downloading script from ${URL} and saving it to ${FILENAME}..."
curl -SsL "${URL}" >"${FILENAME}"
chmod +x "${FILENAME}"

INSTALL_PATH="/opt/iterm2/bin"
if [ ! -d "${INSTALL_PATH}" ]; then
    echo "Creating directory ${INSTALL_PATH}..."
    sudo mkdir -p "${INSTALL_PATH}"
    sudo chown -R "$(whoami)":admin "${INSTALL_PATH}"
fi

for U in "${UTILITIES[@]}"; do
    echo "Downloading ${U}..."
    curl -fSsL "https://iterm2.com/utilities/${U}" >"${INSTALL_PATH}/${U}"
    chmod +x "${INSTALL_PATH}/${U}"
done
