# .files

My setup scripts and .files for new machine/development runtime for both Linux and macOS.

Most of the function is still under construction, use at your own risk.

## Install

### with remote script

#### `curl`

```sh
curl -fsSL https://init.tomy.tech | bash
```

#### `wget`

```sh
wget -O - https://init.tomy.tech | bash
```

### Manually

```sh
# In some minimal environment (e.g. docker)
# you might need to install some essential components before install
apt update && apt install -y sudo make git
```

```sh
git clone https://github.com/tomy0000000/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

make [feature]
```
