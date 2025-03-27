#!/bin/zsh

# Init zsh completions
autoload -Uz compinit
compinit

# Init bash completions
autoload -Uz bashcompinit
bashcompinit

# Zim
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR}/.zimrc ]]; then
    source "${HOMEBREW_PREFIX:-/usr/local}/opt/zimfw/share/zimfw.zsh" init
fi
source ${ZIM_HOME}/init.zsh

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
