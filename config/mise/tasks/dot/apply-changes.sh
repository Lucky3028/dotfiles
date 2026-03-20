#!/bin/bash
#MISE description="Apply home-manager configuration"

set -euo pipefail

dotfiles_dir="${DOTFILES_DIR:-${HOME}/dotfiles}"

NIX_CONFIG="experimental-features = nix-command flakes" nix run home-manager -- switch --flake "${dotfiles_dir}" -b backup
find ~ -maxdepth 5 -name "*.backup" -delete 2>/dev/null || true
