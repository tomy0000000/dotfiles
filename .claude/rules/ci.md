---
paths:
  - ".github/workflows/test_macos.yml"
  - ".github/workflows/test_ubuntu.yml"
  - "pkg/*"
---

# CI matrix coverage

When a pkg target is added or renamed in `Makefile` / `makefiles/*.mk`, the matching CI matrix in `.github/workflows/` must be updated in the same change. The reverse also applies: when editing a workflow matrix, sanity-check that every `Makefile` target intended for CI is listed.

- Cross-platform pkgs (root `Makefile` has `{name}: $(OS)-{name}`): add the bare `{name}` to **both** `test_macos.yml` and `test_ubuntu.yml`.
- macOS-only pkgs: add `macos-{name}` to `test_macos.yml`.
- Debian-only pkgs: add `ubuntu-{name}` to `test_ubuntu.yml`.
- Keep matrix entries alphabetized.
- If a target can't run on CI (login required, destructive defaults, paid/licensed app, etc.), include it commented-out with a `# Reason` note rather than omitting it silently. The commented entry is the breadcrumb that explains _why_ it's missing.

Why: the CI matrix is the only thing that catches regressions in pkg install scripts. A target that never lands in the matrix is invisible to CI and tends to bit-rot.
