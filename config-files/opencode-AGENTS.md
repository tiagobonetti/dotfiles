# General Coding Guidance

## Repository-first workflow

- Inspect the repository before making changes. Read the relevant `README`, contribution guidance, build configuration, CI configuration, and local agent instructions.
- Treat repository documentation and existing code conventions as authoritative for that repository. Do not replace them with generic preferences.
- Prefer the smallest correct change. Avoid unrelated refactors, compatibility layers, or new abstractions unless the task requires them.
- Search for existing implementations and tests before adding new code.
- Keep changes scoped to the task. Do not modify unrelated user changes, generated files, vendored code, or dependency lockfiles without a reason.

## Validation

- Use the repository's documented build, test, lint, and formatting commands.
- Prefer focused validation for the changed area, followed by the repository's standard checks when practical.
- Do not substitute a generic command such as bare `pytest` for a repository-specific test runner when the project documents a different workflow.
- Treat compiler, linter, formatter, and test warnings seriously, especially when the project enables warnings-as-errors.
- If a check cannot be run because of missing tools, credentials, services, hardware, or platform constraints, report that clearly and run the strongest available alternative.

## Editing and Git safety

- Check the working tree before editing and preserve changes that were already present.
- Never reset, restore, clean, or otherwise discard user changes unless explicitly asked.
- Do not commit, amend, push, or create pull requests unless explicitly requested.
- Do not change repository or tool configuration merely to make a check pass without explaining the tradeoff.
- Do not add secrets, credentials, tokens, private URLs, or machine-specific paths to tracked files.
- Prefer existing scripts, presets, targets, and configuration over reconstructing commands manually.

## Communication

- State assumptions when repository evidence is incomplete.
- Before making a substantial change, summarize the intended scope and any important tradeoffs.
- After making changes, report the files changed and the validation commands run, including failures or skipped checks.
- Keep comments focused on non-obvious reasoning; do not add comments that merely restate the code.

## Worktrees

- Confirm the current working directory and Git worktree before running commands that write build artifacts or generated files.
- When working in a Git worktree, use Git's worktree metadata to identify the main repository rather than assuming a directory layout. Check the associated base repository for an `AGENTS.md` that may be ignored or untracked in Git, and read it for additional instructions if available.
- Assume untracked and ignored files from another worktree are unavailable. Use tracked project files, global OpenCode instructions, or explicit setup automation instead of relying on files copied from the main checkout.
- Avoid sharing mutable build directories between worktrees unless the project explicitly supports it.
