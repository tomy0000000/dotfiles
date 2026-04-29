# `macos-cleanshot`

Install and configure [CleanShot X](https://cleanshot.com), a macOS screenshot and screen recording tool.

## Installs

| App         | macOS  | Debian |
| ----------- | ------ | ------ |
| CleanShot X | `brew` | —      |

## Configures

- Disables all macOS built-in screenshot shortcuts (⌘⇧3, ⌃⌘⇧3, ⌘⇧4, ⌃⌘⇧4, ⌘⇧5) so CleanShot X can take them over
- Reloads macOS keyboard shortcut settings immediately without a logout
- Window screenshot background: transparent
- All-In-One capture shortcut: ⌘⇧1
- OCR / Capture Text shortcut: ⌘⇧6

## Notes

- Auto-detects the installed variant (standard `com.getcleanshot.app` vs. Setapp `com.getcleanshot.app-setapp`) via AppleScript
- CleanShot X is a paid app; a license is required after installation

## References

- [Applying com.apple.symbolichotkeys changes instantaneously](https://zameermanji.com/blog/2021/6/8/applying-com-apple-symbolichotkeys-changes-instantaneously/): How to reload macOS shortcut settings without logging out, using `activateSettings -u`
