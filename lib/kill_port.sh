# shellcheck disable=SC2148
# kill_port.sh - Kill the process bound to a given port
# Note: delegates to the kill-port npm package, so pnpm must be available.

# Source guard: Exit if executed directly
(return 0 2>/dev/null) || exit 0

# Idempotent import: Prevent multiple imports
[ "${__KILL_PORT_SH_LOADED:-}" = "1" ] && return 0
__KILL_PORT_SH_LOADED=1

# --- Public API --------------------------------------------------------------

kill_port() {
  # Default the argument so a bare call does not trip `set -u` in install scripts
  pnpm dlx kill-port "${1:-}"
}
