#!/bin/sh

set -eu

completion_dir="${MISE_TAB_COMP_PATH:-${XDG_DATA_HOME:-$HOME/.local/share}/mise/completions}"
mkdir -p "$completion_dir"

write_completion() {
  name="$1"
  shift
  "$@" > "${completion_dir}/_${name}"
}

write_completion jj env COMPLETE=zsh jj
write_completion starship starship completions zsh
write_completion gh gh completion --shell zsh
write_completion yq yq shell-completion zsh
write_completion sheldon sheldon completions --shell zsh
write_completion bw bw completion --shell zsh
write_completion rg rg --generate complete-zsh
write_completion zellij zellij setup --generate-completion zsh
write_completion yui yui completion zsh

### Make sym link to already created file

ghq_root=$(mise where ghq)
for ghq_completion in "${ghq_root}"/ghq_*/misc/zsh/_ghq; do
  if [ -f "$ghq_completion" ]; then
    ln -sf "$ghq_completion" "${completion_dir}/_ghq"
    break
  fi
done
