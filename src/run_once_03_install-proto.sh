#!/bin/zsh

set -euxo pipefail

curl -fsSL https://moonrepo.dev/install/proto.sh \
  | bash -s -- --yes --no-modify-profile --no-modify-path

$PROTO_HOME/bin/proto completions --shell zsh > $ZDOTDIR/completions/_proto

