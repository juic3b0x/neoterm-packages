NEOTERM_PKG_HOMEPAGE=https://www.gnu.org/software/parted/
NEOTERM_PKG_DESCRIPTION="Versatile partition editor"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.6
NEOTERM_PKG_SRCURL=https://mirrors.kernel.org/gnu/parted/parted-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=3b43dbe33cca0f9a18601ebab56b7852b128ec1a3df3a9b30ccde5e73359e612
NEOTERM_PKG_DEPENDS="libblkid, libiconv, libuuid, ncurses, readline"
NEOTERM_PKG_BREAKS="parted-dev"
NEOTERM_PKG_REPLACES="parted-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-device-mapper
"

neoterm_step_pre_configure() {
	CFLAGS+=" -Wno-gnu-designator"
	export LIBS="-liconv"
}
