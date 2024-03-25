NEOTERM_PKG_HOMEPAGE=https://vtm.netxs.online/
NEOTERM_PKG_DESCRIPTION="Terminal multiplexer with TUI window manager and multi-party session sharing"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_LICENSE_FILE="LICENSE"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.9.74"
NEOTERM_PKG_SRCURL=https://github.com/netxs-group/vtm/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=9a8f471a75693e64731d2ec6211d8ca61e8bce37f49417809160c677ba7e406e
NEOTERM_PKG_DEPENDS="libc++"
NEOTERM_PKG_BUILD_DEPENDS="libandroid-spawn"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_pre_configure() {
	CXXFLAGS+=" -pthread"
}
