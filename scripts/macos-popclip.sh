#!/bin/bash
set -euo pipefail

# Notarized PopClip
xattr -d -r com.apple.quarantine /Applications/PopClip.app

# Open PopClip
# so that macOS later knows this app can open .popclipextz file
open -a PopClip

# List of PopClip extensions to install
# https://www.popclip.app/extensions/
extensions=(
    'ext_62XZP9tHPy7F' # Character Count
    'ext_fhwDR7QKj0me' # Word Count
    'ext_1G8UNz2Ui9no' # Lowercase
    'ext_BBDVbd3lslhJ' # Capitalize Words
    'ext_jfh9bnX6xFjQ' # Uppercase
    'ext_d85nqzhkIjaw' # Traditional/Simplified
    'ext_2CK4evHA79V2' # Instant Translate
    'ext_GiGpWx2ARKvK' # Alfred
)

# Install PopClip extensions
for extension in "${extensions[@]}"; do
    tmpfile="/tmp/${extension}.popclipextz"
    curl -fsSL -o "${tmpfile}" "https://public.popclip.app/extensions/${extension}/file"
    echo "Installing PopClip extension: ${extension}"
    open "${tmpfile}"
done

# Sleep to allow extensions to install
sleep 2

# Writing Preferences
defaults write com.pilotmoon.popclip CombinedItemOrder -array \
    'ext-com.pilotmoon.popclip.extension.charcount' \
    'ext-com.pilotmoon.popclip.extension.wordcount' \
    'ext-com.pilotmoon.popclip.extension.lowercase' \
    'ext-com.pilotmoon.popclip.extension.capitalize' \
    'ext-com.pilotmoon.popclip.extension.uppercase' \
    'ext-com.pilotmoon.popclip.extension.traditional-simplified' \
    'cut' \
    'copy' \
    'paste' \
    'openlink' \
    'search' \
    'ext-com.popclip.extension.instant-translate' \
    'ext-com.pilotmoon.popclip.extension.alfred' \
    'revealfile' \
    'lookup' \
    'openmail'
defaults write com.pilotmoon.popclip enable-action-cut -bool false
defaults write com.pilotmoon.popclip enable-action-revealfile -bool false
defaults write com.pilotmoon.popclip enable-action-lookup -bool false
defaults write com.pilotmoon.popclip enable-action-spelling -bool false

# Restart PopClip
killall PopClip
open -a PopClip
