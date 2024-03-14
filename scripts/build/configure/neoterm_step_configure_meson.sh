neoterm_step_configure_meson() {
	neoterm_setup_meson

	local _meson_buildtype="minsize"
	local _meson_stripflag="--strip"
	if [ "$NEOTERM_DEBUG_BUILD" = "true" ]; then
		_meson_buildtype="debug"
		_meson_stripflag=
	fi

	CC=gcc CXX=g++ CFLAGS= CXXFLAGS= CPPFLAGS= LDFLAGS= $NEOTERM_MESON \
		$NEOTERM_PKG_SRCDIR \
		$NEOTERM_PKG_BUILDDIR \
		--$(test "${NEOTERM_PKG_MESON_NATIVE}" = "true" && echo "native-file" || echo "cross-file") $NEOTERM_MESON_CROSSFILE \
		--prefix $NEOTERM_PREFIX \
		--libdir lib \
		--buildtype ${_meson_buildtype} \
		${_meson_stripflag} \
		$NEOTERM_PKG_EXTRA_CONFIGURE_ARGS \
		|| (neoterm_step_configure_meson_failure_hook && false)
}

neoterm_step_configure_meson_failure_hook() {
	false
}
