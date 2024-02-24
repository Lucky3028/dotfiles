#!/bin/bash

set -euxo pipefail

# This script must be run by root!
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root."
  exit 1
fi

# Install commands with apt

# Set apt repositories for JP
sed -i.bak -r 's@http://(jp\.)?archive\.ubuntu\.com/ubuntu/?@http://ftp.udx.icscoe.jp/Linux/ubuntu/@g' /etc/apt/sources.list

# Install required deps
apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends \
  ca-certificates \
  curl \
  gnupg \
  gpg \
  libfuse-dev \
  libsqlite3-dev \
  libssl-dev \
  lsb-release \
  unzip \
  vim-gtk \
  wget \
  zip \
  zsh

# Install and register a gpg key for apt repository
# Use not add-apt-repository but this function because the command oftens hangs up
# ref. https://taktak.jp/2019/09/21/4126/
# ref. https://zenn.dev/spiegel/articles/20220508-apt-key-is-deprecated
function install-key() {
  REPO_NAME=${1:?'undefined'}
  KEY_URL=${2:?'undefined'}
  REPO_URL=${3:?'undefined'}
  RELEASE_VER=${4:?'undefined'}
  KEYRINGS_DIR=/etc/apt/keyrings
  KEY_FILE="$KEYRINGS_DIR/$REPO_NAME.asc"

  mkdir -p $KEYRINGS_DIR
  chmod 755 $KEYRINGS_DIR

  curl -fsSL "$KEY_URL" -o "$KEY_FILE"
  echo "deb [arch=$(dpkg --print-architecture) signed-by=$KEY_FILE] $REPO_URL $(lsb_release -cs) $RELEASE_VER" |
    tee "/etc/apt/sources.list.d/$REPO_NAME.list" >/dev/null
}

# git

# Skip if git has already installed
if type "git" >/dev/null 2>&1; then
  echo "Skip install git."
else
  # Note: use 11371 port for keyserver.ubuntu.com
  # https://askubuntu.com/questions/212132/i-cant-add-ppa-repository-behind-the-proxy/251404#251404?newreg=d26fea5b9ba843ea84e91efda4b7ba16
  install-key git 'http://keyserver.ubuntu.com:11371/pks/lookup?op=get&search=0xe1dd270288b4e6030699e45fa1715d88e1df1f24' 'http://ppa.launchpad.net/git-core/ppa/ubuntu' main
  apt-get update && apt-get install -y --no-install-recommends \
    git
fi

# Docker
#
# ref.
# https://docs.docker.com/engine/install/ubuntu/
# https://docs.docker.com/engine/install/linux-postinstall/

# Skip below if docker has already installed
if type "docker" >/dev/null 2>&1; then
  echo "Skip install docker."
  exit 0
fi

if [ -n "${SKIP_DOCKER}" ]; then
  echo "Skip install docker."
  exit 0
fi

install-key docker 'https://download.docker.com/linux/ubuntu/gpg' 'https://download.docker.com/linux/ubuntu' stable
apt-get update && apt-get install -y --no-install-recommends \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  docker-buildx-plugin \
  docker-compose-plugin
