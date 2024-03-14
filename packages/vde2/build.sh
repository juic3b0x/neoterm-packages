NEOTERM_PKG_HOMEPAGE=https://github.com/virtualsquare/vde-2
NEOTERM_PKG_DESCRIPTION="Virtual Distributed Ethernet for emulators like qemu"
NEOTERM_PKG_LICENSE="GPL-2.0, LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.3.3
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://github.com/virtualsquare/vde-2/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=a7d2cc4c3d0c0ffe6aff7eb0029212f2b098313029126dcd12dc542723972379
NEOTERM_PKG_DEPENDS="libpcap, libwolfssl"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	autoreconf --install
	CFLAGS+=" -Dindex=strchr -Drindex=strrchr"
}
