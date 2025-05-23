#!/bin/zsh

# Zsh
export ZDOTDIR="${HOME}/.dotfiles/zsh"

# XDG Base Directory
# https://specifications.freedesktop.org/basedir-spec/latest/
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_STATE_HOME="${HOME}/.local/state"
# export XDG_DATA_DIRS=""
# export XDG_CONFIG_DIRS=""
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_RUNTIME_DIR="${HOME}/.local/run"

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

# Additional FPATHs
export FPATH="${ZDOTDIR}/.zfunc:${FPATH}"

# Additional MANPATHs

# Additional INFOPATHs

# Oh My Zsh
# https://github.com/ohmyzsh/ohmyzsh/wiki/Settings#library-settings
export HYPHEN_INSENSITIVE=true
export COMPLETION_WAITING_DOTS=true
export ENABLE_CORRECTION=true
export HIST_STAMPS="yyyy-mm-dd"

# zsh-autosuggestions
# https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#configuration
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=14" # Default: bright black (fg=8) which is typically gray

# Starship
# https://starship.rs/config/#config-file-location
export STARSHIP_CONFIG="${ZDOTDIR}/starship.toml"

# pyenv
export PYENV_ROOT="${HOME}/.pyenv"

# goenv
export GOENV_ROOT="${HOME}/.goenv"
