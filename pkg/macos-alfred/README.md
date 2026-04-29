# `macos-alfred`

Installs Alfred and frees the `⌘ Space` shortcut by disabling Spotlight's
keyboard shortcuts.

## Installs

| App    | macOS         | Debian |
| ------ | ------------- | ------ |
| Alfred | `brew --cask` | —      |

## Configures

- `defaults write com.apple.symbolichotkeys` — disables **Show Spotlight
  search** (hotkey 64) and **Show Finder search window** (hotkey 65) so Alfred
  can claim `⌘ Space`
- Reloads symbolic hotkeys immediately via
  `activateSettings -u` (no logout required)

## Notes

- Alfred preferences and workflows are managed manually inside the app; nothing
  here is synced via stow.
- The Spotlight shortcut change takes effect immediately without a reboot or
  logout.

## References

- [Zameerman Janji — Applying com.apple.symbolichotkeys changes instantaneously](https://zameermanji.com/blog/2021/6/8/applying-com-apple-symbolichotkeys-changes-instantaneously/): explains why `activateSettings -u` is needed to apply `com.apple.symbolichotkeys` changes without logging out.
