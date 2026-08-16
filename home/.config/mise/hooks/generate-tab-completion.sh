#!/bin/sh

set -eu

completion_dir="${MISE_TAB_COMP_PATH:-${XDG_DATA_HOME:-$HOME/.local/share}/mise/completions}"
mkdir -p "$completion_dir"

write_completion() {
  name="$1"
  shift
  "$@" >"${completion_dir}/_${name}"
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

ghq_root=$(mise where github:x-motemen/ghq 2>/dev/null || true)
ghq_completion=
if [ -n "$ghq_root" ]; then
  for candidate in \
    "${ghq_root}/misc/zsh/_ghq" \
    "${ghq_root}"/ghq_*/misc/zsh/_ghq; do
    if [ -f "$candidate" ]; then
      ghq_completion="$candidate"
      break
    fi
  done
fi

if [ -n "$ghq_completion" ]; then
  ln -sfn "$ghq_completion" "${completion_dir}/_ghq"
elif [ -L "${completion_dir}/_ghq" ]; then
  rm "${completion_dir}/_ghq"
fi
