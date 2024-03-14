NEOTERM_PKG_HOMEPAGE=https://github.com/JFreegman/toxic
NEOTERM_PKG_DESCRIPTION="A command line client for Tox"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.14.1"
NEOTERM_PKG_SRCURL=https://github.com/JFreegman/toxic/archive/v${NEOTERM_PKG_VERSION}/toxic-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=232b72e2546694c668a6cb6e96ac109df3770ddd124361acce30366713880278
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="c-toxcore, libconfig, libcurl, libqrencode, ncurses, zlib"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	make \
		PREFIX="${NEOTERM_PREFIX}" \
		CC="${CC}" \
		PKG_CONFIG="${PKG_CONFIG}" \
		USER_CFLAGS="${CFLAGS}" \
		USER_LDFLAGS="${LDFLAGS}"
}

neoterm_step_make_install() {
	make PREFIX="${NEOTERM_PREFIX}" install
}
