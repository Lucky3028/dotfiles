#!/bin/bash

set -euxo pipefail

if [ -n "${SKIP_APT}" ]; then
  echo "Skip apt-get some deps."
  exit 0
fi

source "$(dirname "$0")/common.sh"

sudo /bin/bash "${REPO_DIR}/config/apt/install.sh"
