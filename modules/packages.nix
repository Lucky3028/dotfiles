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
    pkgs.fuse
    pkgs.sqlite
    pkgs.openssl
    # ツール（run_onchange_03〜05 の代替）
    pkgs.mise
    pkgs.rustup
    pkgs.podman
    pkgs.podman-compose
  ];
}
