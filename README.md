# .files
My setup scripts and .files for new machine/development runtime for both Linux and macOS.

Most of the function is still under construction, use at your own risk.

## Install

```sh
git clone https://github.com/tomy0000000/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# For Ubuntu
apt update && apt install sudo make

make [feature]
```

### Remark

In some minimal environment (e.g. docker), you might need to manually install some essential components

```sh
apt update
apt install -y sudo make
```

