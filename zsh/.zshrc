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

# Library
zinit light-mode lucid for OMZL::completion.zsh # Includes bashcompinit
zinit light-mode lucid for OMZL::git.zsh

# Tools
zinit snippet ${ZDOTDIR}/tools/direnv.zsh
zinit snippet ${ZDOTDIR}/tools/starship.zsh
zinit snippet ${ZDOTDIR}/tools/zoxide.zsh

# Hotfix
zinit snippet ${ZDOTDIR}/.zsh/fix_omz_plugin.zsh

# Plugins
# https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins
zinit snippet OMZP::colored-man-pages
zinit snippet OMZP::colorize # ccat, cless
zinit snippet OMZP::kubectl  # completion
zinit lucid wait for OMZP::command-not-found
zinit lucid wait for OMZP::rbenv
zinit lucid wait atpull"%atclone" atclone"_fix-omz-plugin" for OMZP::macos # commands
zinit light MichaelAquilina/zsh-you-should-use
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting

# Third-party integrations
zinit snippet ${ZDOTDIR}/.zsh/brew.zsh
zinit snippet ${ZDOTDIR}/.zsh/go.zsh
zinit snippet ${ZDOTDIR}/.zsh/iterm.zsh
zinit snippet ${ZDOTDIR}/.zsh/javascript.zsh
zinit snippet ${ZDOTDIR}/.zsh/perl.zsh
zinit snippet ${ZDOTDIR}/.zsh/python.zsh
zinit snippet ${ZDOTDIR}/.zsh/ruby.zsh
zinit snippet ${ZDOTDIR}/.zsh/zsh-style.zsh

# Alias
zinit lucid wait for OMZP::thefuck # fuck function + ESC-ESC combo

# Configs
zinit snippet ${ZDOTDIR}/config/keybindings.zsh

# Completions
zinit snippet ${ZDOTDIR}/completion/docker.zsh
zinit snippet ${ZDOTDIR}/completion/kubectl.zsh
zinit snippet ${ZDOTDIR}/completion/misc.zsh
zinit snippet ${ZDOTDIR}/completion/op.zsh
zinit snippet ${ZDOTDIR}/completion/poetry.zsh

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
