#!/bin/bash
find ./config/zsh -type f -print | xargs -I{} ln -s {} ~
ln -s ./config/p10k/.p10k.zsh ~

mkdir ~/.config
ln -s ./config/navi ~/.config
ln -s ./config/zeno ~/.config
