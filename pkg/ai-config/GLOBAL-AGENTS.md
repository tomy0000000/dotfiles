# Global AI Instruction

## Alternative context

Check both `AGENTS.md` / `CLAUDE.md` in the project directory.

## Think Before Coding

**Don't assume. Don't hide confusion. Surface tradeoffs.**

Before implementing:

- State your assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them - don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- If something is unclear, stop. Name what's confusing. Ask.

## Simplicity First

**Minimum code that solves the problem. Nothing speculative.**

- No features beyond what was asked.
- No abstractions for single-use code.
- No "flexibility" or "configurability" that wasn't requested.
- No error handling for impossible scenarios.
- If you write 200 lines and it could be 50, rewrite it.

Ask yourself: "Would a senior engineer say this is overcomplicated?" If yes, simplify.

## Surgical Changes

**Touch only what you must. Clean up only your own mess.**

When editing existing code:

- Don't "improve" adjacent code, comments, or formatting.
- Don't refactor things that aren't broken.
- Match existing style, even if you'd do it differently.
- If you notice unrelated dead code, mention it - don't delete it.

When your changes create orphans:

- Remove imports/variables/functions that YOUR changes made unused.
- Don't remove pre-existing dead code unless asked.

The test: Every changed line should trace directly to the user's request.

## Goal-Driven Execution

**Define success criteria. Loop until verified.**

Transform tasks into verifiable goals:

- "Add validation" → "Write tests for invalid inputs, then make them pass"
- "Fix the bug" → "Write a test that reproduces it, then make it pass"
- "Refactor X" → "Ensure tests pass before and after"

For multi-step tasks, state a brief plan:

```
1. [Step] → verify: [check]
2. [Step] → verify: [check]
3. [Step] → verify: [check]
```

Strong success criteria let you loop independently. Weak criteria ("make it work") require constant clarification.

## Context Sync

When planning, scoping, working on a high-context task, make sure to pause at critical check points,
and sync context with the user, make them a part of the decision making process, and ask for
feedback.

## Shell conventions

- Do not use `-C` flag in `git` commands. Always run from the repo root, and use absolute paths to files/dirs in the repo.
- Prevent pipe unless you have to
- To check whether an env var is set, use `printenv SOME_ENV` (never `env | grep` or bare `env`)
- Use `rg` (ripgrep) instead of `grep` for searching: faster, respects `.gitignore`, and has better defaults
- Use `fd` instead of `find` for file lookups: faster, respects `.gitignore`, and has saner syntax
- When running `bazel` commands, always use absolute paths to the workspace root, never `cd` into the workspace first. For example, use `bazel build //pkg/ai-config:target` instead of `cd /path/to/workspace && bazel build //pkg/ai-config:target`
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

## Repetitive Tasks

- When asked to do something repetitive, even if it's just a one-time task, always first evaluate if automation is possible. e.g. Script or agent skill.
- Always prefer script over agent skill

## Language conventions

- If the prompt is in Chinese, respond with Traditional Chinese characters, and think/research as a Taiwanese.
