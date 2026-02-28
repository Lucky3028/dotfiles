#!/bin/bash
#MISE description="Merge the pull request for the previous commit"
#MISE dir="{{cwd}}"

set -euo pipefail

bookmark=$(jj bookmark list -r @- | awk -F: '{print $1}' | grep -v '^main$')

if [ -z "$bookmark" ]; then
  echo '最新のコミットに bookmark がありません。先に jj:push を実行してください。'
  exit 1
elif ! gh pr view "$bookmark" > /dev/null 2>&1; then
  echo 'PR が見つかりません。先に jj:create-pr を実行してください。'
  exit 1
fi

gh pr merge "$bookmark" --merge
