NEOTERM_PKG_HOMEPAGE=https://memcached.org/
NEOTERM_PKG_DESCRIPTION="Free & open source, high-performance, distributed memory object caching system"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.6.24"
NEOTERM_PKG_SRCURL=https://www.memcached.org/files/memcached-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=f905ec0b38432a8a80bccd04e90e74d5ecba98b8f647e5d61e4bb54085a7a422
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libevent, libsasl"
NEOTERM_PKG_BREAKS="memcached-dev"
NEOTERM_PKG_REPLACES="memcached-dev"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--disable-static --enable-sasl --disable-coverage"

neoterm_step_pre_configure() {
	CPPFLAGS+=" -D__USE_GNU"

	export ac_cv_c_endian=little

	# Fix SASL configuration path
	perl -p -i -e "s#/etc/sasl#$NEOTERM_PREFIX/etc/sasl#" $NEOTERM_PKG_BUILDDIR/sasl_defs.c

	# getsubopt() taken from https://github.com/lxc/lxc/blob/master/src/include/getsubopt.c
	cp $NEOTERM_PKG_BUILDER_DIR/getsubopt.c $NEOTERM_PKG_SRCDIR
	cp $NEOTERM_PKG_BUILDER_DIR/getsubopt.h $NEOTERM_PKG_SRCDIR

	autoreconf -vfi
}
