---
paths:
  - "Makefile"
  - "makefiles/*.mk"
---

# pkg: Makefile target conventions

- One `run "pkg/{name}/{os}-{name}.sh"` per target. Stow-only targets may call `stow --no-folding ...` directly instead of via a script.
- Deps go on the same line as the target (e.g. `macos-{name}: macos-brew macos-stow`).
- No-op targets end with a trailing `;` (e.g. `macos-nano: ;`).
- Cross-platform targets need a dispatch entry in the root `Makefile`: `{name}: $(OS)-{name}`. Per-OS recipes live in `makefiles/{os}.mk`.
- Standard recipe shape:
  ```makefile
  macos-{name}: macos-brew
  	run "pkg/{name}/macos-{name}.sh"
  ```
  Add `macos-stow` as a dep when the package ships a `stow/` subdir.

Why: keeps recipes greppable and uniform. One shell call per target means failures point at one script, deps on the target line surface the dependency graph at a glance, and the root-`Makefile` dispatch lets `make {name}` work without the caller knowing the OS.
