NEOTERM_PKG_HOMEPAGE=https://core.tcl.tk/expect/index
NEOTERM_PKG_DESCRIPTION="Tool for automating interactive terminal applications"
NEOTERM_PKG_LICENSE="Public Domain"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=5.45.4
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=http://downloads.sourceforge.net/project/expect/Expect/${NEOTERM_PKG_VERSION}/expect${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=49a7da83b0bdd9f46d04a04deec19c7767bb9a323e40c4781f89caf760b92c34
NEOTERM_PKG_DEPENDS="tcl"
NEOTERM_PKG_BREAKS="expect-dev"
NEOTERM_PKG_REPLACES="expect-dev"

neoterm_step_pre_configure() {
	autoconf

	CPPFLAGS+=" -DHAVE_SYS_WAIT_H"
}

neoterm_step_post_make_install() {
	cd $NEOTERM_PREFIX/lib
	ln -f -s expect${NEOTERM_PKG_VERSION}/libexpect${NEOTERM_PKG_VERSION}.so .
}
