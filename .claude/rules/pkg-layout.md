---
paths:
  - "pkg/**"
---

# pkg: directory and file naming

- Package directory: `pkg/{feature}` for cross-platform, `pkg/{os}-{feature}` when the package only exists on one OS (e.g. `pkg/git`, `pkg/macos-settings`).
- Cross-platform script: `pkg/{name}/{name}.sh` (e.g. `pkg/git/git.sh`).
- Platform-specific script: `pkg/{name}/{os}-{name}.sh` (e.g. `pkg/git/macos-git.sh`, `pkg/git/debian-git.sh`).
- Stow directory: always named `stow/` (e.g. `pkg/git/stow/`).