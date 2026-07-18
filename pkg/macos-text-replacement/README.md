# `macos-text-replacement`

Imports the System Settings text replacements (Keyboard > Text Input > Text Replacements) from a checked-in JSON file.

## Configures

- `defaults import NSGlobalDomain` of the `NSUserDictionaryReplacementItems` key, rebuilt from `text-replacement.json`

## Notes

- `text-replacement.json` is the source of truth: an array of `{shortcut, phrase}` objects, one per line. Edit it, then rerun the target. `plutil` reads it natively, so no `jq` is needed.
- A list (not a map) so duplicate shortcuts are kept (e.g. `ue`, `xkff`).
- `on` is always `1`, so it is omitted from the source and injected at import time.
- Only the one key is replaced: the rest of `NSGlobalDomain` is preserved via export/import.
- Shortcuts must be alphanumeric. macOS matches a shortcut as a word-bounded token, so punctuation-only ones (e.g. `->`) are stored but never trigger.
- Changes activate after a log out / log in: the running substitution engine does not hot-reload the list.
