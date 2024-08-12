#!/bin/bash

set -euxp pipefail

BW_VERSION='2024.7.2'

curl -fsLO https://github.com/bitwarden/clients/releases/download/cli-v${BW_VERSION}/bw-linux-${BW_VERSION}.zip
unzip bw-linux-${BW_VERSION}.zip
chmod +x bw
mv bw ~/bin/
rm bw-linux-${BW_VERSION}.zip

