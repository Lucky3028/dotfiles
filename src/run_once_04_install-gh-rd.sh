#!/bin/bash

set -euxp pipefail

$PROTO_HOME/bin/proto install deno

curl -fsSL https://deno.land/x/gh_rd/install.bash | /bin/bash
$XDG_DATA_HOME/gh-rd/bin/gh-rd

