NEOTERM_PKG_HOMEPAGE=https://www.stunprotocol.org/
NEOTERM_PKG_DESCRIPTION="An open source STUN server"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.2.16
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://www.stunprotocol.org/stunserver-${NEOTERM_PKG_VERSION}.tgz
NEOTERM_PKG_SHA256=4479e1ae070651dfc4836a998267c7ac2fba4f011abcfdca3b8ccd7736d4fd26
NEOTERM_PKG_DEPENDS="libc++, openssl"
NEOTERM_PKG_BUILD_DEPENDS="boost, boost-headers"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="T=" # In case if environment variable `T` is defined

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin "$NEOTERM_PKG_BUILDDIR/stunclient"
	install -Dm700 -t $NEOTERM_PREFIX/bin "$NEOTERM_PKG_BUILDDIR/stunserver"
}
