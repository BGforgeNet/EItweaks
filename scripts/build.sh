#!/bin/bash
# Builds a release into <out>: per language, the starter and standalone zips, their installers, and SHA256SUMS.
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
podman run --rm --network none -v "$repo:/repo:ro" -v "$out:/out" eitweaks-build eibuild build /repo "$version" /out

work="$(mktemp -d)"
# The compiler's container user writes files the invoking user does not own; remove them from podman's namespace.
trap 'podman unshare rm -rf "$work"' EXIT
# The installers are independent: compile them all at once, then collect each one's result.
names=()
pids=()
for zip in "$out"/eitweaks-"$version"-*.zip; do
    name="$(basename "$zip" .zip)"
    rest="${name#eitweaks-"$version"-}"
    dir="$work/$rest"
    mkdir -p "$dir"
    cp build/installer.iss "$dir/"
    podman run --rm --network none -v "$out:/out:ro" -v "$dir:/work" eitweaks-build \
        eibuild unzip "/out/$name.zip" /work/payload
    # The compiler runs as the image's own user, which writes the installer under the script's folder.
    chmod -R a+rwX "$dir"
    podman run --rm --network none -v "$dir:/work" "$inno" \
        /work/installer.iss "/DLang=${rest%%-*}" "/DVariant=${rest#*-}" "/DVersion=$version" >"$work/$rest.log" 2>&1 &
    names+=("$name")
    pids+=("$!")
done
failed=0
for i in "${!pids[@]}"; do
    rest="${names[$i]#eitweaks-"$version"-}"
    if wait "${pids[$i]}"; then
        cp "$work/$rest/out/${names[$i]}-setup.exe" "$out/"
    else
        echo "installer ${names[$i]} failed:" >&2
        cat "$work/$rest.log" >&2
        failed=1
    fi
done
if [ "$failed" = 1 ]; then
    exit 1
fi
podman run --rm --network none -v "$out:/out" -w /out eitweaks-build \
    sh -c "sha256sum eitweaks-$version-*.zip eitweaks-$version-*-setup.exe > SHA256SUMS"
