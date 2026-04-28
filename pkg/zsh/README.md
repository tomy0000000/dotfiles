# `zsh`

Installs Zsh and Zinit, sets Zsh as the default shell, and symlinks the dotfiles-managed config tree via `ZDOTDIR`.

## Installs

| CLI     | macOS  | Ubuntu        |
| ------- | ------ | ------------- |
| `zsh`   | `brew` | `apt`         |
| `zinit` | `brew` | `curl` script |
| `curl`  | `brew` | —             |

## Configures

- `~/.zshenv` → `.dotfiles/pkg/zsh/.zshenv` (manual symlink; sets `ZDOTDIR` to redirect all subsequent config reads into the dotfiles tree)
- `ZDOTDIR=~/.dotfiles/pkg/zsh` — zsh reads `.zshrc`, `.zprofile`, `.zfunc/`, `.zalias/`, etc. directly from the repo
- Default shell changed to Homebrew zsh (macOS) or `/usr/bin/zsh` (Ubuntu)
- XDG Base Directory vars (`XDG_CONFIG_HOME`, `XDG_DATA_HOME`, …) exported in `.zshenv`
- `EDITOR` set to Cursor, VS Code, or Sublime Text depending on `$TERM_PROGRAM`
- Zinit loads a subset of Oh My Zsh libraries (no full OMZ install): `clipboard`, `completion`, `correction`, `directories`, `functions`, `git`, `history`
- OMZ plugins: `colored-man-pages`, `colorize`, `command-not-found`, `gnu-utils`, `kubectl`, `macos`, `rbenv`, `thefuck`
- Third-party plugins: `zsh-autosuggestions`, `zsh-syntax-highlighting`, `zsh-you-should-use`
- Tool integrations loaded via snippets: carapace, direnv, mise, starship, zoxide
- Completions wired for: carapace, Docker, kubectl, gt, mise, 1Password CLI, Poetry, Starship
- Alias groups: replacement (`rm`→`trash`, `cat`→`ccat`, `sed`→`gsed`), configs, docker, editors, kubectl, npm, pip, xattr
- Custom functions in `.zfunc/`: `benchmark`, `dns_purge`, `fpath`, `kill_port`, `manpath`, `path`, `realcmd`, `reset_zsh`
- Dracula color theme applied to `grep` output and Docker BuildKit

## Notes

- On macOS, Homebrew zsh is added to `/etc/shells` before `chsh`; skipped in CI (`$CI` set).
- On Ubuntu, an existing `~/.zshenv` is backed up to `~/.zshenv.bk` before symlinking.
- `reset_zsh` fixes `compaudit` permission warnings, clears `~/.zcompdump*`, and deletes all compiled Zinit plugins — useful when completion breaks after a plugin update.
- `kill_port <port>` delegates to `pnpm dlx kill-port`; requires `pnpm` to be available.

## References

- [Zinit - README](https://github.com/zdharma-continuum/zinit): Plugin manager used instead of a full Oh My Zsh install; explains `light-mode`, `lucid`, `wait`, and `snippet` loading modes.
- [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/latest/): Defines the env vars set in `.zshenv` that many tools use to locate config/cache/data directories.
