#!/bin/bash
set -euo pipefail

# References:
# https://github.com/mathiasbynens/dotfiles/blob/master/.macos
# https://github.com/pawelgrzybek/dotfiles/blob/master/setup-macos.sh
# https://gist.github.com/brandonb927/3195465/
# https://gist.github.com/mkhl/455002

# Require Full Disk Access for Terminal
# References:
# https://github.com/mathiasbynens/dotfiles/issues/820#issuecomment-498324762
echo "This script require Full Disk Access enabled for Terminal..."
echo "Please add this terminal (${TERM_PROGRAM:-}) to the list in"
echo "System Preferences > Privacy & Security > Privacy > Full Disk Access"
echo ""
echo "If you have already done this, press any key to continue..."
echo ""
echo "If you have just added this terminal to the list,"
echo "Press ^C and relaunch the terminal and run this script again."
read -r

###############################################################################
# Init                                                                        #
###############################################################################

# Kill System Settings
osascript -e 'tell application "System Settings" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do
    sudo -n true
    sleep 60
    kill -0 "$$" || exit
done 2>/dev/null &

###############################################################################
# Sound                                                                       #
###############################################################################

# Play feedback when volume is changed
defaults write -globalDomain com.apple.sound.beep.feedback -int 1

###############################################################################
# General > Software Update                                                   #
###############################################################################

# Check for updates
# TODO
# Download new updates when available
# TODO
# Install macOS updates
# TODO
# Install application updates from the App Store
# TODO
# Install Security Responses and system files
# TODO

###############################################################################
# General > Language & Region                                                 #
###############################################################################

# Preferred Languages: English (US), Chinese, Traditional (Taiwan)
defaults write -globalDomain AppleLanguages -array en-US zh-Hant-TW

###############################################################################
# Appearance                                                                  #
###############################################################################

# Show scroll bars: when scrolling
defaults write -globalDomain AppleShowScrollBars -string "WhenScrolling"

###############################################################################
# Accessibility > Zoom                                                        #
###############################################################################

# Use scroll gesture with modifier keys to zoom
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
defaults write com.apple.universalaccess closeViewScrollWheelModifiersInt -int 262144
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad HIDScrollZoomModifierMask -int 262144
defaults write com.apple.AppleMultitouchTrackpad HIDScrollZoomModifierMask -int 262144

###############################################################################
# Accessibility > Pointer Control > Trackpad Options...                       #
###############################################################################

# Use trackpad for dragging
# TODO: this is not working
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Dragging -bool true

# Dragging style: Three Finger Drag
# TODO: this is not working
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true

###############################################################################
# Desktop & Dock                                                              #
###############################################################################

# Dock: Magnification Large
defaults write com.apple.dock magnification -int 1
defaults write com.apple.dock largesize -int 128

# Dock: Show suggested and recent apps in Dock: Off
defaults write com.apple.dock show-recents -bool false

# Windows: Prefer tabs when opening documents: Always
defaults write -globalDomain AppleWindowTabbingMode -string "always"

# Windows: Close windows when quitting an application: Off
defaults write -globalDomain NSQuitAlwaysKeepsWindows -bool true

# Mission Control: Automatically rearrange Spaces based on most recent use: Off
defaults write com.apple.dock mru-spaces -bool false

# Mission Control: When switching to an application, switch to a Space with open windows for the application: Off
defaults write -globalDomain AppleSpacesSwitchOnActivate -bool false

# Mission Control: Group windows by application: On
defaults write com.apple.dock expose-group-apps -bool true

# Hot Corners... > Top Left: -
defaults write com.apple.dock wvous-tl-corner -int 1

# Hot Corners... > Top Right: -
defaults write com.apple.dock wvous-tr-corner -int 1

# Hot Corners... > Bottom Left: Mission Control
defaults write com.apple.dock wvous-bl-corner -int 2

# Hot Corners... > Bottom Right: -
defaults write com.apple.dock wvous-br-corner -int 1

###############################################################################
# Lock Screen                                                                 #
###############################################################################

# Start Screen Saver when inactive: For 5 minutes
defaults -currentHost write com.apple.screensaver idleTime -int 300

# Turn display off on battery when inactive: For 10 minutes
sudo pmset -b displaysleep 10

# Turn display off on power adapter when inactive: For 20 minutes
sudo pmset -a displaysleep 20

# Require password after screen saver begins or display is turned off: Immediately
# TODO: Can't find this field in defaults or pmset

###############################################################################
# Keyboard                                                                    #
###############################################################################

# Press 🌐 Key to: Start Dictation (Press 🌐 Twice)
defaults write com.apple.HIToolbox AppleFnUsageType -int 3

# Keyboard Shortcuts... > Mission Control
# TODO
# Keyboard Shortcuts... > Keyboard
# TODO
# Keyboard Shortcuts... > Services
# TODO
# Keyboard Shortcuts... > Accessibility
# TODO

# Keyboard Shortcuts... > App Shortcuts > All Applications > Show Help menu: Off
defaults export com.apple.symbolichotkeys - |
    plutil -replace AppleSymbolicHotKeys.98.enabled -bool NO -o - - |
    defaults import com.apple.symbolichotkeys -

# Add application to System Settings menu
defaults write com.apple.universalaccess com.apple.custommenu.apps -array \
    NSGlobalDomain \
    com.brave.Browser \
    com.stairways.keyboardmaestro.editor \
    com.readdle.PDFExpert-Mac \
    com.apple.Photos \
    abnerworks.Typora

