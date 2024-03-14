neoterm_step_make() {
	[ "$NEOTERM_PKG_METAPACKAGE" = "true" ] && return

	local QUIET_BUILD=
	if [ "$NEOTERM_QUIET_BUILD" = true ]; then
		QUIET_BUILD="-s"
	fi

	if test -f build.ninja; then
		ninja -w dupbuild=warn -j $NEOTERM_MAKE_PROCESSES
	elif ls ./*.cabal &>/dev/null; then
		cabal build
	elif ls ./*akefile &>/dev/null || [ ! -z "$NEOTERM_PKG_EXTRA_MAKE_ARGS" ]; then
		if [ -z "$NEOTERM_PKG_EXTRA_MAKE_ARGS" ]; then
			make -j $NEOTERM_MAKE_PROCESSES $QUIET_BUILD
		else
			make -j $NEOTERM_MAKE_PROCESSES $QUIET_BUILD ${NEOTERM_PKG_EXTRA_MAKE_ARGS}
		fi
	fi
}
