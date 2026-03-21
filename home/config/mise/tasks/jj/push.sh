#!/bin/bash
#MISE description="Push the previous commit to remote"
#MISE dir="{{cwd}}"

set -euo pipefail

# main..@- の範囲にある bookmark（複数ありうるので先頭を取得）
bookmark=$(jj bookmark list -r 'main..@-' 2>/dev/null | awk -F: '{print $1}' | head -1)

# bookmark があれば @- に move して push
if [ -n "$bookmark" ]; then
  jj bookmark move "$bookmark" --to @-
  push_output=$(jj git push -b "$bookmark" 2>&1)
# bookmark がなければ新規作成して push
else
  push_output=$(jj git push -c @- 2>&1)
fi

echo "$push_output"
if echo "$push_output" | grep -q 'Nothing changed'; then
  exit 1
fi
