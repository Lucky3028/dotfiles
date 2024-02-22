#!/bin/bash

set -x

source "$(dirname "$0")/common.sh"

# Volta

if [ -n "${SKIP_VOLTA}" ]; then
  echo "Skip install Volta."
  exit 0
fi

if [ -x "${VOLTA_HOME}/bin/volta" ]; then
  echo "Volta is already installed."
  curl https://get.volta.sh | bash -s -- --skip-setup
else
  echo "Installing Volta..."
  curl https://get.volta.sh | bash
fi

echo "Install Volta completions..."
mkdir -p "${XDG_DATA_HOME}/zsh/completions"
"${VOLTA_HOME}/bin/volta" completions -o "${XDG_DATA_HOME}/zsh/completions/_volta" zsh

# Node.js with Volta

if [ -n "${SKIP_NODE}" ]; then
  echo "Skip install Node.js."
  exit 0
fi

echo "Install Node.js LTS..."
"${VOLTA_HOME}/bin/volta" install node

# git-cz with Node.js

echo "Install git-cz..."
"${VOLTA_HOME}/bin/npm" install -g git-cz
