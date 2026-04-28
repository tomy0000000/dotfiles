---
paths:
  - "Makefile"
  - "makefiles/*.mk"
---

# Makefile rules

- Targets follow `{os}-{feature}` (e.g. `macos-git`, `ubuntu-zsh`).
- Split platform-specific targets into `makefiles/macos.mk` and `makefiles/ubuntu.mk`, included from the root `Makefile` via `include makefiles/*.mk`.
- Cross-platform targets need a dispatch entry in the root `Makefile`: `{name}: $(OS)-{name}`. Per-OS recipes live in `makefiles/{os}.mk`.
- One `run "pkg/{name}/{os}-{name}.sh"` per target.
- Deps go on the same line as the target (e.g. `macos-{name}: macos-brew macos-stow`). Add `macos-stow` as a dep when the package ships a `stow/` subdir.
- Group related targets with a `###...###` divider comment.
- No-op targets end with a trailing `;` (e.g. `macos-nano: ;`).
- Standard recipe shape:
  ```makefile
  macos-{name}: macos-brew
  	run "pkg/{name}/macos-{name}.sh"
  ```

Why: keeps recipes greppable and uniform. One shell call per target means failures point at one script, deps on the target line surface the dependency graph at a glance, and root-`Makefile` dispatch lets `make {name}` work without the caller knowing the OS.