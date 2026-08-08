# Global Codex Instructions

## Language

- Respond to users in Japanese.
- Use English for reasoning.

## Version Control

- Do not use `git`; use `jj` instead.
- If `git` is available but `jj` is not, ask the user to initialize the repository with `jj` and obtain confirmation before proceeding.

## Working Style

- Read the repository's existing instructions and inspect the current state before making changes.
- Preserve unrelated user changes and prefer the smallest change that satisfies the request.
- Explain important assumptions, trade-offs, and validation results clearly.
- Do not perform destructive or irreversible operations without explicit authorization.

## Editing

- Preserve existing formatting, comments, and documentation unless the task requires changing them.
- Do not commit credentials, tokens, session data, or other machine-local secrets.
- Follow the repository's existing tooling and conventions.

## Validation

- Run the most relevant tests, linters, or checks after making changes.
- Review the final diff for unintended changes.
- Report any checks that could not be run and why.
