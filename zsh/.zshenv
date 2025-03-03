#!/bin/zsh

# Zsh
ZDOTDIR="${HOME}/.dotfiles/zsh"

# Language
export LANG="en_US.UTF-8"   # English
export LANG="zh_TW.UTF-8"   # Chinese (Taiwan)
export LC_ALL="en_US.UTF-8" # English

# Editor
export EDITOR="subl" # Sublime Text
# export EDITOR="code"  # VS Code
# export EDITOR="micro" # micro
# export EDITOR="nano"  # nano
# export EDITOR="vim"   # vim

# Pager
# export PAGER="less"
# export PAGER="delta"

# Terminal
export TERM="xterm-256color"

# Additional PATHs
export PATH="/opt/iterm2/bin:${PATH}"            # iTerm2 utilities
export PATH="/usr/local/opt/openjdk/bin:${PATH}" # java

# Additional FPATHs
export FPATH="${ZDOTDIR}/.zfunc:${FPATH}"

# Additional MANPATHs

# Additional INFOPATHs

# Oh My Zsh library settings
# https://github.com/ohmyzsh/ohmyzsh/wiki/Settings#library-settings
HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"

# Third-party integrations
if [ -n "$(ls -A "${ZDOTDIR}/.zenv")" ]; then
    for script in "${ZDOTDIR}"/.zenv/*; do
        source "${script}"
    done
fi
