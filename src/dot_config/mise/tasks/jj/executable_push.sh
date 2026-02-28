#!/bin/bash
#MISE description="Push the previous commit to remote"

set -euo pipefail

jj git push -c @-
