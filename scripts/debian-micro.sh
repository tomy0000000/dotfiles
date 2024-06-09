#!/bin/bash
set -euo pipefail

# Install micro to current directory
bash -c "$(curl -fsSL https://getmic.ro)"

# Move micro to /usr/bin
if [ -f micro ]; then
    sudo mv micro /usr/bin/micro
else
    echo "micro installation failed"
    exit 1
fi
