# `zsh`

Zsh installation, Zinit-managed plugin stack, XDG-compliant dotfiles, and a
collection of aliases, completions, and utility functions.

## Installs

| Tool    | macOS  | Debian |
| ------- | ------ | ------ |
| `zsh`   | `brew` | `apt`  |
| `zinit` | `brew` | curl   |
| `curl`  | `brew` | —      |

## Configures

- `~/.zshenv` — symlinked to `pkg/zsh/.zshenv`; sets `ZDOTDIR` so all
  remaining dotfiles are loaded from the repo rather than `$HOME`
- `~/.dotfiles/pkg/zsh/.zshrc` — sources Zinit, Oh My Zsh libraries, plugins,
  tool integrations, completions, and aliases
- `~/.dotfiles/pkg/zsh/.zprofile` — login-shell PATH bootstrap
- XDG Base Directory variables (`XDG_DATA_HOME`, `XDG_CONFIG_HOME`,
  `XDG_CACHE_HOME`, `XDG_STATE_HOME`, `XDG_RUNTIME_DIR`)
- `EDITOR` — set to `cursor`, `code`, or `subl` depending on `$TERM_PROGRAM`
- Default shell changed to Homebrew zsh (macOS) or system zsh (Debian)

### Zinit plugins

| Plugin                           | Source              | Purpose                           |
| -------------------------------- | ------------------- | --------------------------------- |
| Oh My Zsh libraries              | `OMZL::`            | history, directories, git helpers |
| `colored-man-pages`, `colorize`  | `OMZP::`            | syntax-highlighted man / cat      |
| `command-not-found`, `gnu-utils` | `OMZP::` (deferred) | better not-found suggestions      |
| `macos`                          | `OMZP::`            | macOS-specific shell utilities    |
| `thefuck`                        | `OMZP::`            | `fuck` command + ESC-ESC binding  |
| `zsh-you-should-use`             | community           | reminds when an alias exists      |
| `zsh-autosuggestions`            | community           | fish-style inline suggestions     |
| `zsh-syntax-highlighting`        | community           | real-time command highlighting    |

### Tool integrations

`carapace`, `direnv`, `mise`, `starship`, `zoxide` — each sourced via a
dedicated snippet in `pkg/zsh/tools/`.

### Completions

Completions are loaded for: `carapace`, `docker`, `gt`, `kubectl`, `mise`,
`op` (1Password), `poetry`, `starship`.

### Aliases

| File              | Notable aliases                                |
| ----------------- | ---------------------------------------------- |
| `replacement.zsh` | `rm` → `trash`, `cat` → `ccat`, `sed` → `gsed` |
| `configs.zsh`     | `zshrc`, `gitconfig`, `sshconfig`, `hosts`     |
| `docker.zsh`      | Docker / Compose shortcuts                     |
| `editors.zsh`     | `markedit`, `typora`, `xcode`                  |
| `kubectl.zsh`     | kubectl shortcuts                              |
| `npm.zsh`         | npm / pnpm shortcuts                           |
| `pip.zsh`         | pip shortcuts                                  |
| `xattr.zsh`       | macOS extended-attribute helpers               |

### Custom functions (`~/.zfunc/`)

| Function    | Purpose                                                           |
| ----------- | ----------------------------------------------------------------- |
| `benchmark` | Runs `zsh -i -c exit` 10 times to measure startup                 |
| `dns_purge` | Flushes the macOS DNS cache                                       |
| `fpath`     | Prints `$fpath` entries one per line                              |
| `kill_port` | Kills the process listening on a given port                       |
| `manpath`   | Prints `$MANPATH` entries one per line                            |
| `path`      | Prints `$PATH` entries one per line                               |
| `realcmd`   | Resolves a command to its true binary path                        |
| `reset_zsh` | Fixes completion permissions, clears caches, purges zinit plugins |

## Notes

- `ZDOTDIR` is set in `~/.zshenv` so Zsh loads config from the repo directory
  instead of `$HOME`; all subsequent dotfiles live under
  `~/.dotfiles/pkg/zsh/`.
- On macOS the Homebrew-managed zsh is added to `/etc/shells` and set as the
  login shell; the system zsh at `/bin/zsh` is untouched.
- Dracula-theme color codes are exported for `grep` output and Docker BuildKit.
- The `replacement.zsh` aliases are guarded with `command -v` checks so they
  only activate when the replacement tool is installed.

## References

- [Zinit](https://github.com/zdharma-continuum/zinit): Plugin manager used for all Oh My Zsh and community plugins
- [Oh My Zsh — Settings](https://github.com/ohmyzsh/ohmyzsh/wiki/Settings): Documents `HYPHEN_INSENSITIVE`, `HIST_STAMPS`, and other exported variables
- [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/latest/): Canonical reference for `XDG_*` variables set in `.zshenv`
