NEOTERM_PKG_HOMEPAGE=https://github.com/neovim/unibilium
NEOTERM_PKG_DESCRIPTION="Terminfo parsing library"
NEOTERM_PKG_LICENSE="LGPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.1.1
NEOTERM_PKG_SRCURL=https://github.com/neovim/unibilium/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=6f0ee21c8605340cfbb458cbd195b4d074e6d16dd0c0e12f2627ca773f3cabf1
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BREAKS="libunibilium-dev"
NEOTERM_PKG_REPLACES="libunibilium-dev"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=4

	local a
	for a in LT_CURRENT LT_AGE; do
		local _${a}=$(sed -En 's/^'"${a}"'=([0-9]+).*/\1/p' Makefile)
	done
	local v=$(( _LT_CURRENT - _LT_AGE ))
	if [ ! "${_LT_CURRENT}" ] || [ "${v}" != "${_SOVERSION}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}

neoterm_step_pre_configure() {
	rm -f CMakeLists.txt
}

neoterm_step_make() {
	return
}

neoterm_step_make_install() {
	CFLAGS+=" -DTERMINFO_DIRS=\"$NEOTERM_PREFIX/share/terminfo/\""
	$CC $CFLAGS -c -fPIC unibilium.c -o unibilium.o
	$CC $CFLAGS -c -fPIC uninames.c -o uninames.o
	$CC $CFLAGS -c -fPIC uniutil.c -o uniutil.o
	$CC -shared -fPIC $LDFLAGS -o $NEOTERM_PREFIX/lib/libunibilium.so unibilium.o uninames.o uniutil.o
	cp unibilium.h $NEOTERM_PREFIX/include/

	mkdir -p $PKG_CONFIG_LIBDIR
	sed "s|@VERSION@|$NEOTERM_PKG_VERSION|" unibilium.pc.in | \
		sed "s|@INCDIR@|$NEOTERM_PREFIX/include|" | \
		sed "s|@LIBDIR@|$NEOTERM_PREFIX/lib|" > \
		$PKG_CONFIG_LIBDIR/unibilium.pc
}
