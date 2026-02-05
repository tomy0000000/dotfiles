#!/bin/bash
set -euo pipefail

# Install micro
brew install micro

# Run global setup script
bash pkg/micro/micro.sh
