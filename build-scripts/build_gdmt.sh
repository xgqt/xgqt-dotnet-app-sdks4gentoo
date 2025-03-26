#!/usr/bin/env bash

trap "exit 128" INT
set -e
set -u
set -x

export LANG="C"
export LC_ALL="C"

export TERM="dumb"

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

curl -f -o "${A}" "https://gitlab.gentoo.org/dotnet/${PN}/-/archive/${PV}/${A}"
tar xf "${A}"

cd "${P}"
cd ./Source/v3

make clean
make build
make uninstall
make install

cd "${cwd}"
rm -rf "${tmp}"
