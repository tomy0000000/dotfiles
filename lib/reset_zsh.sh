# shellcheck disable=SC2148
# reset_zsh.sh - Repair completion permissions and wipe zsh caches
# Note: zsh only, compaudit is a zsh function and zinit is a zsh plugin manager.

# Source guard: Exit if executed directly
(return 0 2>/dev/null) || exit 0

# Idempotent import: Prevent multiple imports
[ "${__RESET_ZSH_SH_LOADED:-}" = "1" ] && return 0
__RESET_ZSH_SH_LOADED=1

# --- Public API --------------------------------------------------------------

reset_zsh() {
  # Reset source directories permissions
  compaudit | xargs chmod g-w,o-w
  compaudit | xargs chown "$(whoami)"

  # Remove cached files
  rm -f "${HOME}/.zcompdump*"

  # Delete all compiled zinit plugins
  zinit delete --all
}
