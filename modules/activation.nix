{ lib, ... }: {
  home.activation.createDirectories = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p $HOME/.config/zsh/completions
    mkdir -p $HOME/bin
    mkdir -p $HOME/.local/share/mise/completions
    mkdir -p $HOME/.local/state/zsh
    install -d -m 700 $HOME/.ssh
  '';
}
