# `core`

Bootstraps the foundational CLI tools required by the rest of the dotfiles setup.

## Installs

| CLI    | macOS | Debian |
| ------ | ----- | ------ |
| `curl` | —     | `apt`  |
| `git`  | —     | `apt`  |
| `make` | —     | `apt`  |
| `sudo` | —     | `apt`  |
| `wget` | —     | `apt`  |

## Configures

Nothing — this package only installs system packages.

## Notes

- On macOS, `macos-core` is a meta-target with no script of its own; it simply chains `macos-brew`, `macos-stow`, and `macos-zsh`.
- On Debian/Ubuntu, `ubuntu-core` depends on `ubuntu-stow` and then installs packages from `core.Aptfile` via `apt-get`.
- `make core` dispatches automatically to `macos-core` or `ubuntu-core` based on the current OS.
