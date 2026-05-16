# `cli-useful`

A curated set of general-purpose command-line utilities for macOS.

## Installs

| CLI         | macOS  | Debian |
| ----------- | ------ | ------ |
| `chroma`    | `brew` | —      |
| `thefuck`   | `brew` | —      |
| `trash-cli` | `brew` | —      |
| `watch`     | `brew` | —      |
| `fileicon`  | `brew` | —      |

## Configures

_Nothing — installs only._

## Notes

- macOS-only package; no Debian equivalent is configured.
- `thefuck` requires shell integration (e.g. `eval $(thefuck --alias)`) to be added to your shell rc separately.
- `trash-cli` provides a `trash` command as a safer alternative to `rm`; files go to the macOS Trash rather than being permanently deleted.
- `fileicon` is macOS-specific and relies on macOS file metadata APIs.

## References

- [chroma - GitHub](https://github.com/alecthomas/chroma): Fast general-purpose syntax highlighter in Go, useful for piping code through a colorizer.
- [thefuck - GitHub](https://github.com/nvbn/thefuck): Corrects the previous console command when you mistype it.
- [trash-cli - GitHub](https://github.com/ali-rantakari/trash): Moves files to Trash from the CLI instead of deleting them irreversibly.
- [watch - man page](https://linux.die.net/man/1/watch): Runs a command repeatedly and displays its output; macOS ships without it by default.
- [fileicon - GitHub](https://github.com/mklement0/fileicon): Sets and retrieves custom icons for macOS files and folders from the command line.
