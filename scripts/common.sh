#!/bin/bash

set -x

export CURRENT_DIR="$(
  cd "$(dirname "$0")" || exit 1
  pwd
)"
export REPO_DIR="$(
  cd "$(dirname "$0")/.." || exit 1
  pwd
)"

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

export DENO_INSTALL="${DENO_INSTALL:-$XDG_DATA_HOME/deno}"
export VOLTA_HOME="${VOLTA_HOME:-$XDG_DATA_HOME/volta}"
