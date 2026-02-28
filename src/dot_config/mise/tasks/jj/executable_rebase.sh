#!/bin/bash
#MISE description="Fetch from remote and rebase onto main"

set -euo pipefail

jj git fetch
jj rebase -d main
