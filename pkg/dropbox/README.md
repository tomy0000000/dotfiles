# `dropbox`

Installs the Dropbox desktop client for cloud file sync.

## Installs

| App / CLI | macOS         | Ubuntu          |
| --------- | ------------- | --------------- |
| Dropbox   | `brew --cask` | direct download |
| `dropbox` | —             | direct download |

## Configures

- No dotfiles or stow config — Dropbox manages its own state under `~/Dropbox`.

## Notes

- **Ubuntu**: the daemon binary lands at `~/.dropbox-dist/dropboxd`. Run it once
  to authenticate and link your account. The `dropbox` CLI (Python script at
  `/usr/local/bin/dropbox`) can then manage the daemon (`start`, `stop`,
  `status`, `ls`, etc.).
- **Ubuntu**: several Mesa/XCB libraries are installed as runtime dependencies
  before the daemon tarball is extracted.
- **macOS**: installed as a cask so it appears in `/Applications`; Homebrew is
  the only prerequisite (`macos-brew`).

## References

- [Dropbox - Install on Linux](https://www.dropbox.com/install-linux): Official headless Linux install instructions and CLI reference.