# Keyboard Shortcuts... > App Shortcuts > All Applications > Fill
# shellcheck disable=SC2016
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add 'Fill' '@~^\\U2191'

# Keyboard Shortcuts... > App Shortcuts > All Applications > Center
# shellcheck disable=SC2016
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add 'Center' '@~^\\U21a9'

# Keyboard Shortcuts... > App Shortcuts > All Applications > Read Later with Reeder
# shellcheck disable=SC2016
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add 'Read Later with Reeder' '@$s'

# Keyboard Shortcuts... > App Shortcuts > Brave Browser > Duplicate Tab
# shellcheck disable=SC2016
defaults write com.brave.Browser NSUserKeyEquivalents -dict-add 'Duplicate Tab' '@$e'

# Keyboard Shortcuts... > App Shortcuts > Brave Browser > New Tab to the Right
# shellcheck disable=SC2016
defaults write com.brave.Browser NSUserKeyEquivalents -dict-add 'New Tab to the Right' '~$t'

# Keyboard Shortcuts... > App Shortcuts > Keyboard Maestro > Start Editing Macros
# shellcheck disable=SC2016
defaults write com.stairways.keyboardmaestro.editor NSUserKeyEquivalents -dict-add 'Start Editing Macros' '@e'

# Keyboard Shortcuts... > App Shortcuts > Keyboard Maestro > Stop Editing Macros
# shellcheck disable=SC2016
defaults write com.stairways.keyboardmaestro.editor NSUserKeyEquivalents -dict-add 'Start Editing Macros' '@s'

# Keyboard Shortcuts... > App Shortcuts > PDF Expert > Change Password...
# shellcheck disable=SC2016
defaults write com.readdle.PDFExpert-Mac NSUserKeyEquivalents -dict-add 'Change Password...' '@$c'

# Keyboard Shortcuts... > App Shortcuts > Photos > Export Unmodified Original For 1 Photo
# shellcheck disable=SC2016
defaults write com.apple.Photos NSUserKeyEquivalents -dict-add 'Export Unmodified Original For 1 Photo' '@~e'

# Keyboard Shortcuts... > App Shortcuts > Typora > PDF
# shellcheck disable=SC2016
defaults write abnerworks.Typora NSUserKeyEquivalents -dict-add 'PDF' '@e'

# Keyboard Shortcuts... > App Shortcuts > Typora > Refresh All Math Expressions
# shellcheck disable=SC2016
defaults write abnerworks.Typora NSUserKeyEquivalents -dict-add 'Refresh All Math Expressions' '@r'

# Text Input > Edit... > All Input Sources > Show Input menu in menu bar: On
defaults write com.apple.TextInputMenu visible -bool true

# Text Input > Edit... > All Input Sources > Use the Caps Lock key to switch to and from ABC: On
defaults write -globalDomain TISRomanSwitchState -int 1

# Text Input > Edit... > All Input Sources > Use smart quotes and dashes: Off
defaults write -globalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write -globalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Text Input > Edit... > Add Shuangpin - Traditional
# TODO: This is not working
defaults export com.apple.HIToolbox - |
    plutil -replace AppleEnabledInputSources -json '[{"Bundle ID":"com.apple.inputmethod.TCIM","Input Mode":"com.apple.inputmethod.TCIM.Shuangpin","InputSourceKind":"Input Mode"},{"InputSourceKind":"Keyboard Layout","KeyboardLayout Name":"ABC","KeyboardLayout ID":252},{"Bundle ID":"com.apple.inputmethod.TCIM","InputSourceKind":"Keyboard Input Method"}]' -o - - |
    defaults import com.apple.HIToolbox -

# Dictation: On
defaults write com.apple.assistant.support "Dictation Enabled" -bool true

# Dictation > Shortcut: Press 🌐 Twice
defaults export com.apple.symbolichotkeys - |
    plutil -replace AppleSymbolicHotKeys.164.enabled -bool true -o - - |
    plutil -replace AppleSymbolicHotKeys.164.value.parameters -json '[8388608,4286578687]' -o - - |
    plutil -replace AppleSymbolicHotKeys.164.value.type -string modifier -o - - |
    defaults import com.apple.symbolichotkeys -

###############################################################################
# Trackpad                                                                    #
###############################################################################

# Point & Click > Secondary click: Click or Tap with Two Fingers
# TODO: Add this

# More Gestures > Swipe between pages: Scroll left or right with two fingers
defaults write -globalDomain AppleEnableSwipeNavigateWithScrolls -bool true

# More Gestures > App Exposé: Swipe down with four fingers
defaults write com.apple.dock showAppExposeGestureEnabled -bool true

###############################################################################
# Apply                                                                       #
###############################################################################

echo "Done. Killing affected applications..."

# Kill affected applications
for app in \
    "Activity Monitor" \
    "Address Book" \
    "Calendar" \
    "cfprefsd" \
    "Contacts" \
    "Dock" \
    "Finder" \
    "Mail" \
    "Messages" \
    "Photos" \
    "Safari" \
    "SystemUIServer" \
    "Terminal"; do
    if pgrep -xq "${app}"; then
        echo "Killing ${app}."
        killall "${app}"
    fi
done

# Reload Keyboard Shortcuts
# Reference:
# https://zameermanji.com/blog/2021/6/8/applying-com-apple-symbolichotkeys-changes-instantaneously/
echo "Reloading Keyboard Shortcuts..."
/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u

echo "Done. macOS settings are set."
