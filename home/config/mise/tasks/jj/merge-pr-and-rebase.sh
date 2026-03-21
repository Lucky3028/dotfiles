#!/bin/bash
#MISE description="Merge the pull request and rebase onto main"
#MISE dir="{{cwd}}"

set -euo pipefail

mise run jj:merge-pr
mise run jj:rebase
