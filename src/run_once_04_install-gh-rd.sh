#!/bin/bash

set -euxp pipefail

proto install deno

curl -fsSL https://deno.land/x/gh_rd/install.bash | /bin/bash

