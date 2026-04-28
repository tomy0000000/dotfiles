# `zsh`

Sets up Zsh as the default shell, bootstraps zinit for plugin management, and
wires all dotfiles through a `ZDOTDIR`-based configuration tree.

## Installs

| CLI     | macOS  | Debian |
| ------- | ------ | ------ |
| `zsh`   | `brew` | `apt`  |
| `zinit` | `brew` | script |
| `curl`  | `brew` | —      |

## Configures

- `~/.zshenv` (symlinked) — bootstraps `ZDOTDIR` and XDG base directories
- `$ZDOTDIR` → `~/.dotfiles/pkg/zsh` — all remaining config is loaded from the
  repo directly; only `.zshenv` itself lands in `$HOME`
- `$EDITOR` auto-detected: `cursor --wait` → `code --wait` → `subl --wait`
- Sets XDG base directories (`XDG_CONFIG_HOME`, `XDG_DATA_HOME`, etc.)
- Dracula theme colors applied to Docker BuildKit output and `grep` matches
- zinit plugins: Oh My Zsh libraries + `zsh-autosuggestions`,
  `zsh-syntax-highlighting`, `zsh-you-should-use`
- Tool integrations loaded via zinit snippets: carapace, direnv, mise,
  starship, zoxide
- Default shell changed to Homebrew Zsh on macOS; system Zsh on Debian

### Aliases

| Alias  | Replaces | Original preserved as |
| ------ | -------- | --------------------- |
| `rm`   | `trash`  | `orm`                 |
| `cat`  | `ccat`   | `ocat`                |
| `less` | `cless`  | `oless`               |
| `sed`  | `gsed`   | `msed`                |

### Custom functions

| Function    | Description                                              |
| ----------- | -------------------------------------------------------- |
| `benchmark` | Runs 10 timed `zsh -i -c exit` measurements              |
| `dns_purge` | Flushes the macOS DNS cache (`dscacheutil -flushcache`)  |
| `kill_port` | Kills the process listening on a given port              |
| `path`      | Prints `$PATH` entries one per line                      |
| `fpath`     | Prints `$FPATH` entries one per line                     |
| `manpath`   | Prints `$MANPATH` entries one per line                   |
| `realcmd`   | Resolves a command name to its actual binary path        |
| `reset_zsh` | Clears zcompdump, fixes permissions, wipes zinit plugins |

## Notes

- Only `~/.zshenv` is symlinked into `$HOME`. Everything else is sourced
  through `$ZDOTDIR`, so no stow pass is needed for the config files.
- On macOS the Homebrew Zsh binary is added to `/etc/shells` before `chsh` so
  the system accepts it as a valid login shell.
- On Debian, an existing `~/.zshenv` is backed up to `~/.zshenv.bk` rather
  than overwritten.

## References

- [zdharma-continuum/zinit](https://github.com/zdharma-continuum/zinit): Plugin
  manager used to load Oh My Zsh libraries and community plugins without a full
  OMZ installation.
- [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/latest/):
  Defines `XDG_CONFIG_HOME`, `XDG_DATA_HOME`, etc., all set in `.zshenv` so
  every tool shares a consistent directory layout.
