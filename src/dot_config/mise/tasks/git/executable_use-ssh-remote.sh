#!/bin/bash
#MISE description="Use ssh for remote url"

set -euo pipefail

if ! git rev-parse > /dev/null 2>&1; then
  echo 'Current dir is not managed with git.'
  exit 0
fi

owner=$(gh repo view --json owner -q '.owner.login')
repo=$(gh repo view --json name -q '.name')
git remote set-url origin "git@github.com:${owner}/${repo}"
