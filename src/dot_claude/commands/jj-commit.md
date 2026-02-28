---
allowed-tools: Bash(jj commit:*)
description: "Commit current changes with jj using an appropriate commit message."
---

## jj Commit

Look at the current working copy changes with `jj diff` and create a commit with an appropriate message.

1. Run `jj diff` to understand what changed
2. Craft a concise commit message following [Conventional Commits](https://www.conventionalcommits.org/) format (e.g. `feat:`, `fix:`, `chore:`, etc.)
3. Run `jj commit -m '<message>'`
