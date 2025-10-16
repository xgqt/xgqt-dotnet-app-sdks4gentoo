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

declare arch
case "$(uname -m)" in
    x86_64 )
        arch="amd64"
        ;;
    aarch64 )
        arch="arm64"
        ;;
    armv7l )
        arch="arm"
        ;;
esac

declare libc
if getconf GNU_LIBC_VERSION > /dev/null 2>&1 ; then
    libc="glibc"
else
    libc="musl"
fi

declare -r sdk_version="${1}"

declare cwd
cwd="$(pwd)"

declare -r tmp_base="/tmp/sdks4gentoo"
mkdir -p "${tmp_base}"

declare tmp=""
tmp="$(mktemp -d "${tmp_base}/build_gdmt_XXXX")"

mkdir -p "${tmp}"
cd "${tmp}"

gdmt gensdk --compression="xz" --temp="${tmp}" "${sdk_version}"

cp "${tmp}/gdmt_gensdk/dotnet-sdk-${sdk_version}.tar.xz" \
   "${cwd}/dotnet-sdk-${sdk_version}-prepared-gentoo-${libc}-${arch}.tar.xz"

cd "${cwd}"
rm -f -r "${tmp}"
