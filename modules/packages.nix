{ pkgs, ... }: {
  home.packages = [
    # 基本ツール
    pkgs.curl
    pkgs.wget
    pkgs.git
    pkgs.gnupg
    pkgs.gzip
    pkgs.zip
    pkgs.unzip
    pkgs.xz
    pkgs.htop
    pkgs.jq
    pkgs.less
    pkgs.openssh
    pkgs.socat
    pkgs.vim
    pkgs.zsh
    pkgs.dnsutils
    pkgs.procps
    # 開発ライブラリ
    pkgs.gcc
    pkgs.fuse
    pkgs.sqlite
    pkgs.openssl
    # ツール
    pkgs.mise
    pkgs.rustup
    pkgs.podman
    pkgs.podman-compose
  ];
}
