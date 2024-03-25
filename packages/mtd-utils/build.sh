NEOTERM_PKG_HOMEPAGE=http://www.linux-mtd.infradead.org/
NEOTERM_PKG_DESCRIPTION="Utilities for dealing with MTD devices"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.1.6"
NEOTERM_PKG_SRCURL=ftp://ftp.infradead.org/pub/mtd-utils/mtd-utils-$NEOTERM_PKG_VERSION.tar.bz2
NEOTERM_PKG_SHA256=c1d853bc4adf83bcabd2792fc95af33bdd8643c97e8f7b3f0180af36af76f0e5
NEOTERM_PKG_DEPENDS="liblzo, libuuid, openssl, zlib, zstd, libandroid-execinfo"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	LDFLAGS+=" -landroid-execinfo"
}
