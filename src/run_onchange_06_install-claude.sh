#!/bin/zsh

set -euxo pipefail

# Versions (auto-updated by chezmoi to trigger re-run on update):
# claude: {{ output "sh" "-c" "claude --version 2>/dev/null || true" | trim }}

if type claude > /dev/null 2>&1; then
  claude update
else
  curl -fsSL https://claude.ai/install.sh | bash
fi
