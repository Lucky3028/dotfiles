#!/bin/bash
#MISE description="Create or update a pull request for the previous commit"
#MISE dir="{{cwd}}"

set -euo pipefail

bookmark=$(jj bookmark list -r @- | awk -F: '{print $1}')
diff=$(jj diff --from main --to @-)

json=$(echo "$diff" | claude -p 'Based on this diff, respond with ONLY a JSON object (no markdown, no extra text):
{"title": "concise PR title in conventional commits style", "body": "PR description explaining what was changed and why"}')

title=$(echo "$json" | jq -r '.title')
body=$(echo "$json" | jq -r '.body')

# PR が既に存在する場合は更新、なければ新規作成
if gh pr view --head "$bookmark" > /dev/null 2>&1; then
  gh pr edit --head "$bookmark" --title "$title" --body "$body"
else
  gh pr create --base main --head "$bookmark" --title "$title" --body "$body"
fi
