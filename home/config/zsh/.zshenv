# XDG_BASE
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

# zsh
export ZDOTDIR=$XDG_CONFIG_HOME/zsh
export EDITOR=$(which vim)

# zsh history
export HISTFILE=$XDG_STATE_HOME/zsh/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000

# Rust
export CARGO_HOME=$HOME/.cargo

# vim
export MYVIMRC=$XDG_CONFIG_HOME/vim/vimrc
export VIMINIT='source $MYVIMRC'

# less
export LESSHISTFILE=$XDG_STATE_HOME/less/.lesshst
export LESSOPEN="| /usr/bin/lesspipe %s";
export LESSCLOSE="/usr/bin/lesspipe %s %s";

# mise
export MISE_CONFIG_HOME=$XDG_CONFIG_HOME/mise
export MISE_TAB_COMP_PATH=$XDG_DATA_HOME/mise/completions

# Starship
export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship/starship.toml

# enhancd
export ENHANCD_FILTER="fzf --height 40%:fzy"

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  if grep -qi microsoft /proc/version 2>/dev/null; then

    # Browser Settings
    export BROWSER='/mnt/c/Windows/System32/rundll32.exe url.dll,FileProtocolHandler'

  fi
fi
