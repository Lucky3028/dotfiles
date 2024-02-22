# XDG_CONFIG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# Deno
export DENO_INSTALL="${XDG_DATA_HOME}/deno"

# Volta
export VOLTA_HOME="${XDG_DATA_HOME}/volta"

# zsh
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
export HISTFILE="${XDG_DATA_HOME}/zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000

# Sheldon
export SHELDON_CONFIG_DIR="${XDG_CONFIG_HOME}/sheldon"

# gh-rd
export GHRD_CONFIG_HOME="${XDG_CONFIG_HOME}/gh-rd"
export GHRD_DATA_HOME="${XDG_DATA_HOME}/gh-rd"

# enhancd
export ENHANCD_DIR="${XDG_DATA_HOME}/enhancd"

# vim
export MYVIMRC="${XDG_CONFIG_HOME}/vim/vimrc"
export VIMINIT="source ${MYVIMRC}"

# git
export GIT_CONFIG_GLOBAL="${XDG_CONFIG_HOME}/git/gitconfig"

# fzf
export FZF_DEFAULT_OPTS='--reverse --border --ansi --bind="ctrl-d:print-query,ctrl-p:replace-query"'
export FZF_DEFAULT_COMMAND='fd --hidden --color=always'
