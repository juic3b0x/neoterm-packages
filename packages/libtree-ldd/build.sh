NEOTERM_PKG_HOMEPAGE=https://github.com/haampie/libtree
NEOTERM_PKG_DESCRIPTION="Like ldd(1), but prints a tree(1) like output"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@flosnvjx"
NEOTERM_PKG_VERSION=3.1.1
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/haampie/libtree/archive/refs/tags/v"$NEOTERM_PKG_VERSION".tar.gz
NEOTERM_PKG_SHA256=6148436f54296945d22420254dd78e1829d60124bb2f5b9881320a6550f73f5c
NEOTERM_PKG_DEPENDS="libandroid-glob"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
	CFLAGS+=" $CPPFLAGS"
}
