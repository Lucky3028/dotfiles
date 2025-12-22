#!/bin/zsh

set -euxo pipefail

curl -LsSf https://astral.sh/uv/install.sh | sh

# Add completions
## uv
uv generate-shell-completion zsh > $ZDOTDIR/completions/_uv
## uvx
uvx --generate-shell-completion zsh > $ZDOTDIR/completions/_uvx

