#!/bin/bash

set -euxp pipefail

chmod 700 ~/.gnupg

gpg -k

sudo systemctl enable pcscd
sudo systemctl start pcscd

if [ ! -f .ssh/id_yubikey.pub ]; then
  echo '\nRun `ssh-add -L > .ssh/id_yubikey.pub && chmod 600 .ssh/id_yubikey.pub`.'
fi

if [ ! -d ~/.ssh ]; then
  mkdir ~/.ssh
  chmod 700 ~/.ssh
fi

