# .files

My setup scripts and .files for new machine/development runtime for both Linux and macOS.

## Install

### Auto script

Auto script detects the environment and prompts if you'd like to perform additional setups. Including installing the OpenSSH server, and setup a non-root user.

```sh
# In some minimal environment (e.g. docker)
# you might need to install some essential components before install
apt update && apt install -y curl
```

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
git clone https://github.com/tomy0000000/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

## Usage

```
make [feature]
```

A list of features can be found in the [Wiki](https://github.com/tomy0000000/dotfiles/wiki/Feature-List).
