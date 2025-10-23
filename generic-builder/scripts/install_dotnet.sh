#!/usr/bin/env bash

trap "exit 128" INT
set -eux

export LANG="C"
export LC_ALL="C"

export TERM="dumb"

declare cwd
cwd="$(pwd)"

declare -r tmp_base="/tmp/sdks4gentoo"
mkdir -p "${tmp_base}"

declare tmp=""
tmp="$(mktemp -d "${tmp_base}/build_gdmt_XXXX")"

mkdir -p "${tmp}"
cd "${tmp}"

wget -q -O "dotnet-install.sh" "https://dot.net/v1/dotnet-install.sh"

bash ./dotnet-install.sh --channel 9.0 > dotnet-install.log

cd "${cwd}"
rm -f -r "${tmp}"
