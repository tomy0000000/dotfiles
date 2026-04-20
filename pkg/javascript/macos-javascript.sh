#!/bin/bash
set -euo pipefail

# Install LTS versions of node
mise use -g node@lts

# Run global setup script
bash pkg/javascript/javascript.sh
