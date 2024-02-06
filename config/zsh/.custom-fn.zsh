# git addするファイルをfzfを用いて選択する
# See: https://dev.classmethod.jp/articles/fzf-original-app-for-git-add/
function ga() {
  local selected
  selected=$(unbuffer git status -s | fzf -m --ansi --preview="echo {} | awk '{print \$2}' | xargs git diff --color" | awk '{print $2}')
  if [ -n "$selected" ]; then
    # 改行と文字列の最初と最後のスペースを削除
    selected=$(echo $(tr '\n' ' ' <<<"$selected") | sed 's/^ *\| *$//')
    # echoしたものを引数に入れないと、なぜか「pathspec '' did not match any files」と言われる
    git add $(echo "$selected")

    echo "Completed: git add $selected"
  fi
}
