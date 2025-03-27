#!/bin/zsh

# Init zsh completions
autoload -Uz compinit
compinit

# Init bash completions
autoload -Uz bashcompinit
bashcompinit

# Zinit
source "${HOMEBREW_PREFIX:-/usr/local}/opt/zinit/zinit.zsh"

# Library
zinit snippet OMZL::git.zsh

# Plugins
# https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins
zinit snippet OMZP::colored-man-pages
zinit snippet OMZP::colorize # ccat, cless
zinit snippet OMZP::direnv   # hook
zinit snippet OMZP::kubectl  # completion
zinit snippet OMZP::macos    # commands
zinit snippet OMZP::starship # hook
zinit snippet OMZP::sudo
zinit light MichaelAquilina/zsh-you-should-use
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting

# Third-party integrations
for script in "${ZDOTDIR}"/.zsh/*; do
    source "${script}"
done

# Autoload all functions
for func in "${ZDOTDIR}"/.zfunc/*; do
    autoload -U ${func:t}
done

# Alias
for alias in "${ZDOTDIR}"/.zalias/*; do
    source "${alias}"
done
