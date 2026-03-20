#!/bin/bash

set -euo pipefail

script_dir="$(cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P)"

# 0. システムパッケージ更新
sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get autoremove -y

# 1. Nix インストール
if ! command -v nix > /dev/null 2>&1; then
  curl -L https://nixos.org/nix/install | sh -s -- --no-daemon
  # shellcheck source=/dev/null
  source ~/.nix-profile/etc/profile.d/nix.sh
fi

# 2. home-manager 初回適用
NIX_CONFIG="experimental-features = nix-command flakes" nix run home-manager -- switch --flake "${script_dir}" -b backup
find ~ -maxdepth 5 -name "*.backup" -delete 2>/dev/null || true

# 3. デフォルトシェルを zsh に変更
zsh_path="$(which zsh)"
if [ "$(getent passwd "$USER" | cut -d: -f7)" != "$zsh_path" ]; then
  sudo chsh -s "$zsh_path" "$USER"
fi

# 4. Rust stable ツールチェーンのインストール
rustup default stable

# 5. mise でツールインストール
mise install

# 6. Claude CLI インストール / 更新
if command -v claude > /dev/null 2>&1; then
  claude update
else
  curl -fsSL https://claude.ai/install.sh | bash
fi

# 7. Doppler / GitHub CLI 認証
doppler login
gh auth login

# 8. git remote を SSH に変更
git -C "${script_dir}" remote set-url origin git@github.com:Lucky3028/dotfiles.git

# 9. jj 初期化
jj git init --colocate -R "${script_dir}"
