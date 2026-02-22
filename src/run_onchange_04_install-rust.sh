#!/bin/zsh

set -euxo pipefail

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | \
  sh -s -- --no-modify-path --default-toolchain stable --profile default -y

source ~/.zshenv

# Add completions
## rustup
$(which rustup) completions zsh > $ZDOTDIR/completions/_rustup
## cargo
$(which rustup) completions zsh cargo > $ZDOTDIR/completions/_cargo

