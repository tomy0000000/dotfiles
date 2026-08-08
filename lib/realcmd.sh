# shellcheck disable=SC2148
# realcmd.sh - Resolve a command to the real path of its executable

# Source guard: Exit if executed directly
(return 0 2>/dev/null) || exit 0

# Idempotent import: Prevent multiple imports
[ "${__REALCMD_SH_LOADED:-}" = "1" ] && return 0
__REALCMD_SH_LOADED=1

# --- Public API --------------------------------------------------------------

realcmd() {
  local target
  target="$(which "${1}")" || return 1

  # rbenv shims all resolve to the same shim binary, ask rbenv for the real one
  if [[ "${target}" == *".rbenv"* ]]; then
    rbenv which "${1}"
  else
    realpath "${target}"
  fi
}
