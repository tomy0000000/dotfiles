# shellcheck disable=SC2148
# brew.sh - Homebrew utility functions

# Source guard: Exit if executed directly
(return 0 2>/dev/null) || exit 0

# Idempotent import: Prevent multiple imports
[ "${__BREW_SH_LOADED:-}" = "1" ] && return 0
__BREW_SH_LOADED=1

# --- Public API --------------------------------------------------------------

abs_brew() {
  # Detect architecture and set Homebrew prefix
  UNAME_MACHINE="$(/usr/bin/uname -m)"
  if [[ "${UNAME_MACHINE}" == "arm64" ]]; then
    PREFIX="/opt/homebrew"
  else
    PREFIX="/usr/local"
  fi

  # Return Homebrew binary path if installed
  if [ -f "${PREFIX}/bin/brew" ]; then
    echo "${PREFIX}/bin/brew"
    return 0
  else
    return 1
  fi
}
