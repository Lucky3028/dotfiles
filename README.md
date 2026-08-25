# dotfiles

Linux / WSL 向けの個人用 dotfiles です。シェル、開発ツール、Git・jj、Codex、SSH 周辺の設定を [`yui`](https://github.com/yukimemi/yui) で管理し、ツール本体は [`mise`](https://mise.jdx.dev/) で揃えます。

## このリポジトリで管理するもの

- `home/.config` 以下のアプリケーション設定
- zsh と XDG Base Directory の設定
- Git、jj、GitHub CLI、SSH の設定
- mise で導入する開発ツールと mise タスク
- `~/bin` に置く補助スクリプト
- Codex の共有プロファイルとルール
- apt で導入する OS パッケージ

秘密鍵、Doppler の値、Bitwarden のセッションなどの秘密情報はリポジトリに保存しません。SSH 鍵は起動時に Doppler から取得して ssh-agent に登録します。

## ディレクトリ構造

```text
.
├── README.md                         # このドキュメント
├── LICENSE                           # MIT License
├── config.toml                       # yui のマウント定義
├── install.sh                        # 初回セットアップスクリプト
├── packages/
│   └── apt.txt                       # apt で導入するパッケージ一覧
├── home/                             # ホームディレクトリへ反映する設定
│   ├── .codex/
│   │   ├── AGENTS.md                 # Codex の共有指示
│   │   ├── dotfiles.config.toml      # dotfiles 用 Codex プロファイル
│   │   └── rules/default.rules       # Codex の既定ルール
│   ├── .config/
│   │   ├── gh/                       # GitHub CLI
│   │   ├── git/                      # Git と署名設定
│   │   ├── jj/                       # jj のユーザー設定
│   │   ├── mise/                     # ツール一覧、フック、タスク
│   │   ├── sheldon/                  # zsh プラグイン管理
│   │   ├── starship/                 # プロンプト
│   │   ├── vim/                      # Vim
│   │   ├── zabrze/                   # ターミナル関連設定
│   │   └── zsh/                      # zshenv、zshrc、補完
│   ├── .githooks/pre-push            # push 前の gitleaks チェック
│   ├── .ssh/                         # SSH 設定と署名者情報
│   └── bin/                          # ~/bin のコマンドと関数
├── .github/workflows/                # CI と設定検証
├── .yuiignore                        # yui の除外設定
└── .gitignore                        # リポジトリ固有の除外設定
```

`home/.config/mise` には、次のような mise の構成要素があります。

- `config.toml`: sheldon、gh、jj、fzf、ghq、starship、Codex などのバージョン固定
- `hooks/`: ツール導入後の zsh 補完生成
- `tasks/dot/`: dotfiles の更新・反映
- `tasks/git/`: GitHub リモートを SSH URL に切り替える処理
- `tasks/jj/`: fetch、rebase、push、PR マージの補助

## yui の管理対象

ルートの [`config.toml`](config.toml) で、リポジトリ内の設定と実際のホームディレクトリの対応を定義しています。

| リポジトリ | 反映先 | 補足 |
| --- | --- | --- |
| `home/.config` | `~/.config` | アプリケーション設定全般 |
| `home/.ssh` | `~/.ssh` | SSH 設定と `allowed_signers` |
| `home/.githooks` | `~/.githooks` | グローバル Git hooks |
| `home/bin` | `~/bin` | 補助コマンド |
| `home/.codex` | `~/.codex` | `per-file` 方式で共有ファイルだけを管理 |

さらに `home/.config/zsh/.yuilink` により、`home/.config/zsh/zshenv` を `~/.zshenv` として反映します。Codex の通常の `~/.codex/config.toml` はローカル設定として残し、dotfiles 側の `dotfiles.config.toml` を共有プロファイルとして使います。

## 初回セットアップ

### 前提

- Debian / Ubuntu 系 Linux または WSL
- `sudo` が使えるユーザー
- パッケージとツールをダウンロードできるネットワーク
- GitHub アカウントと、必要に応じて Doppler アカウント

`install.sh` は `apt-get update`、`upgrade`、`autoremove` を実行するため、内容を確認してから実行してください。既定のシェルを zsh に変更し、GitHub CLI と Doppler のログインも対話的に行います。

```sh
cd ~
git clone https://github.com/Lucky3028/dotfiles.git
cd dotfiles
./install.sh
```

スクリプトは次の順序でセットアップします。

1. `packages/apt.txt` の OS パッケージを導入
2. Rust stable と mise を準備
3. `yui-cli` を導入し、設定をホームへ反映
4. zsh を既定のログインシェルに設定
5. mise 管理のツールをインストールし、補完を生成
6. Doppler と GitHub CLI の認証を確認
7. リモート URL を SSH 形式に変更
8. jj の colocated repository を初期化（未初期化の場合）

シェル変更は次回ログイン時に反映されます。インストール後は `exec $SHELL -l` ではなく、いったん `exit` して再ログインしてください。

## 既存環境の更新

```sh
cd ~/dotfiles
mise run dot:apply-changes
```

このタスクは、origin の fetch と `main@origin` への rebase、yui と mise 自体の更新、yui による設定反映、mise ツールの導入・不要版削除、sheldon のプラグインロック更新を行います。

設定だけを反映したい場合は、次のコマンドも使えます。

```sh
yui list --no-color
yui apply
mise install
```

設定ファイルを追加・移動したときは、`config.toml` のマウント定義や `.yuiignore` への追加が必要になることがあります。

## 主な設定とコマンド

### zsh

`home/.config/zsh` で XDG の各ディレクトリ、履歴、mise、sheldon、Starship を設定します。`~/bin` と mise の shims を PATH に追加し、zsh の補完も mise の postinstall hook で生成します。

WSL では、Linux 側の ssh-agent を TCP 経由で Windows 側から利用できるようにし、`SSH_AUTH_SOCK` を Windows のユーザー環境変数へ設定します。`pwsh.exe` が PATH にない環境ではこの処理は利用できません。

### `~/bin` の補助コマンドと zsh 関数

`home/bin/functions` には sheldon が現在の zsh に読み込む関数を置きます。`cd` や `export` の結果を呼び出し元のシェルへ反映する必要がある処理はここに置き、独立して実行するコマンドは `home/bin` 直下に置きます。

| コマンド | 役割 |
| --- | --- |
| `codex` | `--profile` が指定されていない場合に `dotfiles` プロファイルを使う Codex wrapper |
| `cd-ghq` | `ghq list` の結果を fzf で選んで移動する zsh 関数 |
| `login-bitwarden` / `unlock-bitwarden` | Bitwarden CLI のログインと、端末ごとの unlock |
| `kill-ssh-agent` | WSL 用の ssh-agent 中継を停止する zsh 関数 |
| `restore-zsh-history` | 壊れた zsh 履歴を `strings` で復旧する |
| `toast` | WSL から BurntToast を使って Windows 通知を表示する |

`toast` は WSL 専用で、初回実行時に PowerShell の `BurntToast` モジュールを導入します。

### Codex

```sh
codex                             # dotfiles プロファイルで起動
codex --profile default           # 明示したプロファイルをそのまま使用
```

通常の `~/.codex/config.toml` はユーザー固有の設定として管理対象から外し、共有したい既定値だけを `~/.codex/dotfiles.config.toml` で管理します。

### jj とリモート

このリポジトリでは変更管理に jj を使います。GitHub のリモートとの同期には、mise タスクから jj の Git 連携機能を利用します。

```sh
jj status
jj log
mise run jj:rebase
mise run jj:push
```

初回セットアップ時には `mise run git:use-ssh-remote` が実行され、GitHub の `origin` は SSH URL になります。

## パッケージの追加・変更

- apt パッケージ: [`packages/apt.txt`](packages/apt.txt) に 1 行 1 パッケージで追加
- 開発ツール: [`home/.config/mise/config.toml`](home/.config/mise/config.toml) の `[tools]` に追加
- mise タスク: [`home/.config/mise/tasks/`](home/.config/mise/tasks/) に実行可能なスクリプトを追加
- ホームへ反映する設定: `home/` 以下に追加し、必要なら [`config.toml`](config.toml) のマウントを更新

ツールのバージョンは mise の設定で固定しています。Renovate 用コメントが付いたエントリは、自動更新の対象です。

## CI と安全確認

`.github/workflows/` では、主に次の検証を行います。

- yui の管理対象一覧を検証
- shell script のフォーマットを確認
- gitleaks による秘密情報の検出
- Codex ルール、Renovate 設定、ghasec の検証

push 前にも [`home/.githooks/pre-push`](home/.githooks/pre-push) が gitleaks を実行します。秘密情報を追加しないこと、ローカル専用の設定は `config.local.toml` などの除外対象へ置くことを徹底してください。

## ライセンス

このリポジトリの設定・スクリプトは [`MIT License`](LICENSE) の下で公開しています。
