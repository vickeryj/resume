#!/usr/bin/env bash
#
# Build résumé/CV PDFs from Typst sources.
#
# Usage:
#   ./build.sh                     Build every target into build/
#   ./build.sh Resume-PE           Build one target (name = targets/<name>.typ)
#   ./build.sh --watch <name>      Rebuild a target on every save
#   ./build.sh --list              List available targets
#   ./build.sh --clean             Remove the build/ directory
#
set -euo pipefail

cd "$(dirname "$0")"

TARGETS_DIR="targets"
OUT_DIR="build"

if ! command -v typst >/dev/null 2>&1; then
  echo "error: typst is not installed. Install it with: brew install typst" >&2
  exit 1
fi

list_targets() {
  for f in "$TARGETS_DIR"/*.typ; do
    [ -e "$f" ] || continue
    basename "$f" .typ
  done
}

build_one() {
  local name="$1"
  local src="$TARGETS_DIR/$name.typ"
  if [ ! -f "$src" ]; then
    echo "error: no such target '$name' (see ./build.sh --list)" >&2
    exit 1
  fi
  mkdir -p "$OUT_DIR"
  echo "building $name → $OUT_DIR/$name.pdf"
  typst compile --root . "$src" "$OUT_DIR/$name.pdf"
}

case "${1:-}" in
  --list)
    list_targets
    ;;
  --clean)
    rm -rf "$OUT_DIR"
    echo "removed $OUT_DIR/"
    ;;
  --watch)
    name="${2:?usage: ./build.sh --watch <target>}"
    src="$TARGETS_DIR/$name.typ"
    [ -f "$src" ] || { echo "error: no such target '$name'" >&2; exit 1; }
    mkdir -p "$OUT_DIR"
    echo "watching $name (Ctrl-C to stop)…"
    exec typst watch --root . "$src" "$OUT_DIR/$name.pdf"
    ;;
  "")
    for name in $(list_targets); do
      build_one "$name"
    done
    echo "done → $OUT_DIR/"
    ;;
  *)
    build_one "$1"
    ;;
esac
