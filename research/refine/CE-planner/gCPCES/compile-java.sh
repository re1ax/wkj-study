#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUTPUT_DIR="${1:-$ROOT_DIR/build}"

mkdir -p "$OUTPUT_DIR"

mapfile -t CPCES_SOURCES < <(
    find "$ROOT_DIR/src/cpces" -maxdepth 1 -type f -name '*.java' -print | sort
)
mapfile -t MAIN_SOURCES < <(
    find "$ROOT_DIR/src" -maxdepth 1 -type f -name '*.java' -print | sort
)

if [[ ${#CPCES_SOURCES[@]} -eq 0 || ${#MAIN_SOURCES[@]} -eq 0 ]]; then
    echo "gCPCES Java sources are incomplete." >&2
    exit 2
fi

javac --release 11 \
    -classpath "$ROOT_DIR/src/cpces:$ROOT_DIR/libs/*" \
    "${CPCES_SOURCES[@]}" \
    -d "$OUTPUT_DIR"

javac --release 11 \
    -classpath "$ROOT_DIR/src:$ROOT_DIR/libs/*:$OUTPUT_DIR" \
    "${MAIN_SOURCES[@]}" \
    -d "$OUTPUT_DIR"

echo "gCPCES Java classes compiled for Java 11: $OUTPUT_DIR"
