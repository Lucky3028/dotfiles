# dotfiles

## Setup

```sh
cd
git clone https://github.com/Lucky3028/dotfiles.git
./dotfiles/install.sh
exit
```

> [!NOTE]
> `install.sh` がデフォルトシェルを zsh に変更しますが、`chsh` の変更は次回ログイン時に反映されます。
> `exec $SHELL -l` ではなく `exit` でセッションを抜けて再ログインしてください。