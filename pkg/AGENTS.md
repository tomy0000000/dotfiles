# `.files/pkg`

## Package structure

Each package lives in `pkg/{name}/` and typically contains:

```
pkg/git/
├── macos-git.sh      # macOS-specific install (calls git.sh at end)
├── debian-git.sh     # Debian-specific install (calls git.sh at end)
├── git.sh            # Shared cross-platform setup
├── git.Brewfile      # Homebrew packages
├── git.Aptfile       # APT packages (one per line)
└── stow/             # Files to symlink into $HOME via stow
```

## Package scope

KISS: Keep It Simple Stupid. One target = One installation + one configuration setting.

## Idempotent

A package should be safe to run multiple times without causing issues. This will be tested by CI.

## Minimal dependencies

Avoid unnecessary dependencies between targets.

## Shell script conventions

All shell scripts must:

- Start with `#!/bin/bash` and `set -euo pipefail`
- Use `ln -sf` (force flag) for symlinks to ensure idempotency
- Use `exist <cmd> || <install>` pattern to guard installs (from `lib/exist.sh`)

## Install configs

If there's only one or two config files, default to symlink them directly with `ln -sf`. For larger config directories, use `stow` to manage the symlinks.

Use a `stow/` subdirectory for configs that need to be linked. Invoke stow as:

```bash
stow --no-folding --dir 'pkg/{name}' --target "${HOME}" 'stow'
```

`--no-folding` is required — it prevents stow from creating parent directory symlinks, linking individual files instead.

## Cross-platform pattern

Platform-specific scripts install packages then delegate to the shared script:

```bash
#!/bin/bash
set -euo pipefail
brew bundle --file pkg/git/git.Brewfile
bash pkg/git/git.sh
```

The shared `{name}.sh` handles config that is identical across platforms.

## Point Over Link

When the tool supports configuring global config path, point it to the config file in this repo instead of symlinking/stowing it to some other location. This way, we can avoid the complexity of managing symlinks and stow, and directly use the config files from the repo.

e.g. By setting `ZDOTDIR` in `.zshenv`, we don't have to stow the entire `zsh` config dir to home directory.

## Prevent Hardcoding paths

Although it is generally assumed that the repo is cloned to `~/dotfiles`, we should avoid hardcoding paths in scripts. Instead, use derived absolute paths anchored to the script's location or environment variables. This makes the setup more flexible and less prone to breakage if the repo is moved.

## macOS-specific packages

Packages prefixed `macos-` are macOS-only. Use `defaults write` / `defaults import` for preference files and `duti` for file-type associations.
