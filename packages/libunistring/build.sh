NEOTERM_PKG_HOMEPAGE=https://www.gnu.org/software/libunistring/
NEOTERM_PKG_DESCRIPTION="Library providing functions for manipulating Unicode strings"
NEOTERM_PKG_LICENSE="LGPL-3.0, GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.1
NEOTERM_PKG_SRCURL=https://mirrors.kernel.org/gnu/libunistring/libunistring-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=827c1eb9cb6e7c738b171745dac0888aa58c5924df2e59239318383de0729b98
NEOTERM_PKG_DEPENDS="libandroid-support, libiconv"
NEOTERM_PKG_BREAKS="libunistring-dev"
NEOTERM_PKG_REPLACES="libunistring-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_func_uselocale=no am_cv_langinfo_codeset=yes"
