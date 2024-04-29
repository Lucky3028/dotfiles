#!/bin/bash

set -x

source "$(dirname "$0")/common.sh"

/bin/bash "${CURRENT_DIR}/setup-apt.sh"
/bin/bash "${CURRENT_DIR}/setup-links.sh"
/bin/bash "${CURRENT_DIR}/setup-volta.sh"
/bin/bash "${CURRENT_DIR}/setup-deno.sh"
/bin/bash "${CURRENT_DIR}/setup-gh-rd.sh"
