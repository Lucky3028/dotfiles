# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### paths ###
typeset -U path
typeset -U fpath

path=(
    "$DENO_INSTALL/bin"(N-/)
    "$CARGO_HOME/bin"(N-/)
    "$VOLTA_HOME/bin"(N-/)
    "$GO_HOME/bin"(N-/)
    "$path[@]"
)

fpath=(
    "$HOME/.config/zsh/completions"(N-/)
    "$fpath[@]"
)

### zi ###
source <(curl -sL https://git.io/zi-loader); zzinit

### powerlevel10k ###
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# End of lines configured by zsh-newuser-install

### plugins ###
zinit wait lucid null for \
    atinit'source "$HOME/.zshrc.lazy"' \
    @'zdharma-continuum/null'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# load fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# remove unnecessary command history
zshaddhistory() {
    local line="${1%%$'\n'}"
    [[ ! "$line" =~ "^(cd|jj?|lazygit|la|ll|ls|rm|rmdir)($| )" ]]
}

