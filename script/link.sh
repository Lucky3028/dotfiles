#!/bin/bash
# Move current dir to repository root
# cf.
cd $(dirname $0)/../
find $(pwd)/config/zsh -type f -print | xargs -I{} ln -s {} ~/
ln -s $(pwd)/config/p10k/.p10k.zsh ~/
ln -s $(pwd)/config/vim/.vimrc ~/
ln -s $(pwd)/config/git/.gitconfig ~/

mkdir ~/.config
ln -s $(pwd)/config/navi ~/.config/
ln -s $(pwd)/config/zeno ~/.config/
ln -s $(pwd)/config/gh-cli ~/.config/
