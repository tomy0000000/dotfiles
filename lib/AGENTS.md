# `.files/lib`

## Available libraries

| File         | Purpose                      | Key API                                                |
| ------------ | ---------------------------- | ------------------------------------------------------ |
| `log.sh`     | Logging and script execution | `log_debug/info/warn/error`, `run "path"`, `die "msg"` |
| `exist.sh`   | Command existence check      | `exist <cmd>`                                          |
| `distro.sh`  | OS detection                 | `distro` → `macos`, `ubuntu`, `debian`, …              |
| `brew.sh`    | Homebrew path detection      | `abs_brew` → resolves Intel vs ARM path                |
| `realcmd.sh` | Real path of a command       | `realcmd <cmd>` → resolves shims and symlinks          |

## Usage

All libraries are automatically sourced for all scripts invoked via the Makefile's `run` helper (through `bin/make-shell`), so library functions are available without explicit sourcing in those scripts.

The interactive shell opts into a named subset via `_lib_lazy` in `pkg/zsh/.zshrc`, which stubs each function and sources its file on first call. It belongs in `.zshrc` rather than `.zshenv`: these are prompt conveniences, and `.zshenv` would define them for every non-interactive `zsh -c` too. Only register a function there when it is useful at the prompt.

## Adding a new library

- Single responsibility: one concern per file
- Zero dependencies on other `lib/` files
- Open with the two guards every existing lib uses:

  ```bash
  # Source guard: Exit if executed directly
  (return 0 2>/dev/null) || exit 0

  # Idempotent import: Prevent multiple imports
  [ "${__NAME_SH_LOADED:-}" = "1" ] && return 0
  __NAME_SH_LOADED=1
  ```

- Define functions only. Nothing should run or print at source time. Configuration defaults set with `: "${VAR:=default}"` are fine (see `log.sh`)

### Keep it zsh-safe

Libraries reach an interactive zsh through `_lib_lazy`, not just bash recipes, so they must behave in both shells.

- Declare every function variable with `local`, or it leaks into the calling shell
- Never name a variable `path`, `fpath`, `cdpath`, `manpath`, `argv`, or `status`. zsh ties those to special parameters, so a plain `path="$2"` replaces the caller's `PATH` and every external command disappears. This bit `log.sh` and is invisible in bash, which does not tie them
- Do not use `BASH_SOURCE`, it does not exist in zsh
