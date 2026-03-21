#!/bin/bash
#MISE description="Commit current changes with an AI-generated message"
#MISE dir="{{cwd}}"

set -euo pipefail

claude -p '/jj-commit'
