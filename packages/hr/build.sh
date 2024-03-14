NEOTERM_PKG_HOMEPAGE=https://github.com/LuRsT/hr
NEOTERM_PKG_DESCRIPTION="A horizontal ruler for your terminal"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.4"
NEOTERM_PKG_SRCURL=$NEOTERM_PKG_HOMEPAGE/archive/$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=decaf6e09473cb5792ba606f761786d8dce3587a820c8937a74b38b1bf5d80fb
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_DEPENDS=bash
NEOTERM_PKG_PLATFORM_INDEPENDENT=true

neoterm_step_make() {
	return
}

neoterm_step_make_install() {
	local bin="$(basename $NEOTERM_PKG_HOMEPAGE)"
	install -D "$bin" -t "$NEOTERM_PREFIX/bin"
	install -D "$bin.1" -t "$NEOTERM_PREFIX/share/man/man1"
}
