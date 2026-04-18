#!/bin/bash
#MISE description="Apply home-manager configuration"

set -euo pipefail

dotfiles_dir="${DOTFILES_DIR:-${HOME}/dotfiles}"
function info () {
  # Output messages with green color
  printf '\033[38;5;154m%s\033[m\n' "$@"
}

info 'Update dotfiles...'
# Update repository
jj git fetch --remote origin -R "${dotfiles_dir}"
jj rebase -d main@origin -R "${dotfiles_dir}"
info 'Updated dotfiles.'
echo ''

info 'Apply dotfiles...'
# Apply nix
NIX_CONFIG="experimental-features = nix-command flakes" nix run home-manager -- switch --flake "${dotfiles_dir}" -b backup
find ~ -maxdepth 5 -name "*.backup" -delete 2>/dev/null || true
# Apply mise
mise install
mise prune -y
info 'Applied dotfiles.'
