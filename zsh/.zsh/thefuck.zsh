#!/bin/zsh

# Completion
if command -v thefuck 1>/dev/null 2>&1; then
    eval "$(thefuck --alias)"
fi

# Define shortcut keys: [Esc] [Esc]
# Reference: https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/thefuck/thefuck.plugin.zsh
fuck-command-line() {
    local FUCK="$(THEFUCK_REQUIRE_CONFIRMATION=0 thefuck $(fc -ln -1 | tail -n 1) 2>/dev/null)"
    [[ -z $FUCK ]] && echo -n -e "\a" && return
    BUFFER=$FUCK
    zle end-of-line
}
zle -N fuck-command-line
bindkey -M emacs '\e\e' fuck-command-line
bindkey -M vicmd '\e\e' fuck-command-line
bindkey -M viins '\e\e' fuck-command-line
