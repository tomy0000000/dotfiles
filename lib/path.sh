# shellcheck disable=SC2148
# path.sh - Print $PATH entries one per line

# Source guard: Exit if executed directly
(return 0 2>/dev/null) || exit 0

# Idempotent import: Prevent multiple imports
[ "${__PATH_SH_LOADED:-}" = "1" ] && return 0
__PATH_SH_LOADED=1

# --- Public API --------------------------------------------------------------

path() {
  # Expand via a variable: zsh does not interpret $'\n' inside a ${//} replacement
  local nl=$'\n'
  printf '%s\n' "${PATH//:/$nl}"
}
