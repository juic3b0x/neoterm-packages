NEOTERM_PKG_HOMEPAGE=https://serf.apache.org/
NEOTERM_PKG_DESCRIPTION="High performance C-based HTTP client library"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.3.10
NEOTERM_PKG_SRCURL=https://archive.apache.org/dist/serf/serf-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=be81ef08baa2516ecda76a77adf7def7bc3227eeb578b9a33b45f7b41dc064e6
NEOTERM_PKG_DEPENDS="apr, apr-util, openssl, zlib"
NEOTERM_PKG_BREAKS="serf-dev"
NEOTERM_PKG_REPLACES="serf-dev"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make_install() {
	scons \
		APR=$NEOTERM_PREFIX \
		APU=$NEOTERM_PREFIX \
		CC=$(command -v $CC) \
		CFLAGS="$CFLAGS" \
		CPPFLAGS="$CPPFLAGS" \
		LINKFLAGS="$LDFLAGS" \
		OPENSSL=$NEOTERM_PREFIX \
		PREFIX=$NEOTERM_PREFIX \
		install
}
