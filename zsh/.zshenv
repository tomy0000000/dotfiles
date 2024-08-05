#!/bin/zsh

# Language
export LANG="en_US.UTF-8"   # English
export LANG="zh_TW.UTF-8"   # Chinese (Taiwan)
export LC_ALL="en_US.UTF-8" # English

# Editor
export EDITOR="/usr/local/bin/subl" # Sublime Text
# export EDITOR="/usr/bin/nano"       # nano

# Pager
# export PAGER="less"

# Terminal
export TERM="xterm-256color"

# Additional PATHs
export PATH="/opt/iterm2/bin:${PATH}"            # iTerm2 utilities
export PATH="/usr/local/opt/openjdk/bin:${PATH}" # java

# Additional FPATHs
export FPATH="${HOME}/.zfunc:${FPATH}"

# Additional MANPATHs

# Additional INFOPATHs

# Zsh
ZDOTDIR="${HOME}/.dotfiles/zsh"

# Oh My Zsh library settings
# https://github.com/ohmyzsh/ohmyzsh/wiki/Settings#library-settings
HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"

# Third-party integrations
if [ -n "$(ls -A "${HOME}/.zenv")" ]; then
    for script in "${HOME}"/.zenv/*; do
        source "${script}"
    done
fi
