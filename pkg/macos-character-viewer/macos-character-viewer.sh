#!/bin/bash
set -euo pipefail

# Character Viewer (Emoji & Symbols): active categories, in display order.
# Identifiers come from CharacterPalette.app's Categories.plist; the display
# names live in its Localizable.loctable (e.g. Category-BigFive => "BIG-5E").
defaults write com.apple.CharacterPaletteIM CVActiveCategories -array \
    "Category-Emoji" \
    "Category-Latin" \
    "Category-Greek" \
    "Category-Parentheses" \
    "Category-MathematicalSymbols" \
    "Category-Punctuation" \
    "Category-Arrows" \
    "Category-Pictographs" \
    "Category-CurrencySymbols" \
    "Category-Bullets" \
    "Category-LetterlikeSymbols" \
    "Category-TechnicalSymbols" \
    "Category-Unicode" \
    "Category-BigFive"

# Restart the palette so the new order is picked up.
killall CharacterPalette 2>/dev/null || true

echo "Done. Character Viewer categories set."
