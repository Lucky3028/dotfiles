#!/bin/zsh

set -euxo pipefail

curl https://mise.run | sh

# Install tools
$MISE_INSTALL_PATH install

# Add completions
## mise
$MISE_INSTALL_PATH completion zsh > $ZDOTDIR/completions/_mise
## Deno
deno completions zsh > $ZDOTDIR/completions/_deno
## Terraform
## Need not to add completions of Terraform b/c Terraform provides them by CLI

