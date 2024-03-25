neoterm_step_configure() {
	[ "$NEOTERM_PKG_METAPACKAGE" = "true" ] && return

	# This check should be above autotools check as haskell package too makes use of configure scripts which
	# should be executed by its own build system.
	if ls "${NEOTERM_PKG_SRCDIR}"/*.cabal &>/dev/null; then
		[ "$NEOTERM_CONTINUE_BUILD" == "true" ] && return
		neoterm_step_configure_haskell_build
	elif [ "$NEOTERM_PKG_FORCE_CMAKE" = "false" ] && [ -f "$NEOTERM_PKG_SRCDIR/configure" ]; then
		if [ "$NEOTERM_CONTINUE_BUILD" == "true" ]; then
			return
		fi
		neoterm_step_configure_autotools
	elif [ "$NEOTERM_PKG_FORCE_CMAKE" = "true" ] || [ -f "$NEOTERM_PKG_SRCDIR/CMakeLists.txt" ]; then
		neoterm_setup_cmake
		if [ "$NEOTERM_CMAKE_BUILD" = Ninja ]; then
			neoterm_setup_ninja
		fi

		# Some packages, for example swift, uses cmake
		# internally, but cannot be configured with our
		# neoterm_step_configure_cmake function (CMakeLists.txt
		# is not in src dir)
		if [ -f "$NEOTERM_PKG_SRCDIR/CMakeLists.txt" ] &&
			[ "$NEOTERM_CONTINUE_BUILD" == "false" ]; then
			neoterm_step_configure_cmake
		fi
	elif [ -f "$NEOTERM_PKG_SRCDIR/meson.build" ]; then
		if [ "$NEOTERM_CONTINUE_BUILD" == "true" ]; then
			return
		fi
		neoterm_step_configure_meson
	fi
}
