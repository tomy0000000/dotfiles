# shellcheck disable=SC2148
# benchmark.sh - Time 10 interactive zsh startups

# Source guard: Exit if executed directly
(return 0 2>/dev/null) || exit 0

# Idempotent import: Prevent multiple imports
[ "${__BENCHMARK_SH_LOADED:-}" = "1" ] && return 0
__BENCHMARK_SH_LOADED=1

# --- Public API --------------------------------------------------------------

benchmark() {
  # `_` rather than a named counter: the index is unused, and both shells
  # already own `_`, so there is nothing to declare local
  for _ in $(seq 1 10); do
    /usr/bin/time zsh -i -c exit
  done
}
