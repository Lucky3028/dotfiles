#!/usr/bin/env python3
"""
PreToolUse hook: curl コマンドをGETリクエストのみ許可する
"""
import json
import re
import sys

data = json.load(sys.stdin)
command = data.get("tool_input", {}).get("command", "")

# curl コマンドが含まれていない場合はスルー
if not re.search(r'\bcurl\b', command):
    sys.exit(0)

# GETと明示されている場合は許可
explicit_get = re.search(
    r'(?:-X|--request)\s+GET\b',
    command,
    re.IGNORECASE
)

# -X / --request フラグが一切ない場合はデフォルトGETなので許可
has_method_flag = re.search(r'(?:-X|--request)\b', command)

if explicit_get or not has_method_flag:
    sys.exit(0)

# それ以外はすべてブロック
print(json.dumps({
    "decision": "block",
    "reason": "curl はGETリクエストのみ許可されています。"
}))
sys.exit(0)
