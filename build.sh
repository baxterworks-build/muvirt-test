#!/usr/bin/env bash
apt update; apt -y install curl xz

curl -L https://archive.traverse.com.au/pub/traverse/software/muvirt/branches/master/latest/image/muvirt-sdk-SNAPSHOT-layerscape-armv8_64b_gcc-8.4.0_musl.Linux-x86_64.tar.xz | tar -jvxf -

pushd muvirt*

./scripts/feeds update -a
./scripts/feeds install -a

make -j16
