#!/bin/zsh

set -euxo pipefail

curl -fsSL https://moonrepo.dev/install/proto.sh \
  | bash -s -- --yes --no-modify-profile --no-modify-path

set +x && source ~/.zshenv && set -x

proto completions --shell zsh > $ZSH_COMP/_proto

