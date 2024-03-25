NEOTERM_PKG_HOMEPAGE=https://github.com/astrand/xclip
NEOTERM_PKG_DESCRIPTION="Command line interface to the X11 clipboard"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="Yisus7u7 <dev.yisus@hotmail.com>"
NEOTERM_PKG_VERSION=0.13
NEOTERM_PKG_SRCURL=https://github.com/astrand/xclip/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=ca5b8804e3c910a66423a882d79bf3c9450b875ac8528791fb60ec9de667f758
NEOTERM_PKG_DEPENDS="libx11, libxmu"
NEOTERM_PKG_BUILD_DEPENDS="libxt"
NEOTERM_PKG_BUILD_IN_SRC=true
neoterm_step_pre_configure(){
	CFLAGS+=" $CPPFLAGS"
	./bootstrap
}
