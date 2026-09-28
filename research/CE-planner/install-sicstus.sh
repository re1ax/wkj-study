#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODE="${1:---auto}"
ARCHIVE_NAME="sp-4.10.1-x86_64-linux-glibc2.28.tar.gz"
DOWNLOAD_URL="https://sicstus.sics.se/sicstus/products4/sicstus/4.10.1/binaries/linux/$ARCHIVE_NAME"
EXPECTED_SHA256="276b169541a3e48d8ff39ff2c58ce36f165507da0d56f186a645be21a2bdd8ad"
PREFIX="${SICSTUS_PREFIX:-$SCRIPT_DIR/.local/sicstus}"
DOWNLOAD_DIR="${SICSTUS_DOWNLOAD_DIR:-$SCRIPT_DIR/.cache/sicstus}"

usage() {
    cat <<EOF
Usage: ./install-sicstus.sh [--auto|--install|--download|--check]

Installs optional SICStus Prolog 4.10.1.

Archive lookup order:
  1. SICSTUS_ARCHIVE
  2. the project directory
  3. the parent of the project directory
  4. the current working directory
  5. the project download cache

If no archive is available, --install downloads it from:
  $DOWNLOAD_URL

--auto      Offer download/installation when running in a terminal. When all
            three private license variables below are set, installation is
            non-interactive.
--install   Download when necessary and install.
--download  Download and checksum-verify the archive without installing.
--check     Report the installed binary or archive status without downloading.

Optional private variables for non-interactive local testing:
  SICSTUS_SITE_NAME
  SICSTUS_LICENSE_CODE
  SICSTUS_EXPIRATION_DATE

License values are not accepted as command-line arguments, written to this
source tree, or printed by this script. Do not commit or redistribute them.
Set SICSTUS_SKIP=1 to skip SICStus.
EOF
}

case "$MODE" in
    --auto|--install|--download|--check) ;;
    -h|--help) usage; exit 0 ;;
    *) usage >&2; exit 2 ;;
esac

if [[ "${SICSTUS_SKIP:-0}" == "1" ]]; then
    echo "SICStus installation skipped (SICSTUS_SKIP=1)."
    exit 0
fi

if [[ -x "$PREFIX/bin/sicstus" ]] &&
   "$PREFIX/bin/sicstus" --version >/dev/null 2>&1; then
    echo "SICStus is ready: $PREFIX/bin/sicstus"
    exit 0
fi

if command -v sicstus >/dev/null 2>&1 &&
   sicstus --version >/dev/null 2>&1; then
    echo "SICStus is ready: $(command -v sicstus)"
    exit 0
fi

all_license_values_present() {
    [[ -n "${SICSTUS_SITE_NAME:-}" &&
       -n "${SICSTUS_LICENSE_CODE:-}" &&
       -n "${SICSTUS_EXPIRATION_DATE:-}" ]]
}

any_license_value_present() {
    [[ -n "${SICSTUS_SITE_NAME:-}" ||
       -n "${SICSTUS_LICENSE_CODE:-}" ||
       -n "${SICSTUS_EXPIRATION_DATE:-}" ]]
}

optional_failure() {
    echo "WARNING: $*" >&2
    if [[ "$MODE" == "--auto" ]]; then
        echo "Continuing with the 8 routes that do not require SICStus." >&2
        exit 0
    fi
    exit 1
}

archive=""
declare -a candidates=()
if [[ -n "${SICSTUS_ARCHIVE:-}" ]]; then
    candidates+=("$SICSTUS_ARCHIVE")
fi
candidates+=(
    "$SCRIPT_DIR/$ARCHIVE_NAME"
    "$(dirname "$SCRIPT_DIR")/$ARCHIVE_NAME"
    "$PWD/$ARCHIVE_NAME"
    "$DOWNLOAD_DIR/$ARCHIVE_NAME"
)

for candidate in "${candidates[@]}"; do
    if [[ -f "$candidate" ]]; then
        archive="$(cd "$(dirname "$candidate")" && pwd)/$(basename "$candidate")"
        break
    fi
done

if [[ -z "$archive" && "$MODE" == "--check" ]]; then
    echo "SICStus is not installed and no local archive was found."
    echo "Official download: $DOWNLOAD_URL"
    exit 0
fi

download_archive=0
if [[ -z "$archive" ]]; then
    case "$MODE" in
        --download|--install)
            download_archive=1
            ;;
        --auto)
            if [[ "${SICSTUS_NO_DOWNLOAD:-0}" == "1" ]]; then
                echo "Optional SICStus download disabled; continuing with 8 open routes."
                exit 0
            elif all_license_values_present; then
                download_archive=1
            elif [[ -t 0 && -t 1 ]]; then
                printf 'Download optional SICStus 4.10.1 (about 38 MB)? [y/N] '
                read -r answer
                case "$answer" in
                    y|Y|yes|YES) download_archive=1 ;;
                    *)
                        echo "SICStus download skipped; 8 open routes remain available."
                        exit 0
                        ;;
                esac
            else
                echo "Optional SICStus archive not found; continuing with 8 open routes."
                exit 0
            fi
            ;;
    esac
fi

