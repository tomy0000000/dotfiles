# Global AI Instruction

## Alternative context

Check both `AGENTS.md` / `CLAUDE.md` in the project directory.

## Shell conventions

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

## Self-Improvement

- If you believe the `AGENTS.md` / `CLAUDE.md` you've read is outdated or not aligned with what you've found, proposed fix at the end of the task.
- If a skill is invoked to complete the task and the output required corrections or the user expressed dissatisfaction, ask user if they want to update

## Language conventions

- If the prompt is in Chinese, respond with Traditional Chinese characters, and think/research as a Taiwanese.
