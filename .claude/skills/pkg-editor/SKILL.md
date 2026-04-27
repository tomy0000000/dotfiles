---
name: pkg-editor
description: Create or modify a pkg/{name}/ in this dotfiles repo. Use for both scaffolding new packages and editing existing ones (adding deps, splitting platforms, adding stow configs, rewiring Makefile targets).
---

# pkg-editor

Create or modify a dotfiles package under `pkg/`. Layout, shell, and stow conventions live in [`pkg/AGENTS.md`](../../../pkg/AGENTS.md) — read it before editing.

## Mode

- **Scaffold** — `pkg/{name}/` does not exist. Create the layout per `pkg/AGENTS.md`.
- **Edit** — `pkg/{name}/` exists. Read it first, then make the smallest change consistent with conventions.

## Required inputs

Ask if not provided (infer from existing files in edit mode):

- **name** — package slug. Prefix with `macos-` / `debian-` for platform-only packages.
- **platforms** — `macos`, `debian`, or both.
- **uses stow?** — ships config via a `stow/` subdir.
- **brew/apt packages** — what to install or change.
- **what to change** (edit mode) — the specific addition, removal, or rewire.

## Common edits

- **Add stow** — create `pkg/{name}/stow/` and wire the stow command into the relevant Makefile target.
- **Split platforms** — promote a platform-only package to cross-platform by adding the missing `{os}-{name}.sh` wrapper, the shared `{name}.sh`, and a root `Makefile` dispatch entry.
- **Rename / remove** — grep for references (`pkg/{name}`, `{name}:` targets, dispatch entries) before deleting.

## Makefile wiring

Add or update a target in the matching `makefiles/{os}.mk` under the right `###...###` section:

```makefile
macos-{name}: macos-brew macos-stow
	run "pkg/{name}/macos-{name}.sh"
```

Conventions (deps placement, no-op syntax, cross-platform dispatch) live in [`.claude/rules/pkg-makefile.md`](../../rules/pkg-makefile.md).

## After editing

1. Show the diff.
2. Print the Makefile target the user should run to install/reapply.
3. Invoke the `pkg-readme` skill to create or update `pkg/{name}/README.md` so it reflects the change.
4. Suggest running the `dotfiles-convention-reviewer` subagent on the changed files.
