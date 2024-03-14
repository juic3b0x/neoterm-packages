NEOTERM_PKG_HOMEPAGE=https://www.linuxfromscratch.org/blfs/view/svn/general/popt.html
NEOTERM_PKG_DESCRIPTION="Library for parsing cmdline parameters"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.19
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=http://ftp.rpm.org/popt/releases/popt-1.x/popt-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=c25a4838fc8e4c1c8aacb8bd620edb3084a3d63bf8987fdad3ca2758c63240f9
NEOTERM_PKG_DEPENDS="libandroid-glob"
NEOTERM_PKG_BREAKS="libpopt-dev"
NEOTERM_PKG_REPLACES="libpopt-dev"
NEOTERM_PKG_RM_AFTER_INSTALL="lib/libpopt.la"

neoterm_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
}
