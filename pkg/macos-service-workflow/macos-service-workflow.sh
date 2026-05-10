#!/bin/bash
set -euo pipefail

# Stow Automator workflows into ~/Library/Services
stow --dir 'pkg' --target "${HOME}/Library/Services" 'macos-service-workflow'
