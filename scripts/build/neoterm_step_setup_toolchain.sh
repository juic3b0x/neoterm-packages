neoterm_step_setup_toolchain() {
	if [ "$NEOTERM_PACKAGE_LIBRARY" = "bionic" ]; then
		NEOTERM_STANDALONE_TOOLCHAIN="$NEOTERM_COMMON_CACHEDIR/android-r${NEOTERM_NDK_VERSION}-api-${NEOTERM_PKG_API_LEVEL}"
		[ "$NEOTERM_PKG_METAPACKAGE" = "true" ] && return

		# Bump NEOTERM_STANDALONE_TOOLCHAIN if a change is made in
		# toolchain setup to ensure that everyone gets an updated
		# toolchain
		if [ "${NEOTERM_NDK_VERSION}" = "26b" ]; then
			NEOTERM_STANDALONE_TOOLCHAIN+="-v1"
			neoterm_setup_toolchain_26b
		elif [ "${NEOTERM_NDK_VERSION}" = 23c ]; then
			NEOTERM_STANDALONE_TOOLCHAIN+="-v6"
			neoterm_setup_toolchain_23c
		else
			neoterm_error_exit "We do not have a setup_toolchain function for NDK version $NEOTERM_NDK_VERSION"
		fi
	elif [ "$NEOTERM_PACKAGE_LIBRARY" = "glibc" ]; then
		if [ "$NEOTERM_ON_DEVICE_BUILD" = "true" ]; then
			NEOTERM_STANDALONE_TOOLCHAIN="$NEOTERM_PREFIX"
		else
			NEOTERM_STANDALONE_TOOLCHAIN="${CGCT_DIR}/${NEOTERM_ARCH}"
		fi
		neoterm_setup_toolchain_gnu
	fi
}
