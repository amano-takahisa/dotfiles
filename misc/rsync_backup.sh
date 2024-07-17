#!/bin/bash

set -euo pipefail
# coloring echo
ERROR_COLOR='\e[0;31m'  # Red
NC='\e[0m' # No Color

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
EXCLUDE_FILES="${SCRIPT_DIR}"/rsync_backup_excludes.txt
DEFAULT_SOURCE="${HOME}/"

function usage {
    cat <<EOF
$(basename "${0}") is a tool to backup files with rsync

Usage:
    $(basename "${0}") [<options>]

Options:
    --src SOURCE
        Absolute path to directory to be backup.
        Default is '${HOME}/'.

    --dst DESTINATION
        Absolute path to destination of backups.

    --dry-run
        Add -n option to rsync. List files and not backup.

    --help, -h
        Print this help.
EOF
}

function catch {
    echo -e "\n${ERROR_COLOR}ERROR:${NC}"
}

function finally {
    :
}

trap catch ERR
trap finally EXIT

# Parse command line arguments.
src="${DEFAULT_SOURCE}"
dry_run="false"
positional_args=()

while [[ $# -gt 0 ]]; do
    case $1 in
        --dry-run)  dry_run="true"; shift;;
        --src)  src="$2"; shift; shift;;
        --dst)  dst="$2"; shift; shift;;
        -h|--help)  usage && exit 0; shift;;
        --) shift;  positional_args+=("$@"); set --;;
        --*) echo "[ERROR] Unknown option $1" 1>&2; exit 1;;
        -*) shift;;
        *) positional_args+=("$1"); shift;;
    esac
done

if [[ "${dst+set}" == "" ]]; then
    echo "[ERROR] Not set --dst option" 1>&2 && usage 1>&2 && exit 1
fi

echo "${src}"
echo "${dst}"

host_name="$(uname -n)"

if ! compgen -G "${dst}/${host_name}-*" > /dev/null; then
    mkdir "${dst}/${host_name}-00000000-000000"
fi


# shellcheck disable=SC2010
latestbkup=$(ls "${dst}" | grep "${host_name}"- | tail -n 1)

rsync_flag='-avh'

if [[ "${dry_run}" == "true" ]]; then
    rsync_flag="${rsync_flag}"n
fi

cd "${src}"
rsync "${rsync_flag}" --link-dest="${dst}/${latestbkup}" \
    --exclude-from="${EXCLUDE_FILES}" \
    "${src}" "${dst}/${host_name}-$(date +%Y%m%d-%H%M%S)"
