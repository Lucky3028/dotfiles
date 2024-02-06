# git addするファイルをfzfを用いて選択する
# See: https://dev.classmethod.jp/articles/fzf-original-app-for-git-add/
function ga() {
  local selected
  selected=$(unbuffer git status -s | fzf -m --ansi --preview="echo {} | awk '{print \$2}' | xargs git diff --color" | awk '{print $2}')
  if [ -n "$selected" ]; then
    selected=$(tr '\n' ' ' <<<"$selected")
    git add "$selected"
    echo "Completed: git add $selected"
  fi
}
