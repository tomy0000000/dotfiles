#!/bin/bash
set -euo pipefail

# System Settings > Keyboard > Text Input > Text Replacements.
#
# The replacement list is stored in NSGlobalDomain under
# NSUserDictionaryReplacementItems as an array of {on, replace, with} dicts.
# The source of truth is the sibling text-replacement.json: an array of
# {shortcut, phrase} objects (System Settings' own column names). To add or edit
# a replacement, edit that file (one object per line) and rerun this target.
# `on` is always 1 here, so it is omitted from the source and injected below.

source="pkg/macos-text-replacement/text-replacement.json"
KEY="NSUserDictionaryReplacementItems"

# Quit System Settings
osascript -e 'tell application "System Settings" to quit' 2>/dev/null || true

# Export the whole domain so we only touch the one key, then rebuild the array
# from the source file. plutil reads JSON natively, so no jq is needed.
TMP="$(mktemp -t macos-text-replacement).plist"
trap 'rm -f "${TMP}"' EXIT
defaults export NSGlobalDomain "${TMP}"

/usr/libexec/PlistBuddy -c "Delete :${KEY}" "${TMP}" 2>/dev/null || true
/usr/libexec/PlistBuddy -c "Add :${KEY} array" "${TMP}"

i=0
while shortcut="$(plutil -extract "${i}.shortcut" raw -o - "${source}" 2>/dev/null)"; do
    phrase="$(plutil -extract "${i}.phrase" raw -o - "${source}")"
    /usr/libexec/PlistBuddy -c "Add :${KEY}:${i} dict" "${TMP}"
    /usr/libexec/PlistBuddy -c "Add :${KEY}:${i}:on integer 1" "${TMP}"
    /usr/libexec/PlistBuddy -c "Add :${KEY}:${i}:replace string ${shortcut}" "${TMP}"
    /usr/libexec/PlistBuddy -c "Add :${KEY}:${i}:with string ${phrase}" "${TMP}"
    i=$((i + 1))
done

defaults import NSGlobalDomain "${TMP}"

# Flush the preferences cache so a re-read reflects the import instead of the
# stale in-memory copy.
killall cfprefsd 2>/dev/null || true

echo "Done. Imported ${i} text replacements."
echo "Log out and back in for the substitution engine to pick up changes."
echo "Note: shortcuts must be alphanumeric. Punctuation-only ones (e.g. '->') never trigger."