if (( download_archive )); then
    if ! command -v curl >/dev/null 2>&1; then
        optional_failure "curl is required to download SICStus."
    fi
    mkdir -p "$DOWNLOAD_DIR"
    partial_archive="$DOWNLOAD_DIR/$ARCHIVE_NAME.part"
    rm -f -- "$partial_archive"
    echo "Downloading optional SICStus 4.10.1 from the official site ..."
    if ! curl --fail --location --retry 3 --connect-timeout 30 \
        "$DOWNLOAD_URL" --output "$partial_archive"; then
        rm -f -- "$partial_archive"
        optional_failure "SICStus download failed. You may supply SICSTUS_ARCHIVE manually."
    fi
    mv "$partial_archive" "$DOWNLOAD_DIR/$ARCHIVE_NAME"
    archive="$DOWNLOAD_DIR/$ARCHIVE_NAME"
fi

actual_sha256="$(sha256sum "$archive" | awk '{print $1}')"
if [[ "$actual_sha256" != "$EXPECTED_SHA256" ]]; then
    optional_failure "SICStus archive checksum mismatch."
fi

echo "SICStus archive checksum verified."
if [[ "$MODE" == "--check" || "$MODE" == "--download" ]]; then
    exit 0
fi

noninteractive=0
if all_license_values_present; then
    noninteractive=1
elif any_license_value_present; then
    optional_failure "all three SICStus license variables must be set together."
fi

if [[ "$MODE" == "--auto" && $noninteractive -eq 0 ]]; then
    if [[ ! -t 0 || ! -t 1 ]]; then
        echo "No interactive terminal or private license variables are available."
        echo "Skipping optional SICStus installation; 8 open routes remain available."
        exit 0
    fi
    printf 'Install optional SICStus 4.10.1 under .local/sicstus now? [y/N] '
    read -r answer
    case "$answer" in
        y|Y|yes|YES) ;;
        *)
            echo "SICStus installation skipped; 8 open routes remain available."
            exit 0
            ;;
    esac
elif [[ "$MODE" == "--install" &&
        $noninteractive -eq 0 &&
        ( ! -t 0 || ! -t 1 ) ]]; then
    echo "ERROR: an interactive terminal or all three private license variables are required." >&2
    exit 1
fi

if [[ -e "$PREFIX" ]]; then
    optional_failure "target exists but does not contain a usable SICStus: $PREFIX"
fi

work_dir="$(mktemp -d)"
mkdir -p "$(dirname "$PREFIX")"
temporary_prefix="$(mktemp -d "$(dirname "$PREFIX")/.sicstus-install-XXXXXXXX")"

cleanup() {
    rm -rf -- "$work_dir"
    if [[ -n "${temporary_prefix:-}" &&
          "$temporary_prefix" == "$(dirname "$PREFIX")"/.sicstus-install-* &&
          -d "$temporary_prefix" ]]; then
        rm -rf -- "$temporary_prefix"
    fi
}
trap cleanup EXIT

if tar -tzf "$archive" |
   awk 'BEGIN { bad=0 }
        /^\// || /(^|\/)\.\.(\/|$)/ { bad=1 }
        END { exit bad }'; then
    tar -xzf "$archive" -C "$work_dir"
else
    optional_failure "unsafe path found in the SICStus archive."
fi

installer="$(find "$work_dir" -mindepth 2 -maxdepth 2 \
    -type f -name InstallSICStus -print -quit)"
if [[ -z "$installer" ]]; then
    optional_failure "InstallSICStus was not found in the archive."
fi
chmod u+x "$installer"

echo "Starting the SICStus vendor installer."
set +e
if (( noninteractive )); then
    site_name_pattern='^[A-Za-z0-9._ -]+$'
    license_code_pattern='^[A-Za-z0-9-]+$'
    expiration_pattern='^([0-9]{8}|permanent)$'
    if [[ ! "$SICSTUS_SITE_NAME" =~ $site_name_pattern ||
          ! "$SICSTUS_LICENSE_CODE" =~ $license_code_pattern ||
          ! "$SICSTUS_EXPIRATION_DATE" =~ $expiration_pattern ]]; then
        echo "ERROR: invalid format in private SICStus license variables." >&2
        installer_rc=1
    else
        (
            cd "$(dirname "$installer")"
            umask 077
            {
                printf "sitename='%s'\n" "$SICSTUS_SITE_NAME"
                printf "licensecode='%s'\n" "$SICSTUS_LICENSE_CODE"
                printf "expires='%s'\n" "$SICSTUS_EXPIRATION_DATE"
            } > install.cache
            "$installer" \
                --batch \
                --prebuilt \
                --without-java \
                --without-tcltk \
                --prefix "$temporary_prefix"
        ) >"$work_dir/vendor-install.log" 2>&1
        installer_rc=$?
    fi
else
    (
        cd "$(dirname "$installer")"
        "$installer" \
            --prebuilt \
            --without-java \
            --without-tcltk \
            --prefix "$temporary_prefix"
    )
    installer_rc=$?
fi
set -e

if (( installer_rc != 0 )) ||
   [[ ! -x "$temporary_prefix/bin/sicstus" ]] ||
   ! "$temporary_prefix/bin/sicstus" --version >/dev/null 2>&1; then
    optional_failure "optional SICStus installation did not complete."
fi

mv "$temporary_prefix" "$PREFIX"
temporary_prefix=""
echo "SICStus installed locally: $PREFIX/bin/sicstus"
