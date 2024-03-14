NEOTERM_PKG_HOMEPAGE=https://www.gnu.org/software/gtypist/
NEOTERM_PKG_DESCRIPTION="Universal typing tutor"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.9.5
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://mirrors.kernel.org/gnu/gtypist/gtypist-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=c13af40b12479f8219ffa6c66020618c0ce305ad305590fde02d2c20eb9cf977
NEOTERM_PKG_DEPENDS="libandroid-support, libiconv, ncurses"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_header_ncursesw_ncurses_h=yes --enable-nls=no ac_cv_header_libintl_h=no"
NEOTERM_PKG_RM_AFTER_INSTALL="share/emacs/site-lisp bin/typefortune share/man/man1/typefortune.1"
