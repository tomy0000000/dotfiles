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
3. Mirror the shape of existing READMEs (`pkg/git/README.md`, `pkg/zsh/README.md`) — don't invent a new structure.

## Output shape

```markdown
# `{name}`

One-sentence purpose.

## Installs

- Brew: `<pkg>`, `<pkg>` (`{name}.Brewfile`)
- APT: `<pkg>` (`{name}.Aptfile`)
- mise / other: …

## Configures

- `~/.foo` (stow)
- `defaults write com.example.App ...`
- File-type associations via `duti`
```

## Rules

- Factual. No marketing prose, no emoji.
- Omit sections that don't apply.
- Reference files by path (`pkg/{name}/{name}.sh`) so readers can jump in.
- Keep under ~40 lines unless the package is genuinely complex.
