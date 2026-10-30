#!/bin/bash
# Builds a release into <out>: the installer and SHA256SUMS. The per-language zips it is made from stay in a temporary
# folder.
# Run from the repository root; needs podman.
# EITWEAKS_BUILD_IMAGE_READY=1 skips building the eitweaks-build image (CI loads it from its cache).

set -eu -o pipefail

if [ $# -ne 2 ]; then
    echo "usage: scripts/build.sh <version> <out>" >&2
    exit 2
fi
version="$1"
mkdir -p "$2"
out="$(cd "$2" && pwd)"
repo="$PWD"
# The Inno Setup 6 compiler under Wine, pinned by digest.
inno=docker.io/amake/innosetup@sha256:ca648314001a18d66b7b4a3c62205bcae6a6406506df896885bbe12bafb4f1b6

if [ "${EITWEAKS_BUILD_IMAGE_READY:-}" != 1 ]; then
    podman build -t eitweaks-build -f build/Containerfile build
fi
work="$(mktemp -d)"
# The compiler's container user writes files the invoking user does not own; remove them from podman's namespace.
trap 'podman unshare rm -rf "$work"' EXIT
mkdir "$work/zips"
podman run --rm --network none -v "$repo:/repo:ro" -v "$work/zips:/out" eitweaks-build \
    eibuild build /repo "$version" /out
cp build/installer.iss "$work/"
podman run --rm --network none -v "$work/zips:/zips:ro" -v "$work:/work" eitweaks-build \
    eibuild payload /zips "$version" /work/payload
# The compiler runs as the image's own user, which writes the installer under the script's folder.
chmod -R a+rwX "$work"
podman run --rm --network none -v "$work:/work" "$inno" /work/installer.iss "/DVersion=$version"
cp "$work/out/eitweaks-$version-setup.exe" "$out/"
podman run --rm --network none -v "$out:/out" -w /out eitweaks-build \
    sh -c "sha256sum eitweaks-$version-setup.exe > SHA256SUMS"
