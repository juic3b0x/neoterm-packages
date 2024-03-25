NEOTERM_PKG_HOMEPAGE=https://www.gcd.org/sengoku/stone/
NEOTERM_PKG_DESCRIPTION="A TCP/IP repeater in the application layer"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.4
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://www.gcd.org/sengoku/stone/stone-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=d5dc1af6ec5da503f2a40b3df3fe19a8fbf9d3ce696b8f46f4d53d2ac8d8eb6f
NEOTERM_PKG_DEPENDS="openssl"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="-e stone"

neoterm_step_configure() {
	CFLAGS+=" $CPPFLAGS"
	export FLAGS="-DUSE_SSL -DUNIX_DAEMON -DNO_RINDEX -DUSE_EPOLL -DPTHREAD -DPRCTL -UANDROID"
	export LIBS="$LDFLAGS -lssl -lcrypto"
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin stone
}
