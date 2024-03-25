NEOTERM_PKG_HOMEPAGE=https://openil.sourceforge.net/
NEOTERM_PKG_DESCRIPTION="A cross-platform image library utilizing a simple syntax"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.8.0
NEOTERM_PKG_REVISION=5
NEOTERM_PKG_SRCURL=https://github.com/DentonW/DevIL/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=52129f247b26fcb5554643c9e6bbee75c4b9717735fdbf3c6ebff08cee38ad37
NEOTERM_PKG_DEPENDS="libc++, libjasper, libjpeg-turbo, libpng, libtiff, littlecms"

neoterm_step_pre_configure() {
	NEOTERM_PKG_SRCDIR+="/DevIL"
}
