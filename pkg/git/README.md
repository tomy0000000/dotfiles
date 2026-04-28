# `git`

Git installation and opinionated global configuration with aliases, SSH commit signing, and sensible modern defaults.

## Installs

| Tool                     | macOS  | Debian |
| ------------------------ | ------ | ------ |
| `git`                    | `brew` | `apt`  |
| `git-delta`              | `brew` | —      |
| `git-extras`             | `brew` | `apt`  |
| `git-credential-manager` | `brew` | —      |
| `gpg-suite-no-mail`      | `brew` | —      |

## Configures

- `~/.gitconfig` — symlinked to `pkg/git/.gitconfig` via `ln -sf`
- `~/.dotfiles/pkg/git/.gitignore` — global ignore rules for macOS, Xcode, Dropbox, and VS Code artifacts
- `~/.dotfiles/pkg/git/.gitattributes` — global line-ending normalization (`text=auto`, CRLF for `.bat`/`.cmd`, LF for `.sh`)
- `~/.dotfiles/pkg/git/.git_commit_template` — Conventional Commits prompt template used for every new commit
- `~/.dotfiles/pkg/git/alias.gitconfig` — extensive alias set
- `~/.dotfiles/pkg/git/github-tomy0000000.gitconfig` — user identity and SSH commit signing via 1Password, applied automatically for any GitHub remote
- `~/.dotfiles/pkg/git/custom/custom.gitconfig` — optional machine-local overrides (not tracked)

### Notable defaults

| Setting                                          | Value            | Effect                                         |
| ------------------------------------------------ | ---------------- | ---------------------------------------------- |
| `branch.sort`                                    | `-committerdate` | Most recently used branches first              |
| `diff.algorithm`                                 | `histogram`      | Fewer spurious diff hunks                      |
| `merge.conflictstyle`                            | `zdiff3`         | Shows common ancestor in conflict markers      |
| `fetch.prune` / `pruneTags` / `all`              | `true`           | Auto-clean stale remote refs on every fetch    |
| `push.autoSetupRemote`                           | `true`           | No need for `-u origin <branch>` on first push |
| `rebase.autoSquash` / `autoStash` / `updateRefs` | `true`           | Stacks-friendly interactive rebase             |
| `help.autocorrect`                               | `prompt`         | Prompts before running corrected command       |
| `init.defaultBranch`                             | `main`           |                                                |

## Notes

- SSH commit signing is macOS-only; it delegates to `1Password.app` for key access.
- `allowed-signers.txt` is the local SSH allowed-signers file used by `gpg.ssh.allowedSignersFile`.
- The `custom/custom.gitconfig` include path is not tracked — place machine-specific overrides there.
- `git-delta` (macOS only) is installed but not wired to `core.pager` in `.gitconfig`; configure it in `custom.gitconfig` if desired.

## References

- [git-tips-2-new-stuff-in-git - GitButler Blog](https://blog.gitbutler.com/git-tips-2-new-stuff-in-git#some-git-branch-stuff): `branch.sort`, `column.ui` tips
- [how-git-core-devs-configure-git - GitButler Blog](https://blog.gitbutler.com/how-git-core-devs-configure-git/): Source for histogram diff, zdiff3, fetch/push/rebase defaults
- [gitignore.io](https://www.toptal.com/developers/gitignore): Generator used by the `gen-ignore` alias
