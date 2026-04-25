#!/bin/bash
set -euo pipefail

# Install mise CLI via Homebrew
brew install mise

# Run global setup script
bash pkg/mise/mise.sh
