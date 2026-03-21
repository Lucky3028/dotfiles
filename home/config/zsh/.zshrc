typeset -U path PATH
path=(
  $path
  $HOME/bin(N-/)
  $HOME/.local/bin(N-/)
  $XDG_DATA_HOME/mise/shims(N-/)
  $CARGO_HOME/bin(N-/)
  # Add code.exe to PATH for WSL
  /mnt/c/Users/*/AppData/Local/Programs/Microsoft\ VS\ Code/bin(N-/)
  # Add pwsh.exe to PATH for WSL
  /mnt/c/Program\ Files/PowerShell/7(N-/)
)

typeset -U fpath FPATH
fpath=(
  $fpath
  $ZDOTDIR/completions(N-/)
  $MISE_TAB_COMP_PATH(N-/)
)

# Nix
if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
  . "$HOME/.nix-profile/etc/profile.d/nix.sh"
fi

# Load mise
eval "$(mise activate zsh)"

# Load sheldon
eval "$(sheldon source)"

if [[ "$OSTYPE" == "linux-gnu"* ]]; then

  # Run a script when it is NOT running in a container
  if ! env | grep -q container; then

    SSH_AGENT_FILE=~/.ssh/.ssh-agent

    if [ -f "$SSH_AGENT_FILE" ]; then
      source "$SSH_AGENT_FILE" > /dev/null
    fi

    if [ -z "$SSH_AGENT_PID" ] || ! kill -0 $SSH_AGENT_PID 2> /dev/null; then
      ssh-agent > "$SSH_AGENT_FILE"
      source "$SSH_AGENT_FILE" > /dev/null

      # Doppler から KEY__ プレフィックスの SSH 鍵を取得して ssh-agent に追加
      doppler secrets download --no-file --format json --project ssh-keys --config prod 2>/dev/null \
        | jq -c 'to_entries[] | select(.key | startswith("KEY__"))' \
        | while IFS= read -r item; do
            name=$(printf '%s' "$item" | jq -r '.key')
            keyfile=$(mktemp --tmpdir "XXXXXX_${name}")
            printf '%s' "$item" | jq -r '.value' > "$keyfile"
            chmod 600 "$keyfile"
            ssh-keygen -c -C "${name#KEY__}" -f "$keyfile" <<< "" >/dev/null 2>&1
            ssh-add "$keyfile" > /dev/null 2>&1
            rm -f "$keyfile" "${keyfile}.pub"
          done
    fi

  fi

fi
