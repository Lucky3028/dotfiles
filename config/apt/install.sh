#!/bin/bash

set -euxo pipefail

# This script must be run by root!
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root."
  exit 1
fi

# Install some deps

# Set apt repositories for JP
sed -i.bak -r 's@http://(jp\.)?archive\.ubuntu\.com/ubuntu/?@http://ftp.udx.icscoe.jp/Linux/ubuntu/@g' /etc/apt/sources.list
apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends \
  ca-certificates \
  curl \
  gnupg \
  gpg \
  libfuse-dev \
  libsqlite3-dev \
  libssl-dev \
  software-properties-common \
  unzip \
  vim-gtk \
  wget \
  zip \
  zsh

# Add apt repository for git to install latest version
add-apt-repository -y ppa:git-core/ppa
apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends \
  git

# Docker
#
# ref.
# https://docs.docker.com/engine/install/ubuntu/
# https://docs.docker.com/engine/install/linux-postinstall/

# Skip above if docker has already installed
if type "docker" >/dev/null 2>&1; then
  echo "Skip install docker."
  exit 0
fi

if [ -n "${SKIP_DOCKER}" ]; then
  echo "Skip install docker."
  exit 0
fi

install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" |
  tee /etc/apt/sources.list.d/docker.list >/dev/null
apt-get update && apt-get install -y --no-install-recommends \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  docker-buildx-plugin \
  docker-compose-plugin
