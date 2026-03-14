# `.files/lib`

## Available libraries

| File        | Purpose                      | Key API                                                |
| ----------- | ---------------------------- | ------------------------------------------------------ |
| `log.sh`    | Logging and script execution | `log_debug/info/warn/error`, `run "path"`, `die "msg"` |
| `exist.sh`  | Command existence check      | `exist <cmd>`                                          |
| `distro.sh` | OS detection                 | `distro` → `macos`, `ubuntu`, `debian`, …              |
| `brew.sh`   | Homebrew path detection      | `abs_brew` → resolves Intel vs ARM path                |

## Usage

All libraries are automatically sourced for all scripts invoked via the Makefile's `run` helper (through `bin/make-shell`), so library functions are available without explicit sourcing in those scripts.

## Adding a new library

- Single responsibility — one concern per file
- No side effects on source: guard executable logic with `if [[ "${BASH_SOURCE[0]}" == "${0}" ]]`
- Zero dependencies on other `lib/` files
