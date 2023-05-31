#!/bin/sh
set -e
readonly MIRROR=https://github.com/okteto/okteto/releases/download

dl () {
    local ver=$1
    local os=$2
    local arch=$3
    local platform="${os}-${arch}"

    local url="${MIRROR}/${ver}/okteto-${platform}.sha256"
    printf "    # %s\n" $url
    printf "    %s-%s: sha256:%s\n" $os $arch $(curl -sSLf $url | awk '{print $1}')
}

dl_ver() {
    local ver=$1
    printf "  '%s':\n" $ver
    dl $ver Darwin arm64
    dl $ver Darwin x86_64
    dl $ver Linux arm64
    dl $ver Linux x86_64
}

dl_ver ${1:-2.16.2}
