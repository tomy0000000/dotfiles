#!/bin/bash
set -euo pipefail

SCRIPT_DIR=$(dirname "$0")
ABSOLUTE_SCRIPT_DIR=$(realpath "${SCRIPT_DIR}")

# Install micro to current directory
cd "${ABSOLUTE_SCRIPT_DIR}"
bash -c "$(curl -fsSL https://getmic.ro)"

# Move micro to /usr/bin
if [ -f "${ABSOLUTE_SCRIPT_DIR}/micro" ]; then
    sudo mv micro /usr/bin/micro
else
    echo "micro installation failed"
    exit 1
fi

# Run global setup script
bash pkg/micro/micro.sh
