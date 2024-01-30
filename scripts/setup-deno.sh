#!/bin/bash

set -euxo pipefail

source "$(dirname "$0")/common.sh"

if [ -n "${SKIP_DENO}" ]; then
  echo "Skip install deno."
  exit 0
fi

if [ -x "${DENO_INSTALL}/bin/deno" ]; then
  echo "Deno is already installed."
  "${DENO_INSTALL}/bin/deno" upgrade
else
  echo "Installing Deno..."
  curl -fsSL https://deno.land/x/install/install.sh | /bin/sh
fi

echo "Install Deno completions..."
mkdir -p "${XDG_DATA_HOME}/zsh/completions"
"${DENO_INSTALL}/bin/deno" completions zsh > "${XDG_DATA_HOME}/zsh/completions/_deno"
