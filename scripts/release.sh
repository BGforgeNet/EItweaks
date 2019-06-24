#!/bin/bash

set -xeu -o pipefail

version="$1"
fname="eitweaks-$version.zip"

rm -f "$fname"
zip -r "$fname" \
  config \
  config.reg \
  movies \
  res/*.res

githubrelease release BGforgeNet/EItweaks create "v$version" --publish --name "v$version" "$fname"
