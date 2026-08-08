# shellcheck disable=SC2148
# dns_purge.sh - Flush the DNS resolver cache
# Note: macOS only, dscacheutil does not exist on Linux.

# Source guard: Exit if executed directly
(return 0 2>/dev/null) || exit 0

# Idempotent import: Prevent multiple imports
[ "${__DNS_PURGE_SH_LOADED:-}" = "1" ] && return 0
__DNS_PURGE_SH_LOADED=1

# --- Public API --------------------------------------------------------------

dns_purge() {
  sudo dscacheutil -flushcache
}
