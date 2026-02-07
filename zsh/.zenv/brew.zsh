#!/bin/zsh

# Source brew utilities
# TODO: Remove this after global source lib
source ${ZDOTDIR}/../lib/brew.sh

# Setup Homebrew if available
if brew_path="$(abs_brew)"; then
    # Core environment variables
    eval "$("${brew_path}" shellenv)"

    # In favor of homebrew-autoupdate
    export HOMEBREW_NO_AUTO_UPDATE=true
    
    # Clean up temporary variable
    unset brew_path
fi
