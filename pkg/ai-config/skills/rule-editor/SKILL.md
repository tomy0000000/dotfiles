---
name: rule-editor
description: "Use this skill whenever the user wants to add, create, or capture a single agent rule into `.agents/rules/`. Triggers on phrases like 'add a rule', 'capture this as a rule', 'this should be a rule', 'turn this into a rule', 'I need a rule for X', or any time the user formulates a single standing guideline they want the agent to follow across sessions. Also use when the user asks whether a fact belongs in a hook, `AGENTS.md`, a rule, or a skill. Knows the classification (hook vs AGENTS.md vs rule vs skill) and the path-scoping conventions for `.agents/rules/`."
---

# Rule Editor

Add one agent rule to `.agents/rules/`, with the right scope (project vs global) and the right home (hook vs `AGENTS.md` vs rule vs skill).

## What rules are (and aren't)

Rules are modular markdown instructions, optionally scoped to file paths via YAML frontmatter. They're one of four homes for "things the agent should do":

| Mechanism | Loads | Best for |
| --- | --- | --- |
| Hook (`settings.json`) | On tool events | Automated behaviors ("whenever X", "before/after Y") |
| `AGENTS.md` | Every session | Always-true single-file project facts |
| Rules (unscoped) | Every session | Always-on facts split by topic |
| Rules (path-scoped) | When matching files are touched | Subsystem-specific guidance |
| Skills | On invocation or detected relevance | Multi-step procedures |

Hooks are deterministic harness-level enforcement. The other three are probabilistic in-context instructions the agent reads and tries to follow. When a behavior can be a hook, prefer that.

## Where rules live

`.agents/rules/` is the canonical home for rules, in two scopes:

- **Project**: `<repo-root>/.agents/rules/` is checked into version control and applies to this repo only. Always write to the git repo root, not a subdirectory.
- **Global**: `~/.agents/rules/` applies to every project. Personal preferences only.

Always ask the user which scope they want. Don't guess.

## Anatomy of a rule

A rule is a markdown file with optional YAML frontmatter.

```markdown
---
paths:
  - "src/api/**/*.ts"
---

# API rules

- Validate all input with Zod schemas.
- Wrap handlers in `withErrorBoundary`.
- Return `{ ok: false, error }` on failure, never throw.
```

Rules without `paths` load every session. Rules with `paths` load only when matching files are touched.

## When to scope vs leave unscoped

Scope (`paths:` frontmatter) when the rule applies to one subsystem. Examples: API conventions only matter under `src/api/**`, Tailwind class ordering only matters in `.tsx`, SQL migrations only matter in `migrations/**`.

Leave unscoped only for project-wide facts that don't already live in `AGENTS.md`. If the fact fits in `AGENTS.md` and `AGENTS.md` is still short, put it there instead.

## Workflow

One rule per invocation. Walk these steps in order, stopping early if classification routes elsewhere.

1. **Check if it's a hook**. Is this an automated behavior pattern ("whenever X, do Y", "each time X happens", "before/after tool Z")? If yes, this is harness work, not rule work. Tell the user this looks like a hook, recommend invoking `update-config` to set it up in `settings.json`, and stop. Hooks are deterministic, rules are probabilistic. Always prefer the deterministic route when it fits.
2. **Check if it's `AGENTS.md`**. Is this a single always-true fact about the project (e.g., "build with `pnpm`", "main branch is `develop`")? If yes, recommend editing `AGENTS.md` directly and stop.
3. **Check if it's a skill**. Is this a multi-step workflow with its own context, branching logic, or generated output? If yes, recommend invoking `skill-creator` and stop.
4. **Ask scope**. Confirmed it's a rule. Ask: "Project (`<repo-root>/.agents/rules/`) or global (`~/.agents/rules/`)?"
5. **Pick a topic file**. One topic per file. Reuse an existing file (e.g., `testing.md`, `api.md`, `styling.md`) if the topic has one. Create a new descriptive filename only for genuinely new topics.
6. **Decide on path scoping**. Subsystem-only: ask the user for the glob and add `paths:` frontmatter. Project-wide: leave unscoped.
7. **Write the body**. Imperative bullets, brief. Explain the *why* when the rule itself doesn't make the reason obvious. Agents make better judgment calls when they understand intent.
8. **Show, then write**. Show the proposed file (frontmatter + body + target path) before writing to disk so the user can validate topic, scoping, and content.

## Anti-patterns

- Multi-paragraph prose. Use bullets.
- ALL-CAPS ALWAYS / NEVER as a substitute for explanation. Agents follow reasoning better than rigid commands.
- Duplicating content between `AGENTS.md` and rules. Pick one home per fact.
- Putting "how to do X" procedures in a rule file. Those are skills.
- Writing a rule for an automated behavior that could be a hook. Hooks are more reliable.
- Adding `paths:` to every rule reflexively. Some rules are genuinely project-wide.
- Creating a new topic file when an existing one would fit. Reuse over fragmentation.
