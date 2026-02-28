---
allowed-tools: Bash(jj diff:*), Bash(jj split:*), Bash(jj commit:*)
description: "Split working copy changes into meaningful commits by file using jj split."
---

## jj Split & Commit

Split the current working copy changes into meaningful commits grouped by logical concern.

1. Run `jj diff` to understand all changes
2. Group changed files into logical units (e.g. separate config, docs, features, fixes)
3. For each group except the last, run `jj split <files...> -m '<message>'`
4. Commit the remaining changes with `jj commit -m '<message>'`

Each commit message must follow [Conventional Commits](https://www.conventionalcommits.org/) format (e.g. `feat:`, `fix:`, `chore:`, etc.).

### Example

```
jj split foo.ts bar.ts -m 'feat: add foo feature'
jj commit -m 'docs: update README'
```
