---
paths:
  - "pkg/**"
---

# pkg: default handlers via duti

Default app handlers are set with `duti -s <bundle-id> <target> [role]`. URL schemes take no role (`duti -s com.googlecode.iterm2 ssh`); MIME types and extensions take a role: `all`, `editor`, `shell`, or `viewer`. Prefer a MIME mapping over an extension mapping when both would work.

- Each app's duti lines live in that app's own package script (e.g. iTerm handlers in `pkg/macos-iterm/macos-iterm.sh`, VSCode in `pkg/vscode/macos-vscode.sh`), grouped under a `# Default file handlers (duti)` comment.
- `pkg/macos-file-handler/macos-file-handler.sh` holds only handlers for apps that have no package yet: Apple built-ins (iCal, FaceTime, ScreenSharing), plus Transmit, IINA, and the default-browser block. When one of those apps gets its own package, move its lines there.
- Any package script that calls `duti` must depend on `macos-duti` in its Makefile target (`macos-{name}: macos-brew macos-duti`), so duti is installed first.
- For an app that isn't installed by default (e.g. Microsoft Remote Desktop for `rdp`, Brave for `text/html`), leave the mapping commented out as a breadcrumb rather than deleting it.
- Add a `# Note:` comment when a mapping is set against the tool's actual behavior (e.g. Transmit set for `smb`/`nfs`/`afp` even though it doesn't mount them like Finder).
- Guard the default-browser block in `macos-file-handler.sh` behind `${CI:-}`: http/https can't be set via duti, and `defaultbrowser` triggers a GUI confirmation prompt that hangs CI.
- Keep the UTI/MIME reference gist and the `defaults export com.apple.LaunchServices ... | jq` inspection command comments at the top of `macos-file-handler.sh`.

Why: colocating a handler with the app that owns it keeps each package self-contained. `macos-file-handler` is only the fallback for apps that don't have a home yet.
