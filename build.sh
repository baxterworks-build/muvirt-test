#!/usr/bin/env bash
set -eou pipefail
if ! [ -z ${DRONE+x} ]; then
	apt update; apt -y --no-install-recommends install curl ca-certificates xz-utils make build-essential libncurses-dev git unzip bzip2 wget python3 file gawk
fi

if ! [ -d muvirt* ]; then #no SDK extracted yet
	curl -L https://archive.traverse.com.au/pub/traverse/software/muvirt/branches/master/latest/image/muvirt-sdk-SNAPSHOT-layerscape-armv8_64b_gcc-8.4.0_musl.Linux-x86_64.tar.xz | tar -Jxf -
fi

pushd muvirt*
make defconfig

./scripts/feeds update -a
for p in i2c-tools luci-app-minidlna luci-app-samba4 luci-app-vnstat; do
	./scripts/feeds install $p
	make -j `nproc` package/$p/compile
done
