#!/bin/zsh

set -euxo pipefail

curl https://mise.run | sh

# Set completions
$MISE_INSTALL_PATH completion zsh > $ZDOTDIR/completions/_mise

