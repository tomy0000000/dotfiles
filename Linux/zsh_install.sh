#!/bin/sh

# Install basic dependencies
dependencies="curl git zsh"
for cmd in $dependencies
do
    if ! command -v $cmd &> /dev/null
    then
        apt update
        apt install -y $cmd
    fi
done

# Change default shell to zsh
chsh -s $(which zsh)

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Install powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
