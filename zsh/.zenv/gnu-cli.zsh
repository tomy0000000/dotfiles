#!/bin/zsh

clis=(
    gnu-sed # sed
    grep    # grep, fgrep, egrep
    make    # make
)

for cli in "${clis[@]}"; do
    target="${HOMEBREW_PREFIX}/opt/${cli}/libexec/gnubin"
    if [ -d "${target}" ]; then
        export PATH="${target}:${PATH}"
    fi
done

# export PATH="${HOMEBREW_PREFIX}/opt/gnu-sed/libexec/gnubin:${PATH}" # sed
# export PATH="${HOMEBREW_PREFIX}/opt/grep/libexec/gnubin:${PATH}"    # grep, fgrep, egrep
# export PATH="${HOMEBREW_PREFIX}/opt/make/libexec/gnubin:${PATH}"    # make
