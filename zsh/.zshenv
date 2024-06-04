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
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:${PATH}" # sed
export PATH="/usr/local/opt/grep/libexec/gnubin:${PATH}"    # grep, fgrep, egrep
export PATH="/usr/local/opt/make/libexec/gnubin:$PATH"      # make
export PATH="/usr/local/opt/openjdk/bin:${PATH}"            # java

# Additional FPATHs
export FPATH="${HOME}/.zfunc:${FPATH}"

# Oh My Zsh library settings
# https://github.com/ohmyzsh/ohmyzsh/wiki/Settings#library-settings
HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"

# Third-party integrations
for script in "${HOME}"/.zenv/*; do
    source "${script}"
done
