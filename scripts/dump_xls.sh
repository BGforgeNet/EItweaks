#!/bin/bash

set -xeu -o pipefail

./scripts/xlsx2csv.py res/database.xlsx
