# `macos-settings`

Applies System Settings preferences on macOS through `defaults` and `pmset`.

## Configures

- Sound: volume change feedback
- Software Update: automatic check, download, macOS install, and system data and security updates
- Language & Region: English (US), Chinese Traditional (Taiwan)
- Appearance: scroll bars shown when scrolling
- Accessibility: scroll-to-zoom with modifier key, three finger drag
- Dock & Mission Control: magnification, no recents, no auto-rearranged Spaces, hot corners
- Lock Screen: screen saver after 5 minutes, display sleep via `pmset`
- Keyboard: 🌐 key dictation, per-app shortcuts (Brave, PDF Expert, Photos, Typora), Caps Lock input switching, no smart quotes and dashes
- Trackpad: swipe between pages, App Exposé gesture
- Restarts affected apps and reloads keyboard shortcuts with `activateSettings`

## Notes

- Requires Full Disk Access for the terminal, `sudo`, and a keypress at start, so it is not suitable for CI.
- The Mission Control, Keyboard, Services and Accessibility keyboard shortcut groups are still `TODO` in the script.

## References

- [mathiasbynens/dotfiles - .macos](https://github.com/mathiasbynens/dotfiles/blob/master/.macos): Main source of `defaults` keys
- [mathiasbynens/dotfiles - issue 820](https://github.com/mathiasbynens/dotfiles/issues/820#issuecomment-498324762): Why the terminal needs Full Disk Access
- [Applying com.apple.symbolichotkeys changes instantaneously](https://zameermanji.com/blog/2021/6/8/applying-com-apple-symbolichotkeys-changes-instantaneously/): Source of the `activateSettings` reload
