# `mise`

Installs the [mise](https://mise.jdx.dev/) version manager and ships a global tool manifest.

## Installs

| Tool   | macOS  | Debian |
| ------ | ------ | ------ |
| `mise` | `brew` | `apt`  |

## Configures

- `~/.config/mise/config.toml` — symlinked to `pkg/mise/config.toml`: pins `go`, `node`, `python`, `uv`, `pnpm`, `yarn`, plus npm/pipx tools (prettier plugins, ansible, ruff, poetry, pre-commit, etc.)
