#!/bin/zsh

set -euo pipefail

### Generate completion file to run cmd

typeset -A COMPLETIONS
COMPLETIONS=(
  jj "COMPLETE=zsh jj"
  starship "starship completions zsh"
  gh "gh completion --shell zsh"
  yq "yq shell-completion zsh"
  sheldon "sheldon completions --shell zsh"
  bw "bw completion --shell zsh"
  rg "rg --generate complete-zsh"
)

for cmd in ${(k)COMPLETIONS}; do
  eval "$COMPLETIONS[$cmd]" > "$MISE_TAB_COMP_PATH/_$cmd"
done

### Make sym link to already created file

typeset -A FILES
FILES=(
  ghq $(mise where ghq)/ghq_*/misc/zsh/_ghq
)

for cmd in ${(k)FILES}; do
  ln -sf "$FILES[$cmd]" "$MISE_TAB_COMP_PATH/_$cmd"
done
