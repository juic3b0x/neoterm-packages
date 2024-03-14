NEOTERM_PKG_HOMEPAGE=https://github.com/rhash/RHash
NEOTERM_PKG_DESCRIPTION="Console utility for calculation and verification of magnet links and a wide range of hash sums"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.4.4
NEOTERM_PKG_SRCURL=https://github.com/rhash/RHash/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=8e7d1a8ccac0143c8fe9b68ebac67d485df119ea17a613f4038cda52f84ef52a
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="openssl"
NEOTERM_PKG_CONFLICTS="librhash, rhash-dev"
NEOTERM_PKG_REPLACES="librhash, rhash-dev"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_configure() {
	CFLAGS="-DOPENSSL_RUNTIME -DSYSCONFDIR=\"${NEOTERM_PREFIX}/etc\" $CPPFLAGS $CFLAGS"
	./configure \
		--prefix=$NEOTERM_PREFIX \
		--disable-static \
		--enable-lib-static \
		--enable-lib-shared \
		--cc=$CC
}

neoterm_step_make() {
	make -j $NEOTERM_MAKE_PROCESSES \
		ADDCFLAGS="$CFLAGS" \
		ADDLDFLAGS="$LDFLAGS"
}

neoterm_step_make_install() {
	make install install-pkg-config
	make -C librhash install-lib-headers

	ln -sf $NEOTERM_PREFIX/lib/librhash.so.1 $NEOTERM_PREFIX/lib/librhash.so
}

neoterm_step_post_massage() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION_GUARD_FILES="lib/librhash.so.1"
	local f
	for f in ${_SOVERSION_GUARD_FILES}; do
		if [ ! -e "${f}" ]; then
			neoterm_error_exit "SOVERSION guard check failed."
		fi
	done
}
