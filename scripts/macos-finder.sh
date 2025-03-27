#!/bin/bash
set -euo pipefail

# References:
# https://github.com/pawelgrzybek/dotfiles/blob/master/setup-macos.sh
# https://github.com/mathiasbynens/dotfiles/blob/master/.macos

###############################################################################
# General                                                                     #
###############################################################################

# General > Show these items on the desktop: Hard disks, External disks, Removable media, Connected servers
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# General > New Finder windows show: Dropbox
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Dropbox/"

###############################################################################
# Advanced                                                                    #
###############################################################################

# Advanced > Show warning before changing an extension: Off
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Advanced > Show warning before removing from iCloud Drive: Off
defaults write com.apple.finder FXEnableRemoveFromICloudDriveWarning -bool false

# Advanced > Show warning before emptying the Trash: Off
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Advanced > Keep folders on top: In windows when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Advanced > When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

###############################################################################
# View                                                                        #
###############################################################################

# View > Show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# View > Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Show the ~/Library folder
chflags nohidden ~/Library

# Use list view in all Finder windows by default
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Enable snap-to-grid for icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Add :FK_StandardViewSettings:IconViewSettings dict" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Add :FK_StandardViewSettings:IconViewSettings:arrangeBy string grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

###############################################################################
# Misc                                                                        #
###############################################################################

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Restart Finder
killall Finder
