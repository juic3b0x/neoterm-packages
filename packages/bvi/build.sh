NEOTERM_PKG_HOMEPAGE=https://bvi.sourceforge.net/
NEOTERM_PKG_DESCRIPTION="Binary file editor based on vi"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_DEPENDS="ncurses"
NEOTERM_PKG_VERSION=1.4.2
NEOTERM_PKG_SRCURL=http://sourceforge.net/projects/bvi/files/bvi/${NEOTERM_PKG_VERSION}/bvi-${NEOTERM_PKG_VERSION}.src.tar.gz
NEOTERM_PKG_SHA256=4bba16c2b496963a9b939336c0abcc8d488664492080ae43a86da18cf4ce94f2
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_lib_ncursesw6_addnwstr=yes"
NEOTERM_PKG_RM_AFTER_INSTALL="share/applications share/pixmaps"
