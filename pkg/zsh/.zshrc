#!/bin/zsh

# Additional PATHs
#
# Since macOS modify path with /etc/paths after ~/.zshenv, before .zshrc
# and places all paths at the beginning
# The only place to add paths at beginning would be here
source "${ZDOTDIR}/.zenv/brew.zsh"       # Homebrew
export PATH="${HOME}/.local/bin:${PATH}" # User executables

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

# Libraries
zinit light-mode lucid for OMZL::cli.zsh         # Oh My Zsh functions
zinit light-mode lucid for OMZL::clipboard.zsh   # clipcopy & clippaste functions
zinit light-mode lucid for OMZL::completion.zsh  # Includes bashcompinit
zinit light-mode lucid for OMZL::correction.zsh  # File corrections
zinit light-mode lucid for OMZL::directories.zsh # ls + cd alias
zinit light-mode lucid for OMZL::functions.zsh   # take function
zinit light-mode lucid for OMZL::git.zsh         # prompt functions
zinit light-mode lucid for OMZL::history.zsh     # history with time stamps

# Tools
zinit snippet ${ZDOTDIR}/tools/carapace.zsh
zinit snippet ${ZDOTDIR}/tools/direnv.zsh
zinit snippet ${ZDOTDIR}/tools/mise.zsh
zinit snippet ${ZDOTDIR}/tools/starship.zsh
zinit snippet ${ZDOTDIR}/tools/zoxide.zsh

# Hotfix
zinit snippet ${ZDOTDIR}/.zsh/fix_omz_plugin.zsh

# Plugins
# https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins
zinit lucid wait for OMZP::colored-man-pages
zinit lucid wait for OMZP::colorize # ccat, cless
zinit lucid wait for OMZP::command-not-found
zinit lucid wait for OMZP::gnu-utils
zinit lucid wait for OMZP::rbenv
zinit lucid wait atpull"%atclone" atclone"_fix-omz-plugin" for OMZP::macos # commands
zinit light MichaelAquilina/zsh-you-should-use
zinit light zdharma-continuum/history-search-multi-word # Ctrl-R history search
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting

# Third-party integrations
zinit snippet ${ZDOTDIR}/.zsh/iterm.zsh
zinit snippet ${ZDOTDIR}/.zsh/perl.zsh
zinit snippet ${ZDOTDIR}/.zsh/zsh-style.zsh

# Alias
zinit lucid wait for OMZP::thefuck # fuck function + ESC-ESC combo

# Configs
zinit snippet ${ZDOTDIR}/config/keybindings.zsh

# Completions
zinit snippet ${ZDOTDIR}/completion/carapace.zsh # This should always be at the top
zinit snippet ${ZDOTDIR}/completion/docker.zsh
zinit snippet ${ZDOTDIR}/completion/kubectl.zsh
zinit snippet ${ZDOTDIR}/completion/gt.zsh
zinit snippet ${ZDOTDIR}/completion/misc.zsh
zinit snippet ${ZDOTDIR}/completion/mise.zsh
zinit snippet ${ZDOTDIR}/completion/op.zsh
zinit snippet ${ZDOTDIR}/completion/poetry.zsh
zinit snippet ${ZDOTDIR}/completion/starship.zsh
zinit snippet ${ZDOTDIR}/completion/uv.zsh

# Lazily expose functions from .dotfiles/lib so they live in one place and stay
# usable by the install scripts (which source lib/*.sh through bin/make-shell).
# Usage: _lib_lazy <lib file> <function name>...
# The first call to any stub sources the file, which replaces every stub it
# declares. Never stub a lib that is also sourced eagerly: its import guard
# makes the re-source a no-op and the stub has already unfunction'd itself.
_lib_lazy() {
    local file="${1}" fn
    for fn in "${@[2,-1]}"; do
        eval "${fn}() { unfunction ${fn}; source ${file}; ${fn} \"\$@\" }"
    done
}

_lib_lazy "${ZDOTDIR}/../../lib/realcmd.sh" realcmd
_lib_lazy "${ZDOTDIR}/../../lib/path.sh" path
_lib_lazy "${ZDOTDIR}/../../lib/manpath.sh" manpath
_lib_lazy "${ZDOTDIR}/../../lib/fpath.sh" fpath
_lib_lazy "${ZDOTDIR}/../../lib/dns_purge.sh" dns_purge
_lib_lazy "${ZDOTDIR}/../../lib/kill_port.sh" kill_port
_lib_lazy "${ZDOTDIR}/../../lib/benchmark.sh" benchmark
_lib_lazy "${ZDOTDIR}/../../lib/reset_zsh.sh" reset_zsh

# Alias
zinit snippet ${ZDOTDIR}/.zalias/replacement.zsh
zinit snippet ${ZDOTDIR}/.zalias/configs.zsh
zinit snippet ${ZDOTDIR}/.zalias/docker.zsh
zinit snippet ${ZDOTDIR}/.zalias/editors.zsh
zinit snippet ${ZDOTDIR}/.zalias/kubectl.zsh
zinit snippet ${ZDOTDIR}/.zalias/npm.zsh
zinit snippet ${ZDOTDIR}/.zalias/pip.zsh
zinit snippet ${ZDOTDIR}/.zalias/xattr.zsh