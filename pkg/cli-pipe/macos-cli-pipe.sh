#!/bin/bash
set -euo pipefail

# Install CLIs
brew bundle --file pkg/cli-pipe/cli-pipe.Brewfile
