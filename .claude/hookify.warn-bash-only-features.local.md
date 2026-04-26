---
name: warn-bash-only-features
enabled: true
event: file
conditions:
  - field: file_path
    operator: regex_match
    pattern: \.sh$
---

⚠️ **Bash-only feature detected in a `*.sh` script**

`*.sh` scripts in this repo should avoid bash-only features so they stay portable to POSIX `sh`. The pattern above caught **`BASH_SOURCE`**, but it's only one example. Other bash-only constructs to avoid:

- `BASH_*` builtins (`BASH_SOURCE`, `BASH_VERSION`, `BASH_REMATCH`, …)
- `[[ ... ]]` conditionals (use `[ ... ]`)
- `<<<` here-strings
- `<(...)` process substitution
- `(( ... ))` arithmetic commands
- bash arrays (`arr=(...)`, `${arr[@]}`)
- `${var,,}` / `${var^^}` case modification
- `local` (POSIX `sh` has no equivalent)

**Specific to `BASH_SOURCE` in `pkg/**/\*.sh`:** those scripts run from the repo root via `make`/ the`run`helper, so paths should be hardcoded as`pkg/{name}/...`(see auto-memory`feedback_script_paths.md`). Don't derive them from `BASH_SOURCE`.

If a script genuinely needs bash, change its shebang/extension and note why.
