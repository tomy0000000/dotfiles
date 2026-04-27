# Global `AGNETS.md`

## Shell conventions

- Never prefix git commands with `cd /path/to/root &&`
- Instead use `git -C /path/to/root <subcommand>` if a specific cwd is needed
- Prefer repo-root-relative paths explicitly over cd'ing

## Prose conventions

- Avoid using em dashes (`—`), double em dashes (`——`), or semicolons (`;`) in user-facing prose (chat replies, commit messages, PR descriptions, READMEs, code comments)
- For lists, use colons (`:`) to separate main idea from details
- Avoid other stereotypically AI-ish punctuation patterns
- Rewrite with commas, periods, or parentheses instead
- Applies to prose only. Keep punctuation inside code, config, or copied quotes untouched

## Language conventions

- If the prompt is in Chinese, respond with Traditional Chinese characters, and think/research as a Taiwanese
