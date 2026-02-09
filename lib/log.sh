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

: "${LOG_LEVEL:=20}"          # 10=DEBUG, 20=INFO, 30=WARN, 40=ERROR
: "${LOG_TIME:=0}"            # 0/1
: "${LOG_PREFIX:=}"           # e.g. "mytool"

# --- Internal helpers (POSIX-safe) -------------------------------------------

_log_level_num() {
  # Map a level name to its numeric value.
  # Usage: _log_level_num "INFO"
  case "$1" in
    DEBUG)  printf '%s' 10 ;;
    INFO)   printf '%s' 20 ;;
    WARN)   printf '%s' 30 ;;
    ERROR)  printf '%s' 40 ;;
    DIVIDER)       printf '%s' 20 ;;
    DIVIDER_END_OK)  printf '%s' 20 ;;
    DIVIDER_END_ERR) printf '%s' 20 ;;
    *)              printf '%s' 0  ;;
  esac
}

_log_now() {
  # Timestamp in a reasonably portable format.
  # Uses `date` (external), but that’s a fair trade for portability.
  # If date fails, print empty string.
  date '+%Y-%m-%d %H:%M:%S' 2>/dev/null || printf '%s' ""
}

_log_use_color() {
  # Best-effort: use color when stderr is TTY and not in CI/dumb/no_color.
  # `-t` is POSIX for test in many shells; if unsupported, this will just fail false-ish.
  [ -t 2 ] && [ -z "${NO_COLOR-}" ] && [ -n "${TERM-}" ] && [ "${TERM-}" != "dumb" ]
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
      DEBUG)   c_start="$(printf '🐛 \033[36m')" ;; # cyan
      INFO)    c_start="$(printf 'ℹ️ \033[32m')" ;; # green
      WARN)    c_start="$(printf '⚠️ \033[33m')" ;; # yellow
      ERROR)   c_start="$(printf '🛑 \033[31m')" ;; # red
      DIVIDER)         c_start="$(printf '\033[32m')" ;; # green (⌛️ in title)
      DIVIDER_END_OK)  c_start="$(printf '\033[32m')" ;; # green (✅ in title)
      DIVIDER_END_ERR) c_start="$(printf '\033[31m')" ;; # red (🛑 in title)
      *)               c_start="" ;;
    esac
    c_end="$(printf '\033[0m')"
  else
    c_start=""
    c_end=""
  fi

  # Print to stderr (so logs don’t pollute stdout pipelines)
  # Shellcheck note: we intentionally want "$*" to preserve spaces as one message.
  case "$lvl" in
    DIVIDER|DIVIDER_END_OK|DIVIDER_END_ERR) prefix="" ;;
    *) prefix="$(_log_fmt_prefix "$lvl")" ;;
  esac
  # If message is empty, still print prefix.
  if [ "$#" -gt 0 ]; then
    if [ -n "$prefix" ]; then
      printf '%s%s %s%s\n' "$c_start" "$prefix" "$*" "$c_end" >&2
    else
      printf '%s%s%s\n' "$c_start" "$*" "$c_end" >&2
    fi
  else
    printf '%s%s%s\n' "$c_start" "$prefix" "$c_end" >&2
  fi
}

_log_terminal_width() {
  # Best-effort: COLUMNS, then tput cols, then stty size, else 80.
  w="${COLUMNS:-}"
  if [ -z "$w" ]; then
    w="$(tput cols 2>/dev/null)" || w=""
  fi
  if [ -z "$w" ]; then
    w="$(stty size 2>/dev/null | awk '{print $2}')" || w=""
  fi
  case "$w" in
    ''|*[!0-9]*) printf '%s' 80 ;;
    *)          printf '%s' "$w" ;;
  esac
}

_log_divider() {
  # Arg 1: begin | end. Arg 2: script path. Arg 3 (end only): exit code (0 = success → green ✅, else red 🛑).
  kind="$1"
  path="$2"
  exit_code="${3:-0}"
  case "$kind" in
    begin) title="⌛️ BEGIN $path"; lvl="DIVIDER" ;;
    end)   if [ "$exit_code" = "0" ]; then title="✅ END $path"; lvl="DIVIDER_END_OK"; else title="🛑 END $path"; lvl="DIVIDER_END_ERR"; fi ;;
    *)     title="$path"; lvl="DIVIDER" ;;
  esac
  w="$(_log_terminal_width)"
  len=$(printf '%s' " $title " | wc -c | tr -d ' ')
  left_n=$(( (w - len) / 2 ))
  right_n=$(( w - len - left_n ))
  [ "$left_n" -lt 0 ] && left_n=0
  [ "$right_n" -lt 0 ] && right_n=0
  left=""
  i=0; while [ "$i" -lt "$left_n" ]; do left="${left}="; i=$((i+1)); done
  right=""
  i=0; while [ "$i" -lt "$right_n" ]; do right="${right}="; i=$((i+1)); done
  _log_print "$lvl" "$left $title $right"
}

# --- Public API --------------------------------------------------------------

log_debug() { _log_print DEBUG "$*"; }
log_info()  { _log_print INFO  "$*"; }
log_warn()  { _log_print WARN  "$*"; }
log_error() { _log_print ERROR "$*"; }

run() {
  # run "path/to/script"
  # Execute a script with pre-configured log (LOG_* exported; script runs in current shell and can use log_*).
  [ -z "$1" ] && { log_error "run: missing script path"; return 1; }
  [ ! -r "$1" ] && { log_error "run: not readable or not found: $1"; return 1; }
  export LOG_LEVEL LOG_TIME LOG_PREFIX
  _log_divider begin "$1"
  # shellcheck disable=SC1090
  ( . "$1" )   # Run in subshell
  ret=$?
  _log_divider end "$1" "$ret"
  return $ret
}

die() {
  # die "message" [exit_code]
  # Returns non-zero if sourced; if executed in a subshell, exit is up to the caller.
  msg="$1"
  code="${2:-1}"
  log_error "$msg"
  return "$code"
}
