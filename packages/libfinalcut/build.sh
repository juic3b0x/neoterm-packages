NEOTERM_PKG_HOMEPAGE=https://github.com/gansm/finalcut
NEOTERM_PKG_DESCRIPTION="A C++ class library and widget toolkit for creating a text-based user interface"
NEOTERM_PKG_LICENSE="LGPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.9.0"
NEOTERM_PKG_SRCURL=https://github.com/gansm/finalcut/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=73ff5016bf6de0a5d3d6e88104668b78a521c34229e7ca0c6a04b5d79ecf666e
NEOTERM_PKG_DEPENDS="libc++, ncurses"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	autoreconf -fi

	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
