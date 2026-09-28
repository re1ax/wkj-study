#!/usr/bin/env bash

set -u

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
CASE_SELECTOR="${IGC_SMOKE_CASE:-blocks/b2}"
TIMEOUT_SEC="${IGC_SMOKE_TIMEOUT:-120}"
PROFILE="${IGC_SMOKE_PROFILE:-direct}"
SOLVERS="${IGC_SMOKE_SOLVERS:-t0 t1 cff pond cnf dnf pip cpah igc gc-lama gcpces icpces}"
RUN_PREFIX="${IGC_SMOKE_RUN_PREFIX:-route-smoke}"

failures=0
passes=0

cd "$ROOT_DIR" || exit 2

for solver in $SOLVERS; do
    echo "=== MATRIX_START solver=$solver case=$CASE_SELECTOR ==="
    IGC_FALLBACK_PROFILE="$PROFILE" \
        ./run-test-ce.sh \
        --solver "$solver" \
        --case "$CASE_SELECTOR" \
        --timeout "$TIMEOUT_SEC" \
        --run-id "$RUN_PREFIX-$solver"
    rc=$?
    echo "=== MATRIX_END solver=$solver rc=$rc ==="
    if [[ $rc -eq 0 ]]; then
        passes=$((passes + 1))
    else
        failures=$((failures + 1))
    fi
done

echo "=== MATRIX_SUMMARY passes=$passes failures=$failures ==="
[[ $failures -eq 0 ]]
