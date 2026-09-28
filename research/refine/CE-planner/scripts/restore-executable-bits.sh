#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
restored=0

# ZIP stores POSIX modes, but extracting on Windows and then copying to Linux
# can erase them. Restore only files whose contents prove that they are
# executable: scripts with a shebang and ELF executables. This avoids relying
# on filenames or broad chmod operations.
while IFS= read -r -d '' candidate; do
    is_executable=0
    if [[ "$(head -c 2 "$candidate" 2>/dev/null || true)" == "#!" ]]; then
        is_executable=1
    elif file -b "$candidate" 2>/dev/null |
         grep -Eq '^ELF .*(executable|interpreter)'; then
        is_executable=1
    fi

    if (( is_executable )) && [[ ! -x "$candidate" ]]; then
        chmod a+x "$candidate"
        restored=$((restored + 1))
    fi
done < <(find "$ROOT_DIR" \
    -path "$ROOT_DIR/.local" -prune -o \
    -type f -print0)

printf 'Executable permission check complete (restored=%d).\n' "$restored"
