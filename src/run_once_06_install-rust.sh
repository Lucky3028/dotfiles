#!/bin/zsh

set -euxo pipefail

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | \
  sh -s -- --no-modify-path --default-toolchain stable --profile default -y

# Add completions
## rustup
$CARGO_HOME/bin/rustup completions zsh > $ZDOTDIR/completions/_rustup
## cargo
$CARGO_HOME/bin/rustup completions zsh cargo > $ZDOTDIR/completions/_cargo

