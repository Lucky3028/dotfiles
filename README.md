# dotfiles

## Setup

```sh
cd
git clone https://github.com/Lucky3028/dotfiles.git
./dotfiles/install.sh
exit
```

This repository uses [yui](https://github.com/yukimemi/yui) to manage
configuration files, `apt` for system packages, and `mise` for development
tools. Configuration files can be edited directly under `$HOME`; yui keeps
the repository and the live files linked.

Codex's writable `~/.codex/config.toml` is kept local. The shared Codex
defaults are stored in `~/.codex/dotfiles.config.toml`, and the `codex`
wrapper applies that profile automatically.

To update an existing installation:

```sh
cd ~/dotfiles
mise run dot:apply-changes
```

> [!NOTE]
> `install.sh` がデフォルトシェルを zsh に変更しますが、`chsh` の変更は次回ログイン時に反映されます。
> `exec $SHELL -l` ではなく `exit` でセッションを抜けて再ログインしてください。
