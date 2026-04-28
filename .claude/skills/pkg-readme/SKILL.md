---
name: pkg-readme
description: Draft or update pkg/{name}/README.md in this dotfiles repo — summarizes what the package installs, what it configures, and how to invoke it via make.
---

# pkg-readme

Generate or update `pkg/{name}/README.md`.

## Input

- **name** — the package directory, e.g. `git`, `zsh`, `macos-finder`.

## Procedure

1. Read `pkg/{name}/` for:
   - `*.Brewfile` / `*.Aptfile` — list of installed tools.
   - `{name}.sh`, `{os}-{name}.sh` — scan for `defaults write`, `defaults import`, `duti -s`, `ln -sf`, stow invocations, mise/pipx/npm installs.
   - `stow/` contents — files symlinked into `$HOME`.
2. Read `makefiles/{os}.mk` for the `{os}-{name}` target and its dependencies.
3. Populate from the following template.
4. Format the markdown with `prettier`.

## Output template

```markdown
# `{name}`

One-sentence purpose.

## Installs

| CLI       | macOS  | Debian |
| --------- | ------ | ------ |
| `<cli-1>` | `brew` | `apt`  |
| `<cli-n>` | `brew` | `apt`  |

## Configures

- `~/.foo` (stow)
- `defaults write com.example.App ...`
- File-type associations via `duti`

## Notes

- TODOs
- Worth Noting

## References

- [<site> - <page>](url): Why this reference is important to be noted here
```
