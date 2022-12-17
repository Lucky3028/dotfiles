#!/bin/bash

create_symlink() {
  if [ "$#" -lt 2 ]; then
    echo "Syntax Error: create_symlink <File or dir name> <Parent Dir>"
    return
  fi

  PARENT=$1
  SOURCE=$2

  SOURCE_DIR=~/dotfiles/config/$SOURCE

  ln -s "$SOURCE_DIR" "$PARENT"/
  echo "Created $PARENT/$SOURCE"
}

cd ~/dotfiles

echo "Start to create symlinks for zsh files."
find ./config/zsh -type f -print | xargs -I{} ln -s {} ~/
echo "Fin."

echo "Start to create symlinks for each files."
FILES=(
  p10k/.p10k.zsh
  vim/.vimrc
  git/.gitconfig
)
for file in "${FILES[@]}"; do
  create_symlink ~ "$file"
done
echo "Fin."

echo "Start to create symlink on $XDG_CONFIG_DIR."
XDG_CONFIG_DIR=~/.config
DIRS=(
  navi
  zeno
  gh-cli
  zabrze
)
mkdir -p "$XDG_CONFIG_DIR"
for dir in "${DIRS[@]}"; do
  create_symlink "$XDG_CONFIG_DIR" "$dir"
done
echo "Fin."
