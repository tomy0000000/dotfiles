# `macos-appcleaner`

Installs AppCleaner and imports its stored preferences.

## Installs

| App          | macOS  | Debian |
| ------------ | ------ | ------ |
| `appcleaner` | `brew` | —      |

## Configures

- `ProtectOpenedApps = false` — allows removing apps that are currently running
- `ShowProtectedApps = true` — protected apps remain visible in the UI

## Notes

- macOS only; no Debian equivalent.
- The plist captures AppCleaner's settings so they are restored on every fresh install.

## References

- [AppCleaner](https://freemacsoft.net/appcleaner/): Official site for the AppCleaner app.
