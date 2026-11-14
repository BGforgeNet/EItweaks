#!/bin/bash
# Builds a release into <out>: the installer and SHA256SUMS. The per-language zips it is made from stay in a temporary
# folder.
# Run from the repository root; needs podman.
# EITWEAKS_BUILD_IMAGE_READY=1 skips building the eitweaks-build image (CI loads it from its cache).
# The third-party files build/downloads.txt lists are downloaded into EITWEAKS_DOWNLOADS, by default
# ~/.cache/eitweaks/downloads, and kept there for the next build while their checksums match.

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
downloads="${EITWEAKS_DOWNLOADS:-${XDG_CACHE_HOME:-$HOME/.cache}/eitweaks/downloads}"
mkdir -p "$downloads"
podman run --rm -v "$repo/build/downloads.txt:/downloads.txt:ro" -v "$downloads:/downloads" eitweaks-build \
    eibuild fetch /downloads.txt /downloads
work="$(mktemp -d)"
# The compiler's container user writes files the invoking user does not own; remove them from podman's namespace.
trap 'podman unshare rm -rf "$work"' EXIT
mkdir "$work/zips"
podman run --rm --network none -v "$repo:/repo:ro" -v "$downloads:/downloads:ro" -v "$work/zips:/out" \
    eitweaks-build eibuild build /repo /downloads "$version" /out
cp build/installer.iss "$work/"
cp "$downloads/EIStarter-UM-0.2.9.zip" "$work/"
podman run --rm --network none -v "$work/zips:/zips:ro" -v "$work:/work" eitweaks-build \
    eibuild payload /zips "$version" /work/payload
# The compiler runs as the image's own user, which writes the installer under the script's folder.
chmod -R a+rwX "$work"
podman run --rm --network none -v "$work:/work" "$inno" /work/installer.iss "/DVersion=$version"
cp "$work/out/eitweaks-$version.exe" "$out/"
podman run --rm --network none -v "$out:/out" -w /out eitweaks-build \
    sh -c "sha256sum eitweaks-$version.exe > SHA256SUMS"
