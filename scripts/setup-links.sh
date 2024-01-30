#!/bin/bash

set -euxo pipefail

source "$(dirname "$0")/common.sh"

if [[ ! -d "$HOME/.ssh" ]]; then
  mkdir -p "$HOME/.ssh"
  chmod 700 "$HOME/.ssh"
fi

mkdir -p \
  "$XDG_CONFIG_HOME" \
  "$XDG_STATE_HOME"

ln -sfv "${REPO_DIR}/config/"* "$XDG_CONFIG_HOME"
ln -sfv "${XDG_CONFIG_HOME}/zsh/.zshenv" "$HOME/.zshenv"
