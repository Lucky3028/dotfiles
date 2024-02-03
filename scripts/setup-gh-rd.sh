#!/bin/bash

set -x

if [ -n "${SKIP_GHRD}" ]; then
  echo "Skip install gh-rd."
  exit 0
fi

source "$(dirname "$0")/common.sh"

export PATH="${DENO_INSTALL}/bin:$PATH"

echo "Installing gh-rd..."
curl -fsSL https://raw.githubusercontent.com/Ryooooooga/gh-rd/main/install.bash | /bin/bash

"${XDG_DATA_HOME}/gh-rd/bin/gh-rd"
