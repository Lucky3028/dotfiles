#!/bin/bash
#MISE description="Fetch from remote and rebase onto main"
#MISE dir="{{cwd}}"

set -euo pipefail

jj git fetch
jj rebase -d main
