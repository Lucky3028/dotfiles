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
yui self-update -y
mise self-update -y
yui apply

# Apply mise tools
mise install
mise prune -y

# Apply sheldon
sheldon lock --update

# Check unreferenced Rust toolchains. Additional checkout roots can be provided
# as a colon-separated list in RUSTUP_TOOLCHAIN_GC_ROOTS.
rustup_toolchain_gc_args=(--root "${dotfiles_dir}")
ghq_root="$(ghq root)"
if [[ -d "${ghq_root}" && "${ghq_root}" != "${dotfiles_dir}" ]]; then
  rustup_toolchain_gc_args+=(--root "${ghq_root}")
fi
if [[ -n "${RUSTUP_TOOLCHAIN_GC_ROOTS:-}" ]]; then
  IFS=: read -r -a extra_roots <<<"${RUSTUP_TOOLCHAIN_GC_ROOTS}"
  for root in "${extra_roots[@]}"; do
    [[ -z "${root}" ]] || rustup_toolchain_gc_args+=(--root "${root}")
  done
fi
if [[ -n "${RUSTUP_TOOLCHAIN_GC_KEEP:-}" ]]; then
  IFS=: read -r -a keep_toolchains <<<"${RUSTUP_TOOLCHAIN_GC_KEEP}"
  for toolchain in "${keep_toolchains[@]}"; do
    [[ -z "${toolchain}" ]] || rustup_toolchain_gc_args+=(--keep "${toolchain}")
  done
fi
rustup_toolchain_gc_args+=(--apply)
if [[ "${RUSTUP_TOOLCHAIN_GC_ALLOW_NO_PINS:-0}" == "1" ]]; then
  rustup_toolchain_gc_args+=(--allow-no-pins)
fi
"${HOME}/bin/rustup-toolchain-gc" "${rustup_toolchain_gc_args[@]}"

info 'Applied dotfiles.'
