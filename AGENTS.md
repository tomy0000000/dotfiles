# `.files`

## Naming conventions

| Element                  | Pattern                         | Example                         |
| ------------------------ | ------------------------------- | ------------------------------- |
| Makefile target          | `{os}-{feature}`                | `macos-git`, `ubuntu-zsh`       |
| Package directory        | `{feature}` or `{os}-{feature}` | `git`, `macos-settings`         |
| Cross-platform script    | `{name}.sh`                     | `git.sh`                        |
| Platform-specific script | `{os}-{name}.sh`                | `macos-git.sh`, `debian-git.sh` |
| Homebrew package list    | `{name}.Brewfile`               | `git.Brewfile`                  |
| APT package list         | `{name}.Aptfile`                | `git.Aptfile`                   |
| Stow directory           | `stow/`                         | Always named `stow/`            |

## Makefile structure

- Use `include makefiles/*.mk` to split platform-specific targets into `makefiles/macos.mk` and `makefiles/ubuntu.mk`
- A target should only have one single `run` command
- Group related targets with a `###...###` divider comment
- List target dependencies on the same line: `target: dep1 dep2`
- No-op targets use a trailing semicolon: `macos-nano: ;`
