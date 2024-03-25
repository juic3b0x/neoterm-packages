NEOTERM_PKG_HOMEPAGE=https://www.knot-dns.cz/
NEOTERM_PKG_DESCRIPTION="Knot DNS libraries"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.2.4
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://secure.nic.cz/files/knot-dns/knot-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=299e8de918f9fc7ecbe625b41cb085e47cdda542612efbd51cd5ec60deb9dd13
NEOTERM_PKG_DEPENDS="libgnutls, liblmdb"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-daemon
--disable-modules
--enable-utilities
"
