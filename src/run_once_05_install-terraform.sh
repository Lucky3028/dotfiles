#!/bin/bash

set -euxp pipefail

$PROTO_HOME/bin/proto plugin add terraform 'https://raw.githubusercontent.com/theomessin/proto-toml-plugins/master/terraform.toml'
$PROTO_HOME/bin/proto install terraform

