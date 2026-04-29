# `docker`

Installs Docker Desktop and Hadolint (Dockerfile linter) on macOS.

## Installs

| Tool       | macOS  | Debian |
| ---------- | ------ | ------ |
| `docker`   | `brew` | —      |
| `hadolint` | `brew` | —      |

> Docker Desktop is installed as a cask; `hadolint` is a Homebrew formula.

## Configures

No configuration files are managed by this package.

## Notes

- macOS only — no Debian target exists.
- Invoke via `make macos-docker`.
- Docker Desktop bundles `docker`, `docker compose`, and the Docker daemon; no separate CLI install is needed.
- `hadolint` lints Dockerfiles against best practices and the official Dockerfile reference.
