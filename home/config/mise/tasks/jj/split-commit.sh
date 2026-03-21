#!/bin/bash
#MISE description="Split and commit changes with AI-generated messages"
#MISE dir="{{cwd}}"

set -euo pipefail

claude -p '/jj-split-commit'
