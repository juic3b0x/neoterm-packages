NEOTERM_PKG_HOMEPAGE=https://www.haproxy.org/
NEOTERM_PKG_DESCRIPTION="The Reliable, High Performance TCP/HTTP Load Balancer"
NEOTERM_PKG_LICENSE="GPL-2.0, LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.9.6"
NEOTERM_PKG_SRCURL=https://www.haproxy.org/download/${NEOTERM_PKG_VERSION%.*}/src/haproxy-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=208adf47c8fa83c54978034ba5c0110b7463c47078f119bd052342171a3b9a0b
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="liblua53, openssl, pcre2, zlib"
NEOTERM_PKG_BUILD_IN_SRC=true

NEOTERM_PKG_CONFFILES="etc/haproxy/haproxy.cfg"

neoterm_step_pre_configure() {
	CFLAGS+=" -fwrapv"
}

neoterm_step_make() {
	CC="$CC -Wl,-rpath=$NEOTERM_PREFIX/lib -Wl,--enable-new-dtags"

	make \
		V=1 \
		CPU=generic \
		TARGET=generic \
		USE_GETADDRINFO=1 \
		USE_LUA=1 \
		LUA_INC="$NEOTERM_PREFIX/include/lua5.3" \
		LUA_LIB="$NEOTERM_PREFIX/lib" \
		LUA_LIB_NAME=lua5.3 \
		USE_OPENSSL=1 \
		USE_PCRE2=1 \
		PCRE2_CONFIG="$NEOTERM_PREFIX/bin/pcre2-config" \
		USE_ZLIB=1 \
		ADDINC="$CPPFLAGS" \
		CFLAGS="$CFLAGS" \
		LDFLAGS="$LDFLAGS"
}

neoterm_step_post_make_install() {
	mkdir -p "$NEOTERM_PREFIX"/etc/haproxy
	sed -e "s|@NEOTERM_PREFIX@|${NEOTERM_PREFIX}|g" \
		"$NEOTERM_PKG_BUILDER_DIR"/haproxy.cfg.in \
		> "$NEOTERM_PREFIX"/etc/haproxy/haproxy.cfg

	mkdir -p "$NEOTERM_PREFIX"/share/haproxy/examples/errorfiles
	install -m600 examples/*.cfg "$NEOTERM_PREFIX"/share/haproxy/examples/
	install -m600 examples/errorfiles/*.http \
		"$NEOTERM_PREFIX"/share/haproxy/examples/errorfiles/
}
