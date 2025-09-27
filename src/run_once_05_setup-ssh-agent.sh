#!/bin/bash

set -euxp pipefail

if [ ! -d ~/.ssh ]; then
  mkdir ~/.ssh
  chmod 700 ~/.ssh
fi

