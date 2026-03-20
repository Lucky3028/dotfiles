#!/bin/bash

set -euo pipefail

script_dir="$(cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P)"

# 1. Nix インストール
if ! command -v nix > /dev/null 2>&1; then
  curl -L https://nixos.org/nix/install | sh -s -- --no-daemon
  # shellcheck source=/dev/null
  source ~/.nix-profile/etc/profile.d/nix.sh
fi

# 2. home-manager 初回適用
nix run home-manager -- switch --flake "${script_dir}"

# 3. Claude CLI インストール / 更新
if command -v claude > /dev/null 2>&1; then
  claude update
else
  curl -fsSL https://claude.ai/install.sh | bash
fi
