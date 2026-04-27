---
paths:
  - "pkg/**/*.sh"
  - "pkg/**/*.Brewfile"
  - "pkg/**/*.Aptfile"
---

# pkg: Homebrew / APT install style

- Multiple packages: declare them in `{name}.Brewfile` / `{name}.Aptfile` and install via `brew bundle --file pkg/{name}/{name}.Brewfile` or `xargs apt-get install -y < pkg/{name}/{name}.Aptfile`.
- Single package: one `brew install <pkg>` or `apt-get install -y <pkg>` line directly in the platform script. No Brewfile/Aptfile.

Why: a Brewfile/Aptfile with one entry is overhead with no payoff. Multiple inline installs lose the declarative manifest and re-run slower than `brew bundle`.
