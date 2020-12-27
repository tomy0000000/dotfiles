# .files
My setup scripts and .files for new machine/development runtime for both Linux and macOS.

Most of the function is still under construction, use at your own risk.

## Install

### Manual

```sh
git clone https://github.com/tomy0000000/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
make all # draft
```

### Headless (draft)

```shell
# curl
curl -fsSL https://install.tomy.tech | bash
# wget
wget -O - https://install.tomy.tech | bash
```

## Draft

- [ ] Items
  - [ ] Zsh
  - [ ] Alias
  - [ ] Pipfile
  - [ ] Npmfile
  - [ ] Gemfile
  - [ ] Brewfile
- [ ] Features
  - [ ] fixup for depending bash, curl/wget, git, make
  - [ ] Unit Tests
  - [ ] Docker playground