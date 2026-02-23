#!/bin/zsh

set -euxo pipefail

source ~/.zshenv

if [ ! -d $ZDOTDIR/completions ]; then
  mkdir -p $ZDOTDIR/completions
fi

chezmoi completion zsh > $ZDOTDIR/completions/_chezmoi

if [ ! -d $MISE_TAB_COMP_PATH ]; then
  mkdir -p $MISE_TAB_COMP_PATH
fi

if [ ! -d ~/bin ]; then
  mkdir ~/bin
fi

if [ ! -d $XDG_STATE_HOME/zsh ]; then
  mkdir -p $XDG_STATE_HOME/zsh
fi

if [ ! -d ~/.ssh ]; then
  mkdir ~/.ssh
  chmod 700 ~/.ssh
fi
