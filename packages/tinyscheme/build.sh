NEOTERM_PKG_HOMEPAGE=https://tinyscheme.sourceforge.net/home.html
NEOTERM_PKG_DESCRIPTION="Very small scheme implementation"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.42
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=http://downloads.sourceforge.net/project/tinyscheme/tinyscheme/tinyscheme-${NEOTERM_PKG_VERSION}/tinyscheme-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=17b0b1bffd22f3d49d5833e22a120b339039d2cfda0b46d6fc51dd2f01b407ad
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	LD=$CC
}

neoterm_step_post_make_install() {
	mkdir -p $NEOTERM_PREFIX/share/tinyscheme/
	cp $NEOTERM_PKG_SRCDIR/init.scm $NEOTERM_PREFIX/share/tinyscheme/
}
