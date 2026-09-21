#!/bin/bash

set -euo pipefail

toolbox_app_dir="${HOME}/bin/jetbrains-toolbox-app"
toolbox_binary="${toolbox_app_dir}/jetbrains-toolbox"
toolbox_platform=''
toolbox_release=''
toolbox_download_url=''
toolbox_checksum_url=''
toolbox_archive_name=''
toolbox_checksum_name=''
toolbox_temp_dir=''
toolbox_extract_dir=''
toolbox_source_dir=''

if [[ -x "${toolbox_binary}" ]]; then
  exit 0
fi

if [[ -e "${toolbox_app_dir}" || -L "${toolbox_app_dir}" ]]; then
  printf 'JetBrains Toolbox のインストール先は存在しますが、実行ファイルが見つかりません: %s\n' \
    "${toolbox_app_dir}" >&2
  exit 1
fi

case "$(uname -m)" in
x86_64 | amd64)
  toolbox_platform='linux'
  ;;
aarch64 | arm64)
  toolbox_platform='linuxARM64'
  ;;
*)
  printf 'JetBrains Toolbox が対応していないアーキテクチャです: %s\n' "$(uname -m)" >&2
  exit 1
  ;;
esac

printf 'JetBrains Toolbox をインストールしています...\n'
toolbox_release="$(curl -fsSL --retry 3 \
  'https://data.services.jetbrains.com/products/releases?code=TBA&latest=true&type=release')"
toolbox_download_url="$(jq -er --arg platform "${toolbox_platform}" \
  '.TBA[0].downloads[$platform].link' <<<"${toolbox_release}")"
toolbox_checksum_url="$(jq -er --arg platform "${toolbox_platform}" \
  '.TBA[0].downloads[$platform].checksumLink' <<<"${toolbox_release}")"
toolbox_archive_name="${toolbox_download_url##*/}"
toolbox_checksum_name="${toolbox_checksum_url##*/}"

install -d "${HOME}/bin"
toolbox_temp_dir="$(mktemp -d)"
trap 'rm -rf -- "${toolbox_temp_dir}"' EXIT
toolbox_extract_dir="${toolbox_temp_dir}/extracted"
mkdir "${toolbox_extract_dir}"

curl -fL --retry 3 --progress-bar "${toolbox_download_url}" \
  -o "${toolbox_temp_dir}/${toolbox_archive_name}"
curl -fsSL --retry 3 "${toolbox_checksum_url}" \
  -o "${toolbox_temp_dir}/${toolbox_checksum_name}"
(
  cd "${toolbox_temp_dir}"
  sha256sum --check --status "${toolbox_checksum_name}"
)

tar -xzf "${toolbox_temp_dir}/${toolbox_archive_name}" -C "${toolbox_extract_dir}"
toolbox_source_dir="$(find "${toolbox_extract_dir}" -mindepth 1 -maxdepth 1 -type d -print -quit)"
if [[ -z "${toolbox_source_dir}" || ! -f "${toolbox_source_dir}/bin/jetbrains-toolbox" ]]; then
  printf 'JetBrains Toolbox のアーカイブ構成を認識できません。\n' >&2
  exit 1
fi

chmod +x "${toolbox_source_dir}/bin/jetbrains-toolbox"
mv "${toolbox_source_dir}/bin" "${toolbox_app_dir}"
printf 'JetBrains Toolbox をインストールしました。初回起動は `jetbrains-toolbox` です。\n'
