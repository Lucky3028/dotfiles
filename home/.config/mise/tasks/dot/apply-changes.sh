#!/bin/bash
#MISE description="Apply dotfiles configuration"

set -euo pipefail

function info() {
  # Output messages with green color
  # ref. https://qiita.com/ko1nksm/items/095bdb8f0eca6d327233
  printf '\033[38;5;154m%s\033[m\n' "$@"
}

dotfiles_dir="${DOTFILES_DIR:-${HOME}/dotfiles}"
cd "${dotfiles_dir}"

info 'Update dotfiles...'
# Update repository
jj git fetch --remote origin
jj rebase -d main@origin
info 'Updated dotfiles.'
echo ''

info 'Apply dotfiles...'
yui apply

# Apply mise tools
mise install
mise prune -y

# Apply sheldon
sheldon lock --update
info 'Applied dotfiles.'
