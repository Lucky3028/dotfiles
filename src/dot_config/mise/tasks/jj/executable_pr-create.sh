#!/bin/bash
#MISE description="Create a pull request for the previous commit"
#MISE dir="{{cwd}}"

set -euo pipefail

bookmark=$(jj bookmark list -r @- | awk -F: '{print $1}')
diff=$(jj diff --from main --to @-)

json=$(echo "$diff" | claude -p 'Based on this diff, respond with ONLY a JSON object (no markdown, no extra text):
{"title": "concise PR title in conventional commits style", "body": "PR description explaining what was changed and why"}')

title=$(echo "$json" | jq -r '.title')
body=$(echo "$json" | jq -r '.body')

gh pr create --base main --head "$bookmark" --title "$title" --body "$body"
