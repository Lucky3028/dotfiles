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

# deno
export DENO_INSTALL="$HOME/.deno"

# Rust
export CARGO_HOME="$HOME/.cargo"

### FZF ###
export FZF_DEFAULT_OPTS='--reverse --border --ansi --bind="ctrl-d:print-query,ctrl-p:replace-query"'
export FZF_DEFAULT_COMMAND='fd --hidden --color=always'
