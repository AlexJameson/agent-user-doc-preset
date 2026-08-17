#!/usr/bin/env bash

set -euo pipefail

if [[ $# -ne 1 ]]; then
  printf 'usage: %s <version>\n' "$0" >&2
  exit 1
fi

VERSION="$1"
ROOT_DIR="$(pwd)"
DIST_DIR="$ROOT_DIR/dist"
STAGE_DIR="$DIST_DIR/stage"
ARCHIVE_ROOT="agent-user-doc-preset-${VERSION}"
ARCHIVE_DIR="$STAGE_DIR/$ARCHIVE_ROOT"

rm -rf "$STAGE_DIR"
mkdir -p "$ARCHIVE_DIR"

cp "$ROOT_DIR/README.md" "$ARCHIVE_DIR/README.md"
cp "$ROOT_DIR/LICENSE" "$ARCHIVE_DIR/LICENSE"
cp -R "$ROOT_DIR/skills" "$ARCHIVE_DIR/skills"
cp -R "$ROOT_DIR/agent" "$ARCHIVE_DIR/agent"
cp -R "$ROOT_DIR/command" "$ARCHIVE_DIR/command"

mkdir -p "$DIST_DIR"
rm -f "$DIST_DIR/${ARCHIVE_ROOT}.zip" "$DIST_DIR/${ARCHIVE_ROOT}.sha256"

(
  cd "$STAGE_DIR"
  zip -qr "$DIST_DIR/${ARCHIVE_ROOT}.zip" "$ARCHIVE_ROOT"
)

shasum -a 256 "$DIST_DIR/${ARCHIVE_ROOT}.zip" > "$DIST_DIR/${ARCHIVE_ROOT}.sha256"

printf 'created %s\n' "$DIST_DIR/${ARCHIVE_ROOT}.zip"
printf 'created %s\n' "$DIST_DIR/${ARCHIVE_ROOT}.sha256"
