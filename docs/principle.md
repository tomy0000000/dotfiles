# Principles

## Target should be small, simple, and idempotent

One target = One installation + one configuration setting.

Divide complex feature as another new target. A target should not return error when installation is executed twice.

## Pointer over Linker

Modify the config path to point preferences/configs to file in this repo, rather than symlink/stow them to some other location.

e.g. By setting `ZDOTDIR` in `.zshenv`, we don't have to stow the entire `zsh` config dir to home directory.

## Do not hardcode dotfiles root dir

There are a few target assume dotfiles are cloned to `~/.dotfiles`, but this paragidm should be prevent.
