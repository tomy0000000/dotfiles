# shellcheck disable=SC2148
# exist.sh — detect if a given command exists

# Source guard: Exit if executed directly
(return 0 2>/dev/null) || exit 0

# Idempotent import: Prevent multiple imports
[ "${__EXIST_SH_LOADED:-}" = "1" ] && return 0
__EXIST_SH_LOADED=1

# --- Public API --------------------------------------------------------------

exist() {
  if ! command -v "${1}" &>/dev/null; then
    return 1
  else
    return 0
  fi
}
