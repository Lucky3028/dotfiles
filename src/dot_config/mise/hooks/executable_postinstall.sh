#!/bin/zsh

set -euo pipefail

# Generate completion files
${0:a:h}/generate-tab-completion.sh
