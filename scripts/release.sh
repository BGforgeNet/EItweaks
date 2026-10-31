#!/bin/bash

set -xeu -o pipefail

version="v$1"
out="$(mktemp -d)"

scripts/build.sh "$version" "$out"

githubrelease release BGforgeNet/EItweaks create "$version" --publish --name "$version" \
    "$out"/eitweaks-"$version".exe
rm -rf "$out"
