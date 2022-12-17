### load fcitx for japanese input ###
#Added by bash script from https://astherier.com/blog/2021/07/windows11-wsl2-wslg-japanese/
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export DefaultIMModule=fcitx
if [ $SHLVL = 1 ] ; then
  (fcitx-autostart > /dev/null 2>&1 &)
  xset -r 49  > /dev/null 2>&1
fi
#Added by bash script: end

# XDG_CONFIG
export XDG_CONFIG_HOME="$HOME/.config"

# deno
export DENO_INSTALL="$HOME/.deno"

# Rust
export CARGO_HOME="$HOME/.cargo"

### FZF ###
export FZF_DEFAULT_OPTS='--reverse --border --ansi --bind="ctrl-d:print-query,ctrl-p:replace-query"'
export FZF_DEFAULT_COMMAND='fd --hidden --color=always'

# zeno.zsh
export ZENO_HOME="$HOME/.config/zeno"
export ZENO_ENABLE_SOCK=1
export ZENO_DISABLE_BUILTIN_COMPLETION=1
export ZENO_GIT_CAT="bat --color=always"
export ZENO_GIT_TREE="exa --tree"

# pmy
export PMY_RULE_PATH="$XDG_CONFIG_HOME/pmy/rules"
export PMY_SNIPPET_PATH="$XDG_CONFIG_HOME/pmy/snippets"

# Volta
export VOLTA_HOME="$HOME/.volta"

# Go
export GO_HOME="/usr/local/go"
