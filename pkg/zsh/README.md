# `zsh`

Installs Zsh and Zinit, sets Zsh as the default shell, and symlinks the dotfiles-managed config tree via `ZDOTDIR`.

## Installs

| CLI     | macOS  | Ubuntu        |
| ------- | ------ | ------------- |
| `zsh`   | `brew` | `apt`         |
| `zinit` | `brew` | `curl` script |
| `curl`  | `brew` | —             |

## Configures

### Shell bootstrap

- Default shell changed to Homebrew zsh (macOS) or `/usr/bin/zsh` (Ubuntu)
- `~/.zshenv` → `.dotfiles/pkg/zsh/.zshenv` (manual symlink — the only file outside the repo)

### `.zshenv`

- Sets `ZDOTDIR=~/.dotfiles/pkg/zsh` so all subsequent config files are read directly from the repo
- Exports XDG Base Directory vars: `XDG_CONFIG_HOME`, `XDG_DATA_HOME`, `XDG_STATE_HOME`, `XDG_CACHE_HOME`, `XDG_RUNTIME_DIR`
- `EDITOR` set to Cursor, VS Code, or Sublime Text depending on `$TERM_PROGRAM` / `$IS_CURSOR`
- Dracula color theme applied to `grep` output and Docker BuildKit (`$BUILDKIT_COLORS`)
- Oh My Zsh behavior flags: `HYPHEN_INSENSITIVE`, `COMPLETION_WAITING_DOTS`, `ENABLE_CORRECTION`, `HIST_STAMPS`

### `.zshrc`

- Loads Zinit (from Homebrew prefix on macOS, `$XDG_DATA_HOME/zinit` on Ubuntu)
- OMZ library snippets (no full OMZ install): `clipboard`, `completion`, `correction`, `directories`, `functions`, `git`, `history`
- Tool integrations: carapace, direnv, mise, starship, zoxide
- OMZ plugins: `colored-man-pages`, `colorize`, `command-not-found`, `gnu-utils`, `kubectl`, `macos`, `rbenv`, `thefuck`
- Third-party plugins: `zsh-autosuggestions`, `zsh-syntax-highlighting`, `zsh-you-should-use`
- Completions wired for: carapace, Docker, kubectl, gt, mise, 1Password CLI, Poetry, Starship
- Alias groups: replacement (`rm`→`trash`, `cat`→`ccat`, `sed`→`gsed`), configs, docker, editors, kubectl, npm, pip, xattr

### `.zfunc/`

Custom autoloaded functions:

| Function    | Description                                               |
| ----------- | --------------------------------------------------------- |
| `benchmark` | Times 10 interactive Zsh startups via `/usr/bin/time`     |
| `dns_purge` | Flushes DNS cache (`dscacheutil -flushcache`, macOS only) |
| `fpath`     | Prints `$FPATH` entries one per line                      |
| `kill_port` | Kills the process bound to a given port via `pnpm dlx`    |
| `manpath`   | Prints `$MANPATH` entries one per line                    |
| `path`      | Prints `$PATH` entries one per line                       |
| `realcmd`   | Resolves the real path of a command                       |
| `reset_zsh` | Fixes `compaudit` permissions, clears caches, wipes Zinit |

## Notes

- On macOS, Homebrew zsh is added to `/etc/shells` before `chsh`; skipped in CI (`$CI` set).
- On Ubuntu, an existing `~/.zshenv` is backed up to `~/.zshenv.bk` before symlinking.
- `reset_zsh` fixes `compaudit` permission warnings, clears `~/.zcompdump*`, and deletes all compiled Zinit plugins — useful when completion breaks after a plugin update.
- `kill_port <port>` delegates to `pnpm dlx kill-port`; requires `pnpm` to be available.

## References

- [Zinit - README](https://github.com/zdharma-continuum/zinit): Plugin manager used instead of a full Oh My Zsh install; explains `light-mode`, `lucid`, `wait`, and `snippet` loading modes.
- [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/latest/): Defines the env vars set in `.zshenv` that many tools use to locate config/cache/data directories.
