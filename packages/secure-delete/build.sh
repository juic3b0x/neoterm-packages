NEOTERM_PKG_HOMEPAGE=https://www.thc.org/
NEOTERM_PKG_DESCRIPTION="Secure file, disk, swap, memory erasure utilities"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.1
NEOTERM_PKG_REVISION=5
NEOTERM_PKG_SRCURL=http://deb.debian.org/debian/pool/main/s/secure-delete/secure-delete_$NEOTERM_PKG_VERSION.orig.tar.gz
NEOTERM_PKG_SHA256=78af201401e6dc159298cb5430c28996a8bdc278391d942d1fe454534540ee3c
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	make -j1 CC="$CC"
}

neoterm_step_make_install() {
	make install INSTALL_DIR="$NEOTERM_PREFIX/bin"
	install -Dm600 -t "$NEOTERM_PREFIX"/share/man/man1 sfill.1 smem.1 srm.1 sswap.1
}
