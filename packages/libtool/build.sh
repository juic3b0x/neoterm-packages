NEOTERM_PKG_HOMEPAGE=https://www.gnu.org/software/libtool/
NEOTERM_PKG_DESCRIPTION="Generic library support script hiding the complexity of using shared libraries behind a consistent, portable interface"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.4.7
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://mirrors.kernel.org/gnu/libtool/libtool-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=04e96c2404ea70c590c546eba4202a4e12722c640016c12b9b2f1ce3d481e9a8
NEOTERM_PKG_DEPENDS="bash, grep, sed, libltdl"
NEOTERM_PKG_CONFLICTS="libtool-dev, libtool-static"
NEOTERM_PKG_REPLACES="libtool-dev, libtool-static"
NEOTERM_PKG_NO_STATICSPLIT=true
NEOTERM_PKG_GROUPS="base-devel"

neoterm_step_post_make_install() {
	perl -p -i -e "s|\"/bin/|\"$NEOTERM_PREFIX/bin/|" $NEOTERM_PREFIX/bin/{libtool,libtoolize}
}
