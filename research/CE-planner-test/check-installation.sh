#!/usr/bin/env bash

set -u

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REQUIRE_SICSTUS=0
if [[ "${1:-}" == "--require-sicstus" ]]; then
    REQUIRE_SICSTUS=1
elif [[ -n "${1:-}" && "${1:-}" != "--check" ]]; then
    echo "Usage: ./check-installation.sh [--require-sicstus]" >&2
    exit 2
fi

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

failures=0
warnings=0

ok()   { printf 'OK    %s\n' "$*"; }
warn() { printf 'WARN  %s\n' "$*"; warnings=$((warnings + 1)); }
fail() { printf 'FAIL  %s\n' "$*"; failures=$((failures + 1)); }

echo "CE-planner installation check"
echo "============================="

for tool in bash make gcc g++ perl python3 java javac file ldd; do
    if command -v "$tool" >/dev/null 2>&1; then
        ok "$tool: $(command -v "$tool")"
    else
        fail "$tool is missing"
    fi
done

if command -v python2 >/dev/null 2>&1; then
    ok "python2: $(python2 --version 2>&1)"
else
    fail "python2 is required by the translator"
fi

if [[ -x "$SCRIPT_DIR/.local/python3/bin/python3" ]]; then
    ok "project Python 3: $SCRIPT_DIR/.local/python3/bin/python3"
else
    fail "project Python 3 environment is missing; run ./setup.sh --install"
fi

if [[ "$(python3 -c 'import z3; print(z3.get_version_string())' 2>/dev/null || true)" == "4.12.2" ]]; then
    ok "Python Z3: $(python3 -c 'import z3; print(z3.get_version_string())')"
else
    fail "Python Z3 4.12.2 is missing from the selected Python environment"
fi

if command -v sicstus >/dev/null 2>&1 &&
   sicstus --version >/dev/null 2>&1; then
    sicstus_version="$(sicstus --version 2>&1 | head -n 1)"
    ok "SICStus: $sicstus_version"
else
    if (( REQUIRE_SICSTUS )); then
        fail "SICStus is required by --require-sicstus"
    else
        warn "usable SICStus not found; CNF/DNF/PIP/CpAH will be skipped"
    fi
fi

required_files=(
    plan-cegis
    lama/translate/translate.py
    lama/preprocess/preprocess
    lama/search/release-search
    t0-planner/translator/translator/translator-t0
    T1/t1
    T1/libdnnf/c2d_linux
    conformant-ff/ff
    pond/pond
    cnf_planner/cnf
    dnf_planner/dnf
    pip_planner/pip
    CpAH/CPAH
    iGC/lama/translate/translate.py
    iGC/lama/preprocess/preprocess
    iGC/lama/search/release-search
    GC_LAMA/lama/translate/translate.py
    GC_LAMA/lama/preprocess/preprocess
    GC_LAMA/lama/search/release-search
    gCPCES/build/main.class
    gCPCES/ff
    gCPCES/MpC
    iCPCES/conformant_planning.py
    iCPCES/classical_planner/ff
)

for rel in "${required_files[@]}"; do
    if [[ -s "$SCRIPT_DIR/$rel" ]]; then
        ok "file: $rel"
    else
        fail "missing or empty: $rel"
    fi
done

native_dirs=(
    T0-Benchmark-success
    T1-Benchmark-succes
    CFF-Benchmark-succes
    POND-Benchmark-succes
    CNF-Benchmark-succes
    DNF-Benchmark-succes
    PIP-Benchmark-succes
    CPA-Benchmark-succes
    iGC-Benchmark-succes
    GC-Benchmark-succes
    gCPCES-Benchmark-succes
    ICPCES-Benchmark-succes
)

for rel in "${native_dirs[@]}"; do
    if [[ -d "$SCRIPT_DIR/test/.native-fallback/$rel" ]]; then
        ok "native library: $rel"
    else
        fail "native library missing: $rel"
    fi
done

elf_files=(
    lama/search/release-search
    pond/pond
    conformant-ff/ff
    iGC/lama/search/release-search
    GC_LAMA/lama/search/release-search
    gCPCES/ff
)

for rel in "${elf_files[@]}"; do
    if file "$SCRIPT_DIR/$rel" | grep -q 'ELF'; then
        unresolved="$(ldd "$SCRIPT_DIR/$rel" 2>&1 | grep 'not found' || true)"
        if [[ -n "$unresolved" ]]; then
            fail "$rel has unresolved libraries: $unresolved"
        else
            ok "ELF libraries: $rel"
        fi
    else
        fail "$rel is not an ELF executable"
    fi
done

if "$SCRIPT_DIR/plan-cegis" --help >/dev/null 2>&1; then
    ok "plan-cegis startup"
else
    fail "plan-cegis --help failed"
fi

echo "-----------------------------"
echo "failures=$failures warnings=$warnings"
if (( failures > 0 )); then
    exit 1
fi
exit 0
