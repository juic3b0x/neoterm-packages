#!/bin/sh
# clean.sh - clean everything.
set -e -u

NEOTERM_SCRIPTDIR=$(cd "$(realpath "$(dirname "$0")")"; pwd)

# Store pid of current process in a file for docker__run_docker_exec_trap
. "$NEOTERM_SCRIPTDIR/scripts/utils/docker/docker.sh"; docker__create_docker_exec_pid_file


# Checking if script is running on Android with 2 different methods.
# Needed for safety to prevent execution of potentially dangerous
# operations such as 'rm -rf /data/*' on Android device.
if [ "$(uname -o)" = "Android" ] || [ -e "/system/bin/app_process" ]; then
	NEOTERM_ON_DEVICE_BUILD=true
else
	NEOTERM_ON_DEVICE_BUILD=false
fi

if [ "$(id -u)" = "0" ] && $NEOTERM_ON_DEVICE_BUILD; then
	echo "On-device execution of this script as root is disabled."
	exit 1
fi

# Read settings from .neotermrc if existing
test -f "$HOME/.neotermrc" && . "$HOME/.neotermrc"
: "${NEOTERM_TOPDIR:="$HOME/.neoterm-build"}"
: "${TMPDIR:=/tmp}"
export TMPDIR

# Lock file. Same as used in build-package.sh.
NEOTERM_BUILD_LOCK_FILE="${TMPDIR}/.neoterm-build.lck"
if [ ! -e "$NEOTERM_BUILD_LOCK_FILE" ]; then
	touch "$NEOTERM_BUILD_LOCK_FILE"
fi

{
	if ! flock -n 5; then
		echo "Not cleaning build directory since you have unfinished build running."
		exit 1
	fi

	if [ -d "$NEOTERM_TOPDIR" ]; then
		chmod +w -R "$NEOTERM_TOPDIR" || true
	fi

	if $NEOTERM_ON_DEVICE_BUILD; then
		# For on-device build cleanup /data shouldn't be erased.
		rm -Rf "$NEOTERM_TOPDIR"
	else
		find /data -mindepth 1 ! -regex '^/data/data/com.neoterm/cgct\(/.*\)?' -delete 2> /dev/null || true
		rm -Rf "$NEOTERM_TOPDIR"
	fi
} 5< "$NEOTERM_BUILD_LOCK_FILE"
