#!/usr/bin/env bash

set -u

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REQUIRE_ALL=0

case "${1:-}" in
    "") ;;
    --require-all) REQUIRE_ALL=1 ;;
    -h|--help)
        echo "Usage: ./run-all-examples.sh [--require-all]"
        exit 0
        ;;
    *)
        echo "Usage: ./run-all-examples.sh [--require-all]" >&2
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

has_sicstus=0
if command -v sicstus >/dev/null 2>&1 &&
   sicstus --version >/dev/null 2>&1; then
    has_sicstus=1
fi

# Each route uses a small case present in both the public example set and that
# route's retained native-fallback library. These mappings were regression
# tested on Ubuntu 24.04; they intentionally do not all use blocks/b2.
ROUTE_CASES=(
    "t0|bomb/p5-1|open"
    "t1|omlette/p3|open"
    "cff|blocks/b2|open"
    "pond|safe/p5|open"
    "cnf|or-coins/p10|sicstus"
    "dnf|blocks/b3|sicstus"
    "pip|or-coins/p15|sicstus"
    "cpah|bomb/p10-1|sicstus"
    "igc|safe/p10|open"
    "gc-lama|blocks/b3|open"
    "gcpces|safe/p5|open"
    "icpces|blocks/b3|open"
)

timeout_sec="${IGC_EXAMPLE_TIMEOUT:-120}"
profile="${IGC_EXAMPLE_PROFILE:-direct}"
run_prefix="${IGC_EXAMPLE_RUN_PREFIX:-reviewer-test}"
passes=0
failures=0
skips=0

cd "$SCRIPT_DIR" || exit 2

echo "CE-planner reviewer test matrix"
echo "================================"
for spec in "${ROUTE_CASES[@]}"; do
    IFS='|' read -r solver case_selector dependency <<<"$spec"

    if [[ "$dependency" == "sicstus" && $has_sicstus -eq 0 ]]; then
        printf 'SKIP  %-8s %-18s SICStus unavailable\n' "$solver" "$case_selector"
        skips=$((skips + 1))
        continue
    fi

    printf 'RUN   %-8s %-18s ' "$solver" "$case_selector"
    IGC_FALLBACK_PROFILE="$profile" \
        ./run-test-ce.sh \
        --solver "$solver" \
        --case "$case_selector" \
        --timeout "$timeout_sec" \
        --run-id "$run_prefix-$solver" >/dev/null 2>&1
    rc=$?

    if [[ $rc -eq 0 ]]; then
        echo "VALID"
        passes=$((passes + 1))
    else
        echo "FAILED (exit $rc)"
        failures=$((failures + 1))
    fi
done

echo "--------------------------------"
echo "passes=$passes failures=$failures skips=$skips"
echo "Detailed logs: $SCRIPT_DIR/test_logs_ce/${run_prefix}-<route>/"

if (( REQUIRE_ALL && skips > 0 )); then
    echo "ERROR: --require-all requested all 12 routes, but SICStus routes were skipped." >&2
    exit 3
fi
(( failures == 0 ))
