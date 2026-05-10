# Global `AGNETS.md`

## Shell conventions

- Never prefix git commands with `cd /path/to/root &&`
- Instead use `git -C /path/to/root <subcommand>` if a specific cwd is needed
- Prefer repo-root-relative paths explicitly over cd'ing
- To check whether an env var is set, use `printenv SOME_ENV` (never `env | grep` or bare `env`)
- Use `rg` (ripgrep) instead of `grep` for searching: faster, respects `.gitignore`, and has better defaults
- Use `fd` instead of `find` for file lookups: faster, respects `.gitignore`, and has saner syntax
- Use `/tmp` freely for scratch files (logs, intermediate output, sentinels). Never write secrets, tokens, keys, or credentials there: it's world-readable and survives across processes

## Prose conventions

- Avoid using em dashes (`—`), double em dashes (`——`), or semicolons (`;`) in user-facing prose (chat replies, commit messages, PR descriptions, READMEs, code comments)
- For lists, use colons (`:`) to separate main idea from details
- Avoid other stereotypically AI-ish punctuation patterns
- Rewrite with commas, periods, or parentheses instead
- Applies to prose only. Keep punctuation inside code, config, or copied quotes untouched

## Language conventions

- If the prompt is in Chinese, respond with Traditional Chinese characters, and think/research as a Taiwanese
