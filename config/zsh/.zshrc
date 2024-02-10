typeset -U path
typeset -U fpath

path=(
  "${DENO_INSTALL}/bin"(N-/)
  "${XDG_DATA_HOME}/gh-rd/bin"(N-/)
  "$path[@]"
)

fpath=(
  "${XDG_DATA_HOME}/zsh/completions"(N-/)
  "${XDG_DATA_HOME}/gh-rd/completions"(N-/)
  "$fpath[@]"
)

# Load sheldon
eval "${XDG_DATA_HOME}/gh-rd/packages/github.com/rossmacarthur/sheldon/sheldon.zsh"

# Load direnv
eval "${XDG_DATA_HOME}/gh-rd/packages/github.com/direnv/direnv/direnv.zsh"

# Load zabrze
eval "${XDG_DATA_HOME}/gh-rd/packages/github.com/Ryooooooga/zabrze/zabrze.zsh"

# Remove some commands from commands history file
# https://qiita.com/sho-t/items/d44bfbc783db7ca278c0
zshaddhistory() {
  local line="${1%%$'\n'}"
  [[ ! "$line" =~ "^(cd|l[als]|rm|rmdir|pwd)($| )" ]]
}
