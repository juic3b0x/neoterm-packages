NEOTERM_PKG_HOMEPAGE="http://www.ibiblio.org/pub/Linux/apps/financial/spreadsheet/!INDEX.html"
NEOTERM_PKG_DESCRIPTION="A vi-like spreadsheet calculator"
NEOTERM_PKG_LICENSE="Public Domain"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=7.16
NEOTERM_PKG_REVISION=4
NEOTERM_PKG_SRCURL=http://www.ibiblio.org/pub/Linux/apps/financial/spreadsheet/sc-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=1997a00b6d82d189b65f6fd2a856a34992abc99e50d9ec463bbf1afb750d1765
NEOTERM_PKG_DEPENDS="ncurses"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="SIMPLE=-DSIMPLE"
NEOTERM_PKG_ENABLE_CLANG16_PORTING=false

neoterm_step_post_configure () {
	CFLAGS+=" -I$NEOTERM_PREFIX/include"
}
