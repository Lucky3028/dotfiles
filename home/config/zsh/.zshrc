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

  export SSH_AUTH_SOCK=/tmp/ssh-agent.sock
  SSH_AGENT_LISTENING_PORT=2222

  if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -a "$SSH_AUTH_SOCK" > /dev/null
  fi

  if grep -qi microsoft /proc/version; then
    # WSL で動いている ssh-agent に Windows からアクセスするため、socat で UNIX ドメインソケットを TCP に中継
    if ! pgrep -f "socat.*${SSH_AGENT_LISTENING_PORT}" > /dev/null; then
      # setsid で実行することで、ターミナルを閉じた後も実行し続けられる
      setsid socat TCP-LISTEN:${SSH_AGENT_LISTENING_PORT},bind=127.0.0.1,reuseaddr,fork UNIX-CONNECT:$SSH_AUTH_SOCK >/dev/null 2>&1 &
    fi
    # Windows のユーザー環境変数 SSH_AUTH_SOCK を設定する
    powershell.exe -Command "[Environment]::SetEnvironmentVariable('SSH_AUTH_SOCK', '127.0.0.1:${SSH_AGENT_LISTENING_PORT}', 'User')"
  fi

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

  # Doppler から BW_SESSION を読み込む
  _bw_session=$(doppler secrets get BW_SESSION --plain --project personal-secrets --config prd 2>/dev/null)
  if [[ -n "$_bw_session" ]]; then
    export BW_SESSION="$_bw_session"
  fi
  unset _bw_session

  # ssh-agent を止める
  kill-ssh-agent() {
    pkill -f "socat.*TCP-LISTEN:${SSH_AGENT_LISTENING_PORT}"
  }

  # Bitwarden のログインセッションを更新して Doppler に SSH 鍵を保存し直す
  refresh-doppler-ssh-key() {
    local session
    session=$(bw unlock --raw)
    if [[ -n "$session" ]]; then
      export BW_SESSION="$session"
      if doppler secrets set "BW_SESSION=$session" --project personal-secrets --config prd > /dev/null 2>&1; then
        echo "BW_SESSION saved to Doppler"
      else
        echo "Failed to save BW_SESSION to Doppler. Run 'doppler login' and try again." >&2
      fi
    fi
  }

fi
