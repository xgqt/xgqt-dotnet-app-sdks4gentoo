#!/usr/bin/env bash

trap "exit 128" INT
set -eux

export PATH="${PATH}:${HOME}/.dotnet:${HOME}/.dotnet/tools"

export LANG="C"
export LC_ALL="C"

export TERM="dumb"

export InvariantGlobalization="1"
export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT="1"

declare -r PN="gentoo-dotnet-maintainer-tools"
declare -r PV="3.0.0"
declare -r P="${PN}-${PV}"
declare -r A="${P}.tar"

declare cwd
cwd="$(pwd)"

declare -r tmp_base="/tmp/sdks4gentoo"
mkdir -p "${tmp_base}"

declare tmp=""
tmp="$(mktemp -d "${tmp_base}/build_gdmt_XXXX")"

mkdir -p "${tmp}"
cd "${tmp}"

wget -q -O "${A}" "https://gitlab.gentoo.org/dotnet/${PN}/-/archive/${PV}/${A}"
tar xf "${A}"

cd "${P}"
cd ./Source/v3

make build install > make.log

cd "${cwd}"
rm -f -r "${tmp}"
