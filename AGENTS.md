# CLAUDE.md

This file provides guidance when working with code in this repository.

## Repo purpose

Personal dotfiles and provisioning scripts for fresh macOS and Ubuntu/Debian machines. Entry points are `install.sh` (bootstrap clone) and `make {feature}` (per-feature install).

## Common commands

- `make` (no args): runs `$(OS)` target, which expands to `macos` or `ubuntu` based on `lib/distro.sh`. Equivalent to `make core`.
- `make {feature}`: install one feature. The root `Makefile` dispatches `{feature}: $(OS)-{feature}` so callers do not pass the OS prefix.
- `make {os}-{feature}`: invoke a platform-specific recipe directly (e.g. `make macos-git`).
- CI lives in `.github/workflows/test_macos.yml` and `.github/workflows/test_ubuntu.yml`. Each runs the matching `make {feature}` for every entry in its matrix on a clean runner.

## Architecture

### Makefile dispatch and the `run` library

`Makefile` sets `SHELL = $(ROOT_DIR)/bin/make-shell`. That wrapper sources every file in `lib/*.sh` before executing the recipe, so all recipe lines have access to the helpers in `lib/` (`run`, `log_info`, `exist`, `distro`, `abs_brew`) without explicit sourcing.

Recipes follow one shape:

```makefile
macos-{name}: macos-brew macos-stow
	run "pkg/{name}/macos-{name}.sh"
```

`run "path"` (defined in `lib/log.sh`) prints a BEGIN/END divider around the script and sources it in a subshell so its `log_*` calls share configuration. Scripts invoked via `run` therefore do **not** re-source `lib/log.sh`. `install.sh` is the exception — it runs before the Makefile and sources the libs it needs explicitly.

Cross-platform features get a dispatch entry in the root `Makefile` (`{name}: $(OS)-{name}`) and per-OS recipes in `makefiles/{os}.mk`. Single-OS features (e.g. `macos-finder`) live only in the matching mk file with no dispatch entry.

### `pkg/` layout

Each feature is a self-contained directory under `pkg/`. Naming:

- Cross-platform: `pkg/{name}/` (e.g. `pkg/git/`).
- Single-OS: `pkg/{os}-{name}/` (e.g. `pkg/macos-settings/`).
- Cross-platform script: `pkg/{name}/{name}.sh` (shared logic).
- Platform script: `pkg/{name}/{os}-{name}.sh` — installs OS packages, then delegates to the shared script via `bash pkg/{name}/{name}.sh`.
- Stow dir (when needed): `pkg/{name}/stow/`. Always invoke as `stow --no-folding --dir 'pkg/{name}' --target "${HOME}" 'stow'` — `--no-folding` is required so stow links files instead of parent directories.

`pkg/AGENTS.md` and `lib/AGENTS.md` document the conventions in more detail and should be treated as authoritative when in conflict with this file.

### Shell script conventions

- `#!/bin/bash` and `set -euo pipefail`.
- Idempotent: guard installs with `exist <cmd> || <install>` (from `lib/exist.sh`); use `ln -sf` for symlinks.
- Scripts run from the repo root (the `Makefile` and `make-shell` `cd` there). Use repo-root-relative paths like `pkg/git/git.sh` directly: do **not** derive paths from `BASH_SOURCE`.
- Brewfile/Aptfile only when there are 2+ packages. A single package goes inline as `brew install <pkg>` / `apt-get install -y <pkg>` in the platform script — no manifest file.
- Prefer "point over link": when a tool supports a custom config path (e.g. `ZDOTDIR`), point it at the file in the repo instead of stowing it.

## Rules in `.claude/rules/`

When editing in scoped areas, the rules file applies in addition to this document:

- `.claude/rules/pkg-layout.md` (paths: `pkg/**`): directory and file naming.
- `.claude/rules/package-managers.md` (paths: `pkg/**/*.sh`, `*.Brewfile`, `*.Aptfile`): single vs bundled installs.
- `.claude/rules/makefile.md`: target shape, deps on the target line, `###` group dividers, no-op trailing `;`.
- `.claude/rules/ci.md`: when adding/renaming a Makefile target, update the matching CI matrix in the same change. Cross-platform → both `test_macos.yml` and `test_ubuntu.yml`; OS-specific → just the matching one. Keep alphabetized; comment-out with a `# Reason` when a target cannot run on CI.

## Git commit / PR title template

Subject line format: `{emoji} [{type}][{scope}] {message}`. Scope is the `pkg/{name}` feature; omit it for repo-wide changes (`{emoji} [{type}] {message}`). Keep messages in the imperative.

| Emoji | Type    | When to use                                       |
| ----- | ------- | ------------------------------------------------- |
| ✨    | `feat`  | New feature, package, or capability.              |
| 🛠    | `fix`   | Bug fix in an existing script or config.          |
| 📖    | `docs`  | README/AGENTS.md/comment-only changes.            |
| 🗄    | `chore` | Maintenance: skills, agent rules, config refresh. |
| 🎛    | `ci`    | GitHub Actions workflows or CI matrix entries.    |
| 🕺🏻    | `style` | Formatting only, no logic.                        |

Examples (from the existing log):

```
✨ [feat][starship] Seperate from `zsh`
🛠 [fix][ai-config] Install skills
📖 [docs][javascript] README
🗄 [chore] Agent rules
🎛 [ci] Add missing package
```

## Prose conventions

Enforced for commit messages, PR descriptions, READMEs, code comments. No em dashes, no semicolons in prose, use colons for list lead-ins.
