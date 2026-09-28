#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODE="${1:---clean}"
JOBS="${JOBS:-2}"

bash "$SCRIPT_DIR/scripts/restore-executable-bits.sh" >/dev/null

case "$MODE" in
    --clean) CLEAN=1 ;;
    --incremental) CLEAN=0 ;;
    -h|--help)
        echo "Usage: ./build.sh [--clean|--incremental]"
        exit 0
        ;;
    *)
        echo "ERROR: unknown option: $MODE" >&2
        exit 2
        ;;
esac

if [[ -x "$SCRIPT_DIR/.local/python2/bin/python2" ]]; then
    export PATH="$SCRIPT_DIR/.local/python2/bin:$PATH"
fi
if [[ -x "$SCRIPT_DIR/.local/python3/bin/python3" ]]; then
    export PATH="$SCRIPT_DIR/.local/python3/bin:$PATH"
    export IGC_ICPCES_PYTHON="$SCRIPT_DIR/.local/python3/bin/python3"
fi
if [[ -x "$SCRIPT_DIR/.local/sicstus/bin/sicstus" ]]; then
    export PATH="$SCRIPT_DIR/.local/sicstus/bin:$PATH"
fi

for tool in make gcc g++ cmake strip javac; do
    if ! command -v "$tool" >/dev/null 2>&1; then
        echo "ERROR: missing build dependency '$tool'; run ./setup.sh --install." >&2
        exit 1
    fi
done

run_make() {
    local dir="$1"
    shift
    echo "==> make: ${dir#$SCRIPT_DIR/}"
    make -C "$dir" -j"$JOBS" "$@"
}

echo "Building with $JOBS parallel job(s)."

KISSAT_DIR="$SCRIPT_DIR/third_party/kissat"
if [[ ! -f "$KISSAT_DIR/build/libkissat.a" ]]; then
    echo "==> configuring Kissat"
    (
        cd "$KISSAT_DIR"
        ./configure
        make -C build -j"$JOBS"
    )
fi

mkdir -p \
    "$SCRIPT_DIR/lama/preprocess/obj" \
    "$SCRIPT_DIR/lama/search/obj" \
    "$SCRIPT_DIR/iGC/lama/preprocess/obj" \
    "$SCRIPT_DIR/iGC/lama/search/obj" \
    "$SCRIPT_DIR/GC_LAMA/lama/preprocess/obj"

if (( CLEAN )); then
    make -C "$SCRIPT_DIR/lama/preprocess" clean
    make -C "$SCRIPT_DIR/lama/search" clean
    make -C "$SCRIPT_DIR/iGC/lama/preprocess" clean
    make -C "$SCRIPT_DIR/iGC/lama/search" clean
    make -C "$SCRIPT_DIR/GC_LAMA/lama/preprocess" clean
    find "$SCRIPT_DIR/conformant-ff" -maxdepth 1 -type f -name '*.o' -delete
fi

run_make "$SCRIPT_DIR/lama/preprocess"
run_make "$SCRIPT_DIR/lama/search" release-search
run_make "$SCRIPT_DIR/conformant-ff" -f makefile ff
run_make "$SCRIPT_DIR/iGC/lama/preprocess"
run_make "$SCRIPT_DIR/iGC/lama/search" release
run_make "$SCRIPT_DIR/GC_LAMA/lama/preprocess"

echo "==> compiling gCPCES classes for Java 11"
"$SCRIPT_DIR/gCPCES/compile-java.sh"

strip --strip-unneeded \
    "$SCRIPT_DIR/lama/preprocess/preprocess" \
    "$SCRIPT_DIR/lama/search/release-search" \
    "$SCRIPT_DIR/conformant-ff/ff" \
    "$SCRIPT_DIR/iGC/lama/preprocess/preprocess" \
    "$SCRIPT_DIR/iGC/lama/search/release-search" \
    "$SCRIPT_DIR/GC_LAMA/lama/preprocess/preprocess"

# Kissat's configure script writes location-specific forwarding makefiles.
# They are not needed after libkissat.a is linked and must not become source
# artifacts, especially when the project path contains spaces.
rm -f -- \
    "$KISSAT_DIR/makefile" \
    "$KISSAT_DIR/src/makefile" \
    "$KISSAT_DIR/src/New"

chmod +x \
    "$SCRIPT_DIR"/build \
    "$SCRIPT_DIR"/plan-cegis* \
    "$SCRIPT_DIR"/run-test-ce.sh \
    "$SCRIPT_DIR"/setup.sh \
    "$SCRIPT_DIR"/build.sh \
    "$SCRIPT_DIR"/check-installation.sh \
    "$SCRIPT_DIR"/install-sicstus.sh \
    "$SCRIPT_DIR"/run-example.sh \
    "$SCRIPT_DIR"/run-all-examples.sh \
    "$SCRIPT_DIR"/run-tests \
    "$SCRIPT_DIR"/scripts/*.sh

for output in \
    lama/preprocess/preprocess \
    lama/search/release-search \
    conformant-ff/ff \
    iGC/lama/preprocess/preprocess \
    iGC/lama/search/release-search \
    GC_LAMA/lama/preprocess/preprocess \
    gCPCES/build/main.class; do
    if [[ ! -s "$SCRIPT_DIR/$output" ]]; then
        echo "ERROR: expected build output is missing: $output" >&2
        exit 1
    fi
done

echo "Build completed successfully."
