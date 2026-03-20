#!/bin/bash
#MISE description="Apply home-manager configuration"

set -euo pipefail

dotfiles_dir="${DOTFILES_DIR:-${HOME}/dotfiles}"

jj git fetch --remote origin -R "${dotfiles_dir}"
jj rebase -d main@origin -R "${dotfiles_dir}"

NIX_CONFIG="experimental-features = nix-command flakes" nix run home-manager -- switch --flake "${dotfiles_dir}" -b backup
find ~ -maxdepth 5 -name "*.backup" -delete 2>/dev/null || true
