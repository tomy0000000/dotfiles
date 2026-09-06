#!/bin/bash
set -euo pipefail

# PreToolUse hook: deny Bash commands that break the shell conventions in
# GLOBAL-AGENTS.md, and tell the caller which tool to reach for instead.

input=$(cat)
[[ "$(jq -r '.tool_name // ""' <<<"${input}")" == "Bash" ]] || exit 0

cmd=$(jq -r '.tool_input.command // ""' <<<"${input}")

# A tool name only counts when it sits in command position: the start of the
# command, or right after a separator. Keeps `git grep` and `echo "use rg"`
# from tripping the rules below.
head=$'(^|[\n|;&(`{])[[:space:]]*(sudo[[:space:]]+)?([^[:space:]]*/)?'

deny() {
  jq -n --arg reason "$1" \
    '{hookSpecificOutput: {hookEventName: "PreToolUse", permissionDecision: "deny", permissionDecisionReason: $reason}}'
  exit 0
}

# -C only counts in git's global flag position, before the subcommand, so
# `git commit -C HEAD` and `git diff -C` still pass.
if [[ ${cmd} =~ ${head}git[[:space:]]+(-[^[:space:]]+[[:space:]]+)*-C[[:space:]] ]]; then
  deny "Shell convention: do not pass -C to git. Run from the repo root and use absolute paths to files and dirs in the repo."
fi

if [[ ${cmd} =~ ${head}env[[:space:]]*($|[|;&]) ]]; then
  deny "Shell convention: to check whether an env var is set, use 'printenv SOME_ENV'. Never bare 'env' or 'env | grep'."
fi

if [[ ${cmd} =~ ${head}grep([[:space:]]|$) ]]; then
  deny "Shell convention: use 'rg' (ripgrep) instead of grep: faster, respects .gitignore, better defaults."
fi

if [[ ${cmd} =~ ${head}find([[:space:]]|$) ]]; then
  deny "Shell convention: use 'fd' instead of find: faster, respects .gitignore, saner syntax."
fi

if [[ ${cmd} =~ ${head}sed([[:space:]]|$) ]]; then
  deny "Shell convention: use 'sd' instead of sed for find-and-replace. To read part of a file, use the Read tool with offset/limit."
fi

if [[ ${cmd} =~ ${head}cd[[:space:]].*(\&\&|;)[[:space:]]*bazel[[:space:]] ]]; then
  deny "Shell convention: never cd into the workspace before bazel. Use an absolute workspace path, e.g. 'bazel build //pkg/ai-config:target'."
fi

exit 0
