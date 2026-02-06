# Principles

## Target checklist

- [ ] KISS: Keep It Simple Stupid. One target = One installation + one configuration setting.
- [ ] Idempotent: Does installing target multiple times cause any issues?
- [ ] Minimal dependencies: Avoid unnecessary dependencies between targets.
- [ ] Cross-platform reusability: Factor out common install steps into OS-agnostic scripts. (See `git` target as an example.)
- [ ] One single run in `Makefile`: A target should only have one single `run` command in `Makefile`.

## Pointer over Linker

Modify the config path to point preferences/configs to file in this repo, rather than symlink/stow them to some other location.

e.g. By setting `ZDOTDIR` in `.zshenv`, we don't have to stow the entire `zsh` config dir to home directory.

## Do not hardcode dotfiles root dir

There are a few target assume dotfiles are cloned to `~/.dotfiles`, but this paragidm should be prevent.
