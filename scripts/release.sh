#!/bin/bash

set -xeu -o pipefail

version="v$1"
fname="eitweaks-$version.zip"
dname="eitweaks"

rm -rf "$dname"
mkdir -p "$dname"

ini2reg config.ini
cp -r config \
  config.reg \
  movies \
  res \
  "$dname"

zip -r "$fname" "$dname"
rm -rf "$dname"

githubrelease release BGforgeNet/EItweaks create "$version" --publish --name "$version" "$fname"
