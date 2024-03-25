#!/usr/bin/env bash

SCRIPT_DIR=$(dirname "$(realpath "$0")")
. "$SCRIPT_DIR"/properties.sh

check_package() { # path
	local path=$1
	local pkg=$(basename "$path")
	NEOTERM_PKG_REVISION=0
	NEOTERM_ARCH=aarch64
	. "$path"/build.sh
	if [ "$NEOTERM_PKG_REVISION" != "0" ] || [ "$NEOTERM_PKG_VERSION" != "${NEOTERM_PKG_VERSION/-/}" ]; then
		NEOTERM_PKG_VERSION+="-$NEOTERM_PKG_REVISION"
	fi
	echo "$pkg=$NEOTERM_PKG_VERSION"
}

for path in "${SCRIPT_DIR}"/../packages/*; do
(
	check_package "$path"
)
done
