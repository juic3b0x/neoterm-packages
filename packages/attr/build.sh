NEOTERM_PKG_HOMEPAGE=http://savannah.nongnu.org/projects/attr/
NEOTERM_PKG_DESCRIPTION="Utilities for manipulating filesystem extended attributes"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.5.1
NEOTERM_PKG_SRCURL=http://download.savannah.gnu.org/releases/attr/attr-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=bae1c6949b258a0d68001367ce0c741cebdacdd3b62965d17e5eb23cd78adaf8
NEOTERM_PKG_BREAKS="attr-dev"
NEOTERM_PKG_REPLACES="attr-dev"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--enable-gettext=no"
# NEOTERM_PKG_MAKE_INSTALL_TARGET="install install-lib"
# attr.5 man page is in manpages:
NEOTERM_PKG_RM_AFTER_INSTALL="share/man/man5/attr.5"
