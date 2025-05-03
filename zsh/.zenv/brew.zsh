#!/bin/zsh

UNAME_MACHINE="$(/usr/bin/uname -m)"
if [[ "${UNAME_MACHINE}" == "arm64" ]]; then
    # On ARM macOS, this script installs to /opt/homebrew only
    PRE_BREW_PREFIX="/opt/homebrew"
else
    # On Intel macOS, this script installs to /usr/local only
    PRE_BREW_PREFIX="/usr/local"
fi

# Check if Homebrew is installed
if [ -f "${PRE_BREW_PREFIX}/bin/brew" ]; then
    # Core environment variables
    eval "$(${PRE_BREW_PREFIX}/bin/brew shellenv)"

    # In favor of homebrew-autoupdate
    export HOMEBREW_NO_AUTO_UPDATE=true
fi
