## `javascript`

Sets up Node.js and npm defaults (author metadata, registry token, Prettier config).

## Installs

- mise: `node@lts` (macOS only, `pkg/javascript/macos-javascript.sh`)
- Debian: no Node install yet, see TODO in `pkg/javascript/debian-javascript.sh`

## Configures

- `~/.npmrc` — init author fields, npm registry auth token
- `~/.prettierrc` — import-order, JSON sort, Tailwind, and SQL plugins (resolved via mise-installed npm shims)
