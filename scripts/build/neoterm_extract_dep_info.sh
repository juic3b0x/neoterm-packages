#!/usr/bin/bash

neoterm_extract_dep_info() {
	PKG=$1
	PKG_DIR=$2
	if [ "$PKG" != "$(basename ${PKG_DIR})" ] && [ "${PKG/-glibc/}" != "$(basename ${PKG_DIR})" ]; then
		# We are dealing with a subpackage
		NEOTERM_ARCH=$(
			# set NEOTERM_SUBPKG_PLATFORM_INDEPENDENT to
			# parent package's value and override if
			# needed
			NEOTERM_PKG_PLATFORM_INDEPENDENT=false
			source ${PKG_DIR}/build.sh
			NEOTERM_SUBPKG_PLATFORM_INDEPENDENT=$NEOTERM_PKG_PLATFORM_INDEPENDENT
			if [ "$NEOTERM_INSTALL_DEPS" = "false" ] || \
				   [ "$NEOTERM_PKG_NO_STATICSPLIT" = "true" ] || \
				   [ "${PKG/-static/}-static" != "${PKG}" ]; then
				if [ -f "${PKG_DIR}/${PKG}.subpackage.sh" ]; then
					source ${PKG_DIR}/${PKG}.subpackage.sh
				else
					source ${PKG_DIR}/${PKG/-glibc/}.subpackage.sh
				fi
			fi
			if [ "$NEOTERM_SUBPKG_PLATFORM_INDEPENDENT" = "true" ]; then
				echo all
			else
				echo $NEOTERM_ARCH
			fi
		)
	else
		NEOTERM_ARCH=$(
			NEOTERM_PKG_PLATFORM_INDEPENDENT="false"
			source ${PKG_DIR}/build.sh
			if [ "$NEOTERM_PKG_PLATFORM_INDEPENDENT" = "true" ]; then
				echo all
			else
				echo $NEOTERM_ARCH
			fi
		)
	fi
	(
		# debian version
		NEOTERM_PKG_REVISION="0"
		source ${PKG_DIR}/build.sh
		if [ "$NEOTERM_PKG_REVISION" != "0" ] || \
			   [ "$NEOTERM_PKG_VERSION" != "${NEOTERM_PKG_VERSION/-/}" ]; then
			NEOTERM_PKG_VERSION+="-$NEOTERM_PKG_REVISION"
		fi
		echo -n "${NEOTERM_ARCH} ${NEOTERM_PKG_VERSION} "
	)
	(
		# pacman version
		NEOTERM_PKG_REVISION="0"
		source ${PKG_DIR}/build.sh
		NEOTERM_PKG_VERSION_EDITED=${NEOTERM_PKG_VERSION//-/.}
		INCORRECT_SYMBOLS=$(echo $NEOTERM_PKG_VERSION_EDITED | grep -o '[0-9][a-z]')
		if [ -n "$INCORRECT_SYMBOLS" ]; then
			NEOTERM_PKG_VERSION_EDITED=${NEOTERM_PKG_VERSION_EDITED//${INCORRECT_SYMBOLS:0:1}${INCORRECT_SYMBOLS:1:1}/${INCORRECT_SYMBOLS:0:1}.${INCORRECT_SYMBOLS:1:1}}
		fi
		echo "${NEOTERM_PKG_VERSION_EDITED}-${NEOTERM_PKG_REVISION}"
	)
}

# Make script standalone executable as well as sourceable
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
	neoterm_extract_dep_info "$@"
fi
