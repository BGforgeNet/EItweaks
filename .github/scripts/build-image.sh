#!/usr/bin/env bash
# Loads the eitweaks-build image from the cached archive, or builds it and writes the archive for the cache to save.
set -euo pipefail

archive="$RUNNER_TEMP/image/eitweaks-build.tar"
if [ -f "$archive" ]; then
    podman load -i "$archive"
else
    podman build -t eitweaks-build -f build/Containerfile build
    mkdir -p "$(dirname "$archive")"
    podman save -o "$archive" eitweaks-build
fi
