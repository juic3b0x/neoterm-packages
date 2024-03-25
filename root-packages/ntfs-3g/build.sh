NEOTERM_PKG_HOMEPAGE=https://github.com/tuxera/ntfs-3g
NEOTERM_PKG_DESCRIPTION="NTFS-3G Safe Read/Write NTFS Driver"
NEOTERM_PKG_LICENSE="GPL-2.0, LGPL-2.0"
NEOTERM_PKG_LICENSE_FILE="COPYING, COPYING.LIB"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2022.10.3
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/tuxera/ntfs-3g/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=8bd7749ea9d8534c9f0664d48b576e90b96d45ec8803c9427f6ffaa2f0dde299
NEOTERM_PKG_BUILD_DEPENDS="libfuse2, libgcrypt"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--with-fuse=external --exec-prefix=$NEOTERM_PREFIX --prefix=/"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_pre_configure() {
	CFLAGS+=" -I${NEOTERM_PREFIX}/include/fuse"
	NOCONFIGURE=1 autoreconf -vfi -I"$NEOTERM_PREFIX/share/aclocal/"
}

neoterm_step_make_install() {
	make install DESTDIR="$NEOTERM_PREFIX" man8dir="/share/man/man8" rootlibdir="/lib/" libdir="/lib/" rootbindir="/bin/" bindir="/bin/" sbindir="/bin"
}
