#!/bin/bash

set -euo pipefail

script_dir="$(cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P)"

# Keep bootstrap-installed tools available in this shell.
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export MISE_CONFIG_HOME="${MISE_CONFIG_HOME:-$XDG_CONFIG_HOME/mise}"
export MISE_TAB_COMP_PATH="${MISE_TAB_COMP_PATH:-$XDG_DATA_HOME/mise/completions}"

# 0. System packages
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get autoremove -y

mapfile -t apt_packages < <(
  awk '!/^[[:space:]]*#/ && NF { print $1 }' "${script_dir}/packages/apt.txt"
)
sudo apt-get install -y "${apt_packages[@]}"

# 1. Rust toolchain
rustup default stable

# 2. mise
if ! command -v mise >/dev/null 2>&1; then
  curl -fsSL https://mise.run | sh
fi
export PATH="$HOME/.local/bin:$PATH"

# 3. yui
if ! command -v yui >/dev/null 2>&1; then
  yui_version="${YUI_VERSION:-0.10.0}"
  cargo install yui-cli --locked --version "${yui_version}"
fi

# 4. Apply dotfiles
export DOTFILES="${script_dir}"
cd "${script_dir}"
mkdir -p "$HOME/.config/zsh/completions" \
  "$HOME/.local/share/mise/completions" \
  "$HOME/.local/state/zsh"
install -d -m 700 "$HOME/.ssh"

# Preserve the executable files that Home Manager used to mark explicitly.
find "${script_dir}/home" -type f -name '*.sh' -exec chmod +x {} +
chmod +x "${script_dir}/home/.githooks/pre-push" \
  "${script_dir}/home/bin/codex" \
  "${script_dir}/home/.codex/bin/ssh" \
  "${script_dir}/home/bin/restore-zsh-history" \
  "${script_dir}/home/bin/toast"

yui apply
chmod 700 "$HOME/.ssh"

# 5. Default shell
zsh_path="$(command -v zsh)"
if [ "$(getent passwd "$USER" | cut -d: -f7)" != "$zsh_path" ]; then
  sudo chsh -s "$zsh_path" "$USER"
fi

# 6. mise tools
eval "$(mise activate bash)"
mise install

# 7. Doppler / GitHub CLI authentication
if ! doppler me --no-check-version >/dev/null 2>&1; then
  doppler login
fi
if ! gh auth status >/dev/null 2>&1; then
  gh auth login
fi

# 8. Use an SSH remote
(cd "${script_dir}" && mise run git:use-ssh-remote)

# 9. Initialize jj
if ! jj root -R "${script_dir}" >/dev/null 2>&1; then
  jj git init --colocate -R "${script_dir}"
fi
