NEOTERM_PKG_HOMEPAGE=https://www.cgsecurity.org/wiki/TestDisk
NEOTERM_PKG_DESCRIPTION="Partition Recovery and File Undelete"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=7.1
NEOTERM_PKG_REVISION=5
NEOTERM_PKG_SRCURL=https://www.cgsecurity.org/testdisk-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=1413c47569e48c5b22653b943d48136cb228abcbd6f03da109c4df63382190fe
NEOTERM_PKG_DEPENDS="libuuid, zlib, libjpeg-turbo, libiconv, ncurses, libandroid-glob"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--bindir=$NEOTERM_PREFIX/bin
--sysconfdir=$NEOTERM_PREFIX/etc
--localstatedir=$NEOTERM_PREFIX/var
--mandir=$NEOTERM_PREFIX/share/man
--without-ewf
--without-ntfs3g
--without-ntfs
--without-reiserfs
"

neoterm_step_pre_configure() {
	export LIBS="-lncurses -landroid-glob"
}

neoterm_step_make() {
	make -j2 static
}
