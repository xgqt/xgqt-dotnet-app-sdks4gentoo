#!/usr/bin/env bash

trap "exit 128" INT
set -eux

export PATH="${PATH}:${HOME}/.dotnet:${HOME}/.dotnet/tools"

export LANG="C"
export LC_ALL="C"

export TERM="dumb"

declare DOTNET_ROOT
DOTNET_ROOT="$(dirname "$(command -v dotnet)")"
export DOTNET_ROOT

declare -r pwsh_version="${1}"

declare cwd
cwd="$(pwd)"

declare -r tmp_base="/tmp/sdks4gentoo"
mkdir -p "${tmp_base}"

declare tmp=""
tmp="$(mktemp -d "${tmp_base}/build_gdmt_XXXX")"

mkdir -p "${tmp}"
cd "${tmp}"

gdmt genpwsh --compression="xz" --temp="${tmp}" \
     --sdk-exe="/root/.dotnet/dotnet" --sdk-ver="9.0" "${pwsh_version}"

cp "${tmp}/gdmt_genpwsh/pwsh-${pwsh_version}.tar.xz" \
   "${cwd}/pwsh-${pwsh_version}.repackaged.tar.xz"

cd "${cwd}"
rm -f -r "${tmp}"
