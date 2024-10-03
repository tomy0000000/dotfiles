#!/bin/zsh
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/autojump/autojump.plugin.zsh
# https://github.com/wting/autojump/wiki#installation

declare -a autojump_paths
autojump_paths=(
    /usr/share/autojump/autojump.zsh        # Debian and Ubuntu package
    /usr/local/etc/profile.d/autojump.sh    # macOS with Homebrew (default)
    /opt/homebrew/etc/profile.d/autojump.sh # macOS with Homebrew (default on M1 macs)
)

for file in $autojump_paths; do
    if [[ -f "$file" ]]; then
        source "$file"
        break
    fi
done

unset autojump_paths file
