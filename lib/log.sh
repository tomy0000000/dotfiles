# shellcheck disable=SC2148
# log.sh — POSIX-compatible logging utilities

# Source guard: Exit if executed directly
(return 0 2>/dev/null) || exit 0

# Idempotent import: Prevent multiple imports
[ "${__LOG_SH_LOADED:-}" = "1" ] && return 0
__LOG_SH_LOADED=1

# --- Configuration (safe defaults; callers may override before sourcing) ------
# Example overrides (before ". log.sh"):
#   LOG_LEVEL=20              # INFO and above
#   LOG_TIME=1                # enable timestamps
#   LOG_PREFIX="mytool"       # prefix tag
#   LOG_COLOR=1               # enable ANSI color (best-effort)

: "${LOG_LEVEL:=20}"          # 10=DEBUG, 20=INFO, 30=WARN, 40=ERROR
: "${LOG_TIME:=0}"            # 0/1
: "${LOG_PREFIX:=}"           # e.g. "mytool"
: "${LOG_COLOR:=0}"           # 0/1 (best-effort)

# --- Internal helpers (POSIX-safe) -------------------------------------------

_log_level_num() {
  # Map a level name to its numeric value.
  # Usage: _log_level_num "INFO"
  case "$1" in
    DEBUG) printf '%s' 10 ;;
    INFO)  printf '%s' 20 ;;
    WARN)  printf '%s' 30 ;;
    ERROR) printf '%s' 40 ;;
    *)     printf '%s' 0  ;;
  esac
}

_log_now() {
  # Timestamp in a reasonably portable format.
  # Uses `date` (external), but that’s a fair trade for portability.
  # If date fails, print empty string.
  date '+%Y-%m-%d %H:%M:%S' 2>/dev/null || printf '%s' ""
}

_log_use_color() {
  # Best-effort: use color only when LOG_COLOR=1, stderr/stdout are TTY, and not in CI/non‑TTY/dumb/no_color.
  # `-t` is POSIX for test in many shells; if unsupported, this will just fail false-ish.
  [ "${LOG_COLOR}" = "1" ] && [ -t 1 ] && [ -z "${NO_COLOR-}" ] && [ -n "${TERM-}" ] && [ "${TERM-}" != "dumb" ]
}

_log_fmt_prefix() {
  # Build prefix: optional [timestamp] [LEVEL] [prefix]
  # Output WITHOUT trailing space (caller adds it).
  lvl="$1"

  if [ "${LOG_TIME}" = "1" ]; then
    ts="$(_log_now)"
    if [ -n "$ts" ]; then
      printf '[%s] ' "$ts"
    fi
  fi

  printf '[%s]' "$lvl"

  if [ -n "${LOG_PREFIX}" ]; then
    printf ' [%s]' "${LOG_PREFIX}"
  fi
}

_log_print() {
  # _log_print LEVEL "message..."
  lvl="$1"
  shift

  lvl_num="$(_log_level_num "$lvl")"

  # Respect LOG_LEVEL threshold
  # If LOG_LEVEL is non-numeric, treat as INFO (20).
  case "${LOG_LEVEL}" in
    ''|*[!0-9]*) min_level=20 ;;
    *)           min_level="${LOG_LEVEL}" ;;
  esac

  [ "$lvl_num" -lt "$min_level" ] && return 0

  # Colour (best-effort, stderr only)
  if _log_use_color; then
    case "$lvl" in
      DEBUG) c_start="$(printf '🐛 \033[36m')" ;; # cyan
      INFO)  c_start="$(printf 'ℹ️ \033[32m')" ;; # green
      WARN)  c_start="$(printf '⚠️ \033[33m')" ;; # yellow
      ERROR) c_start="$(printf '🛑 \033[31m')" ;; # red
      *)     c_start="" ;;
    esac
    c_end="$(printf '\033[0m')"
  else
    c_start=""
    c_end=""
  fi

  # Print to stderr (so logs don’t pollute stdout pipelines)
  # Shellcheck note: we intentionally want "$*" to preserve spaces as one message.
  prefix="$(_log_fmt_prefix "$lvl")"
  # If message is empty, still print prefix.
  if [ "$#" -gt 0 ]; then
    printf '%s%s %s%s\n' "$c_start" "$prefix" "$*" "$c_end" >&2
  else
    printf '%s%s%s\n' "$c_start" "$prefix" "$c_end" >&2
  fi
}

# --- Public API --------------------------------------------------------------

log_debug() { _log_print DEBUG "$*"; }
log_info()  { _log_print INFO  "$*"; }
log_warn()  { _log_print WARN  "$*"; }
log_error() { _log_print ERROR "$*"; }

die() {
  # die "message" [exit_code]
  # Returns non-zero if sourced; if executed in a subshell, exit is up to the caller.
  msg="$1"
  code="${2:-1}"
  log_error "$msg"
  return "$code"
}

# Convenience: assert command exists
require_cmd() {
  # require_cmd curl git jq
  # Returns non-zero (and logs) if any command is missing.
  missing=""
  for cmd in "$@"; do
    command -v "$cmd" >/dev/null 2>&1 || missing="${missing} ${cmd}"
  done

  if [ -n "$missing" ]; then
    log_error "missing required command(s):${missing}"
    return 127
  fi
  return 0
}
