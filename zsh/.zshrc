#!/bin/zsh

# Zinit
if [[ -n "${HOMEBREW_PREFIX}" ]]; then
    source "${HOMEBREW_PREFIX}/opt/zinit/zinit.zsh"
elif [[ -n "${XDG_DATA_HOME}" ]]; then
    source "${XDG_DATA_HOME}/zinit/zinit.zsh"
else
    source "${HOME}/.local/share/zinit/zinit.zsh"
fi

# Init zsh completions
autoload -Uz compinit
compinit

# Init bash completions
autoload -Uz bashcompinit
bashcompinit

# Library
zinit snippet OMZL::git.zsh

# Hotfix
zinit snippet ${ZDOTDIR}/.zsh/fix_omz_plugin.zsh

# Plugins
# https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins
zinit snippet OMZP::colored-man-pages
zinit snippet OMZP::colorize # ccat, cless
zinit snippet OMZP::direnv   # hook
zinit snippet OMZP::kubectl  # completion
zinit snippet OMZP::starship # hook
zinit snippet OMZP::sudo
zinit lucid wait atpull"%atclone" atclone"_fix-omz-plugin" for OMZP::macos # commands
zinit light MichaelAquilina/zsh-you-should-use
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting

# Third-party integrations
zinit snippet ${ZDOTDIR}/.zsh/autojump.zsh
zinit snippet ${ZDOTDIR}/.zsh/az.zsh
zinit snippet ${ZDOTDIR}/.zsh/brew.zsh
zinit snippet ${ZDOTDIR}/.zsh/docker.zsh
zinit snippet ${ZDOTDIR}/.zsh/go.zsh
zinit snippet ${ZDOTDIR}/.zsh/iterm.zsh
zinit snippet ${ZDOTDIR}/.zsh/javascript.zsh
zinit snippet ${ZDOTDIR}/.zsh/macos-one-password.zsh
zinit snippet ${ZDOTDIR}/.zsh/perl.zsh
zinit snippet ${ZDOTDIR}/.zsh/python.zsh
zinit snippet ${ZDOTDIR}/.zsh/ruby.zsh
zinit snippet ${ZDOTDIR}/.zsh/thefuck.zsh
zinit snippet ${ZDOTDIR}/.zsh/zsh-style.zsh

# Autoload all functions
for func in "${ZDOTDIR}"/.zfunc/*; do
    autoload -U ${func:t}
done

# Alias
zinit snippet ${ZDOTDIR}/.zalias/replacement.zsh
zinit snippet ${ZDOTDIR}/.zalias/cd.zsh
zinit snippet ${ZDOTDIR}/.zalias/configs.zsh
zinit snippet ${ZDOTDIR}/.zalias/docker.zsh
zinit snippet ${ZDOTDIR}/.zalias/editors.zsh
zinit snippet ${ZDOTDIR}/.zalias/kubectl.zsh
zinit snippet ${ZDOTDIR}/.zalias/ls.zsh
zinit snippet ${ZDOTDIR}/.zalias/npm.zsh
zinit snippet ${ZDOTDIR}/.zalias/pip.zsh
zinit snippet ${ZDOTDIR}/.zalias/xattr.zsh
