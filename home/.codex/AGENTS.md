# Global Codex Instructions

## Language

- Respond to users in Japanese.
- Use English for reasoning.

## Version Control

- Do not use `git`; use `jj` instead.
- If `git` is available but `jj` is not, ask the user to initialize the repository with `jj` and obtain confirmation before proceeding.
- Use Conventional Commits for commit messages.
- Never commit to or push directly to the `main`, `develop`, or `master` branches. Make changes on a working branch and integrate them through a reviewed pull request.

## GitHub

- Prefer the `gh` CLI for GitHub operations. If an operation can be completed with `gh`, use it instead of calling the GitHub API directly.
- Do not send GitHub operations known to fail with `403: Resource not accessible by integration`. Check the available authentication and repository access first; if the required permissions are unavailable, explain what is needed before proceeding.

## Working Style

- Read the repository's existing instructions and inspect the current state before making changes.
- Preserve unrelated user changes and prefer the smallest change that satisfies the request.
- Explain important assumptions, trade-offs, and validation results clearly.
- Do not perform destructive or irreversible operations without explicit authorization.

## Editing

- Preserve existing formatting, comments, and documentation unless the task requires changing them.
- Do not commit credentials, tokens, session data, or other machine-local secrets.
- Follow the repository's existing tooling and conventions.

## Codex Shared Settings

- Treat `home/.codex/dotfiles.config.toml` as user-maintained shared configuration. Do not modify it unless the user explicitly asks to change the shared Codex settings.

## Validation

- Run the most relevant tests, linters, or checks after making changes.
- Review the final diff for unintended changes.
- Report any checks that could not be run and why.
