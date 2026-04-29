# `brew`

Installs Homebrew, a core set of GNU/POSIX CLI replacements, and configures
shorthand aliases for common Homebrew commands.

## Installs

| CLI         | macOS  | Debian |
| ----------- | ------ | ------ |
| `coreutils` | `brew` | —      |
| `curl`      | `brew` | —      |
| `findutils` | `brew` | —      |
| `gettext`   | `brew` | —      |
| `gnu-sed`   | `brew` | —      |
| `gnu-tar`   | `brew` | —      |
| `grep`      | `brew` | —      |
| `make`      | `brew` | —      |
| `moreutils` | `brew` | —      |
| `rename`    | `brew` | —      |
| `stow`      | `brew` | —      |
| `tree`      | `brew` | —      |
| `wget`      | `brew` | —      |

## Configures

- `~/.brew-aliases/` (stow) — Homebrew external-command aliases:

  | Alias          | Expands to                                                     |
  | -------------- | -------------------------------------------------------------- |
  | `brew c`       | `brew cleanup`                                                 |
  | `brew exist`   | `brew list -1 \| grep`                                         |
  | `brew f`       | `brew info`                                                    |
  | `brew i`       | `brew install`                                                 |
  | `brew ls-font` | `brew list -1 \| grep ^font-`                                  |
  | `brew od`      | `brew outdated`                                                |
  | `brew refresh` | `brew update && brew outdated && brew upgrade && brew cleanup` |
  | `brew ri`      | `brew reinstall`                                               |
  | `brew s`       | `brew search`                                                  |
  | `brew t`       | `brew tap`                                                     |
  | `brew u`       | `brew uninstall`                                               |

- Starts `brew autoupdate` service (every 12 hours via `domt4/autoupdate` tap)

## Notes

- macOS-only; this package is the package manager itself and is a prerequisite
  for nearly every other `macos-*` target.
- `brew autoupdate start 43200` keeps packages up to date in the background
  without manual `brew upgrade` runs.

## References

- [Homebrew](https://brew.sh/): Official Homebrew installation and documentation.
- [domt4/homebrew-autoupdate](https://github.com/domt4/homebrew-autoupdate): Third-party tap that provides the `brew autoupdate` service.
