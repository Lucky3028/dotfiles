#!/bin/bash
#MISE description="Push the previous commit and create or update a pull request"
#MISE dir="{{cwd}}"

set -euo pipefail

mise run jj:push || exit 0
mise run jj:create-pr
