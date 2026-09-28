#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOLVER="${1:-t1}"
CASE_SELECTOR="${2:-blocks/b3}"
TIMEOUT_SEC="${3:-180}"
PROFILE="${4:-quick-debug}"
RUN_ID="${IGC_EXAMPLE_RUN_ID:-example-${SOLVER}}"

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

case "$SOLVER" in
    t0|t1|cff|pond|cnf|dnf|pip|cpah|igc|gc-lama|gcpces|icpces) ;;
    *)
        echo "ERROR: unknown solver '$SOLVER'." >&2
        exit 2
        ;;
esac

cd "$SCRIPT_DIR"
echo "Running solver=$SOLVER case=$CASE_SELECTOR profile=$PROFILE timeout=${TIMEOUT_SEC}s"
IGC_FALLBACK_PROFILE="$PROFILE" \
    ./run-test-ce.sh \
    --solver "$SOLVER" \
    --case "$CASE_SELECTOR" \
    --timeout "$TIMEOUT_SEC" \
    --run-id "$RUN_ID"

result="$SCRIPT_DIR/result_output_batch_ce/$RUN_ID/$CASE_SELECTOR/result.plan"
if [[ -s "$result" ]]; then
    echo
    echo "Validated plan: $result"
    cat "$result"
fi
