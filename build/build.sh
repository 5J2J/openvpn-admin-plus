#!/bin/bash

set -e

PKGFILE=openvpn-admin-plus.tar.gz

cp -f ../$PKGFILE ./

# Multi-arch the manifest way -- uncomment for each architecture, save and run script
# docker build -t 5J2J/openvpn-admin-plus:manifest-amd64 --build-arg ARCH=amd64/ .
# docker build -t 5J2J/openvpn-admin-plus:manifest-arm64 --build-arg ARCH=arm64/ .
# docker build -t 5J2J/openvpn-admin-plus:manifest-armv7 --build-arg ARCH=armv7/ .

# Multi-arch the buildx way -- just use the command below, don't run the script
# docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7 -f build/Multi-arch.dockerfile -t 5J2J/openvpn-admin-plus . --push --no-cache

# Multi-arch development build
# docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7 -f build/Multi-arch.dockerfile -t 5J2J/openvpn-admin-plus:beta . --push --no-cache

# Single-arch (amd64) development build
docker buildx build --platform linux/amd64 -f build/Multi-arch.dockerfile -t 5J2J/openvpn-admin-plus . --push --no-cache
rm -f $PKGFILE
