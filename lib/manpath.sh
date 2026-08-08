# shellcheck disable=SC2148
# manpath.sh - Print $MANPATH entries one per line
# Note: this shadows /usr/bin/manpath in any shell that sources it.

# Source guard: Exit if executed directly
(return 0 2>/dev/null) || exit 0

# Idempotent import: Prevent multiple imports
[ "${__MANPATH_SH_LOADED:-}" = "1" ] && return 0
__MANPATH_SH_LOADED=1

# --- Public API --------------------------------------------------------------

manpath() {
  # Expand via a variable: zsh does not interpret $'\n' inside a ${//} replacement.
  # MANPATH is not always set, so default it before expanding for `set -u` callers.
  local nl=$'\n' entries="${MANPATH:-}"
  printf '%s\n' "${entries//:/$nl}"
}
