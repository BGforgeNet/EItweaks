#!/usr/bin/env bash
# Writes the CI build's version to $GITHUB_OUTPUT: mod/config.ini's Version plus the short commit, so test builds of one
# version stay apart.
set -euo pipefail

version="$(sed -n 's/^Version=//p' mod/config.ini | tr -d '\r')"
if [ -z "$version" ]; then
    echo "mod/config.ini: no Version line" >&2
    exit 1
fi
echo "version=$version-${GITHUB_SHA:0:7}" >>"$GITHUB_OUTPUT"
