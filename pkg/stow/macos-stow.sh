#!/bin/bash
set -euo pipefail

# Install stow if not installed yet
exist stow || brew install stow
