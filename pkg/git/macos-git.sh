#!/bin/bash
set -euo pipefail

# Install git and miscellaneous tools
brew bundle --file pkg/git/git.Brewfile

# Run global setup script
bash pkg/git/git.sh
