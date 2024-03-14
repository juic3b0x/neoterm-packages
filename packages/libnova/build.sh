NEOTERM_PKG_HOMEPAGE="https://libnova.sourceforge.net"
NEOTERM_PKG_DESCRIPTION="A general purpose, double precision, Celestial Mechanics, Astrometry and Astrodynamics library"
NEOTERM_PKG_GROUPS="science"
NEOTERM_PKG_LICENSE="LGPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.16
NEOTERM_PKG_SRCURL=https://deb.debian.org/debian/pool/main/libn/libnova/libnova_${NEOTERM_PKG_VERSION}.orig.tar.xz
NEOTERM_PKG_SHA256=5dea5b29cba777ab8de4fd30cdfdbc1728fe1b3c573902270c1106bad55439a2
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	autoreconf -fi
}
