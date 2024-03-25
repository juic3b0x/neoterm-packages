NEOTERM_PKG_HOMEPAGE="https://github.com/n-t-roff/sc"
NEOTERM_PKG_DESCRIPTION="A vi-like spreadsheet calculator"
NEOTERM_PKG_LICENSE="Public Domain"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="7.16-1.1.2"
NEOTERM_PKG_SRCURL=https://github.com/n-t-roff/sc/archive/refs/tags/$(sed 's/-/_/' <<< $NEOTERM_PKG_VERSION).tar.gz
NEOTERM_PKG_SHA256=1802c9d3d60dac85feb783adf967bc0d2fd7e5f592d9d1df15e4e87d83efcf14
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_SED_REGEXP='s/_/-/'
NEOTERM_PKG_DEPENDS="ncurses"
NEOTERM_PKG_BUILD_IN_SRC=true
# n-t-roff-sc is a maintained fork of sc and thus replaces the original
NEOTERM_PKG_CONFLICTS="sc"
NEOTERM_PKG_REPLACES="sc"
NEOTERM_PKG_PROVIDES="sc"

neoterm_step_post_configure () {
	CFLAGS+=" -I$NEOTERM_PREFIX/include"
}
