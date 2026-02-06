#!/bin/bash
set -euo pipefail

# Install apps
brew bundle --file brewfiles/app-design.Brewfile
brew bundle --file brewfiles/app-multimedia.Brewfile
brew bundle --file brewfiles/app-productivity.Brewfile
brew bundle --file brewfiles/app-social.Brewfile
brew bundle --file brewfiles/app-utility.Brewfile
