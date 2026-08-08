# shellcheck disable=SC2148
# fpath.sh - Print $FPATH entries one per line
# Note: FPATH is a zsh concept. In bash this prints nothing.

# Source guard: Exit if executed directly
(return 0 2>/dev/null) || exit 0

# Idempotent import: Prevent multiple imports
[ "${__FPATH_SH_LOADED:-}" = "1" ] && return 0
__FPATH_SH_LOADED=1

# --- Public API --------------------------------------------------------------

fpath() {
  # Expand via a variable: zsh does not interpret $'\n' inside a ${//} replacement.
  # FPATH is unset outside zsh, so default it before expanding for `set -u` callers.
  local nl=$'\n' entries="${FPATH:-}"
  printf '%s\n' "${entries//:/$nl}"
}
