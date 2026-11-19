#!/usr/bin/env bash
# Checks that the release tag v<version> matches mod/config.ini's Version and writes that version's CHANGELOG.md
# section, without its heading, to the file given.
# Usage: release-notes.sh <tag> <notes-file>
set -euo pipefail

tag="$1"
notes="$2"
version="${tag#v}"
config_version="$(sed -n 's/^Version=//p' mod/config.ini | tr -d '\r')"
if [ "$version" != "$config_version" ]; then
    echo "tag $tag does not match mod/config.ini Version=$config_version" >&2
    exit 1
fi
# A wrapped line (indented, not a list item) joins the line before it: release notes render each newline as a break.
awk -v heading="### $version" '
    $0 == heading { found = 1; next }
    !found { next }
    /^### / { exit }
    /^ +[^ -]/ { sub(/^ +/, " "); line = line $0; next }
    { if (started) print line; line = $0; started = 1 }
    END { if (started) print line }
' CHANGELOG.md >"$notes"
if ! grep -q '[^[:space:]]' "$notes"; then
    echo "CHANGELOG.md: no section \"### $version\"" >&2
    exit 1
fi
