TERMUX_PKG_HOMEPAGE=https://capnproto.org/
TERMUX_PKG_DESCRIPTION="Data interchange format and capability-based RPC system"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@neoterm"
TERMUX_PKG_VERSION="1.0.2"
TERMUX_PKG_SRCURL=https://capnproto.org/capnproto-c++-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=9057dbc0223366b74bbeca33a05de164a229b0377927f1b7ef3828cdd8cb1d7e
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="libc++"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_FORCE_CMAKE=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_SHARED_LIBS=ON
-DCMAKE_POSITION_INDEPENDENT_CODE=ON
-DWITH_FIBERS=OFF
"
