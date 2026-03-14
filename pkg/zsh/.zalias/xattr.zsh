#!/bin/zsh

# Remove quarantine attribute from file
alias xattr-rmq="xattr -d com.apple.quarantine"

# Ignore file for Dropbox
alias xattr-dbi="xattr -w com.dropbox.ignored 1"
