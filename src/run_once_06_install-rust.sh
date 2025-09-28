#!/bin/zsh

set -euxo pipefail

source ~/.zshenv

# Add completions
## rustup
$(which rustup) completions zsh > $ZDOTDIR/completions/_rustup
## cargo
$(which rustup) completions zsh cargo > $ZDOTDIR/completions/_cargo

