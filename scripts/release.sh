#!/bin/bash

set -xeu -o pipefail

version="v$1"
out="$(mktemp -d)"

podman build -t eitweaks-build -f build/Containerfile build
podman run --rm --network none -v "$PWD:/repo:ro" -v "$out:/out" eitweaks-build eibuild build /repo "$version" /out

githubrelease release BGforgeNet/EItweaks create "$version" --publish --name "$version" "$out"/eitweaks-"$version"-*.zip
rm -rf "$out"
