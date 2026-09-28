#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODE="${1:---check}"
PYTHON_VERSION="2.7.18"
LOCAL_PYTHON_PREFIX="$SCRIPT_DIR/.local/python2"
PYTHON3_VENV="$SCRIPT_DIR/.local/python3"
EXPECTED_Z3_VERSION="4.12.2"

usage() {
    cat <<'EOF'
Usage: ./setup.sh [--check|--install]

  --check    Inspect dependencies without changing the system (default).
  --install  Install open Ubuntu packages, create a project-local Python-3
             environment with pinned requirements, build a project-local
             Python 2.7.18 when needed, and offer optional local SICStus
             download/installation.

SICStus is commercial and is not redistributed in this package. Its installer
requires the reviewer's own confidential license. Set SICSTUS_SKIP=1 to skip.
EOF
}

case "$MODE" in
    --check|--install) ;;
    -h|--help) usage; exit 0 ;;
    *) usage >&2; exit 2 ;;
esac

if [[ "$(uname -s)" != "Linux" ]]; then
    echo "ERROR: this package targets GNU/Linux (validated on Ubuntu 24.04 and 20.04)." >&2
    exit 1
fi

if [[ "$MODE" == "--install" ]]; then
    if ! command -v apt-get >/dev/null 2>&1; then
        echo "ERROR: automatic installation currently supports apt-based systems." >&2
        exit 1
    fi
    if [[ "$(id -u)" -eq 0 ]]; then
        SUDO=()
    elif command -v sudo >/dev/null 2>&1; then
        SUDO=(sudo)
    else
        echo "ERROR: apt installation needs root or sudo." >&2
        exit 1
    fi

    "${SUDO[@]}" apt-get update
    "${SUDO[@]}" apt-get install -y \
        build-essential make cmake binutils file flex bison perl \
        default-jdk-headless libz3-dev python3 python3-pip python3-venv \
        libc6-i386 lib32gcc-s1 lib32stdc++6 \
        curl ca-certificates tar xz-utils zip unzip time \
        zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev \
        libffi-dev libncurses-dev
fi

if command -v python2 >/dev/null 2>&1; then
    PYTHON2="$(command -v python2)"
elif [[ -x "$LOCAL_PYTHON_PREFIX/bin/python2" ]]; then
    PYTHON2="$LOCAL_PYTHON_PREFIX/bin/python2"
elif [[ "$MODE" == "--install" ]]; then
    if ! command -v curl >/dev/null 2>&1; then
        echo "ERROR: curl is required to fetch Python $PYTHON_VERSION." >&2
        exit 1
    fi
    work_dir="$(mktemp -d)"
    trap 'rm -rf -- "$work_dir"' EXIT
    archive="$work_dir/Python-$PYTHON_VERSION.tgz"
    echo "Building project-local Python $PYTHON_VERSION ..."
    curl --fail --location --retry 3 \
        "https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tgz" \
        --output "$archive"
    tar -xzf "$archive" -C "$work_dir"
    (
        cd "$work_dir/Python-$PYTHON_VERSION"
        ./configure --prefix="$LOCAL_PYTHON_PREFIX" --enable-unicode=ucs4
        make -j"${JOBS:-2}"
        make install
    )
    ln -sfn python2.7 "$LOCAL_PYTHON_PREFIX/bin/python2"
    PYTHON2="$LOCAL_PYTHON_PREFIX/bin/python2"
else
    PYTHON2=""
fi

if [[ "$MODE" == "--install" ]]; then
    if [[ ! -x "$PYTHON3_VENV/bin/python3" ]]; then
        echo "Creating project-local Python 3 virtual environment ..."
        python3 -m venv "$PYTHON3_VENV"
    fi
    "$PYTHON3_VENV/bin/python3" -m pip install \
        --disable-pip-version-check \
        --requirement "$SCRIPT_DIR/requirements.txt"
fi

if [[ "$MODE" == "--install" ]]; then
    "$SCRIPT_DIR/install-sicstus.sh" --auto
fi

if [[ -x "$PYTHON3_VENV/bin/python3" ]]; then
    PYTHON3="$PYTHON3_VENV/bin/python3"
    export PATH="$PYTHON3_VENV/bin:$PATH"
    export IGC_ICPCES_PYTHON="$PYTHON3"
elif command -v python3 >/dev/null 2>&1; then
    PYTHON3="$(command -v python3)"
else
    PYTHON3=""
fi

if [[ -x "$SCRIPT_DIR/.local/sicstus/bin/sicstus" ]]; then
    export PATH="$SCRIPT_DIR/.local/sicstus/bin:$PATH"
fi

echo
echo "Dependency summary"
echo "------------------"
failures=0
for tool in bash make gcc g++ cmake file strip perl python3 java javac; do
    if command -v "$tool" >/dev/null 2>&1; then
        printf 'OK    %-12s %s\n' "$tool" "$(command -v "$tool")"
    else
        printf 'MISS  %-12s\n' "$tool"
        failures=$((failures + 1))
    fi
done

if [[ -n "$PYTHON2" ]]; then
    printf 'OK    %-12s %s\n' "python2" "$PYTHON2"
else
    printf 'MISS  %-12s %s\n' "python2" "required by LAMA translators"
    failures=$((failures + 1))
fi

if [[ -n "$PYTHON3" ]] &&
   Z3_VERSION="$("$PYTHON3" -c 'import z3; print(z3.get_version_string())' 2>/dev/null)" &&
   [[ "$Z3_VERSION" == "$EXPECTED_Z3_VERSION" ]]; then
    printf 'OK    %-12s %s (%s)\n' "python3-z3" "$Z3_VERSION" "$PYTHON3"
else
    printf 'MISS  %-12s %s\n' "python3-z3" \
        "expected $EXPECTED_Z3_VERSION in the project environment; run --install"
    failures=$((failures + 1))
fi

if command -v sicstus >/dev/null 2>&1 &&
   sicstus --version >/dev/null 2>&1; then
    printf 'OK    %-12s %s\n' "sicstus" "$(command -v sicstus)"
else
    printf 'OPT   %-12s %s\n' "sicstus" "needed by CNF/DNF/PIP/CpAH only"
fi

if (( failures > 0 )); then
    echo "Dependency check failed: $failures required item(s) missing." >&2
    exit 1
fi

echo "Open-route dependencies are ready."
