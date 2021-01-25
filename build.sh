#!/usr/bin/env bash
set -eou pipefail
echo this line is just for drone.io
apt update; apt -y --no-install-recommends install curl ca-certificates xz-utils make build-essential libncurses-dev git unzip bzip2 wget python3 file gawk perl rsync

curl -L https://archive.traverse.com.au/pub/traverse/software/muvirt/branches/master/latest/image/muvirt-sdk-SNAPSHOT-layerscape-armv8_64b_gcc-8.4.0_musl.Linux-x86_64.tar.xz | tar -Jxf -

SOURCE=$(readlink -f muvirt*)
cp -v ten64.config $SOURCE/.config

pushd muvirt*

./scripts/feeds update -a
./scripts/feeds install -a

make -j1 V=s
