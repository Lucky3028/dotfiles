#!/bin/bash

set -euxp pipefail

curl -fsSL https://deno.land/x/gh_rd/install.bash | /bin/bash
$XDG_DATA_HOME/gh-rd/bin/gh-rd

