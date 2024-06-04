#!/bin/zsh

# Language
export LANG="en_US.UTF-8" # English
export LANG="zh_TW.UTF-8" # Chinese (Taiwan)

# Editor
export EDITOR="/usr/local/bin/subl" # Sublime Text
# export EDITOR="/usr/bin/nano"       # nano

# Additional PATHs
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:${PATH}" # sed
export PATH="/usr/local/opt/grep/libexec/gnubin:${PATH}"    # grep, fgrep, egrep
export PATH="/usr/local/opt/make/libexec/gnubin:$PATH"      # make
export PATH="/usr/local/opt/openjdk/bin:${PATH}"            # java

# Additional FPATHs
export FPATH="${HOME}/.zfunc:${FPATH}"
