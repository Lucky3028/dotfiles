---
allowed-tools: Bash(jj diff:*), Bash(jj commit:*)
description: "Commit current changes with jj using an appropriate commit message."
---

## jj Commit

Look at the current working copy changes with `jj diff` and create a single commit with an appropriate message.

1. Run `jj diff` to understand what changed
2. If multiple files are changed, output "複数のファイルが変更されています。`jj:split-commit` を実行してください。" and stop immediately without committing
3. Craft a concise commit message following [Conventional Commits](https://www.conventionalcommits.org/) format (e.g. `feat:`, `fix:`, `chore:`, etc.)
4. Run `jj commit -m '<message>'`
