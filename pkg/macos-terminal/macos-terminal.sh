#!/bin/bash
set -euo pipefail

# Install dracula theme
brew trust --command dracula/install/dracula-terminal
brew install --cask dracula/install/dracula-terminal
