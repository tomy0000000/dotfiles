#!/bin/bash
set -euo pipefail

# Setup homebrew for this particular shell
UNAME_MACHINE="$(/usr/bin/uname -m)"
if [[ "${UNAME_MACHINE}" == "arm64" ]]; then
    # On ARM macOS, this script installs to /opt/homebrew only
    HOMEBREW_PREFIX="/opt/homebrew"
else
    # On Intel macOS, this script installs to /usr/local only
    HOMEBREW_PREFIX="/usr/local"
fi
eval "$(${HOMEBREW_PREFIX}/bin/brew shellenv)"

# Setup temporary Homebrew alias
# shellcheck disable=SC2139
alias brew="${HOMEBREW_PREFIX}/bin/brew"
