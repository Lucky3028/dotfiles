#!/bin/sh

set -eu

# Generate completion files
script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
"${script_dir}/generate-tab-completion.sh"
