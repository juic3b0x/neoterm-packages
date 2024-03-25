NEOTERM_PKG_HOMEPAGE=https://github.com/nicm/fdm
NEOTERM_PKG_DESCRIPTION="A program designed to fetch mail from POP3 or IMAP servers, or receive local mail from stdin, and deliver it in various ways"
NEOTERM_PKG_LICENSE="ISC, BSD 3-Clause"
NEOTERM_PKG_LICENSE_FILE="LICENSE, LICENSE.BSD"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.2
NEOTERM_PKG_SRCURL=https://github.com/nicm/fdm/releases/download/${NEOTERM_PKG_VERSION}/fdm-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=53aad117829834e21c1b9bf20496a1aa1c0e0fb98fe7735e1e73314266fb6c16
NEOTERM_PKG_DEPENDS="libandroid-glob, libtdb, openssl, pcre2, zlib"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--sysconfdir=$NEOTERM_PREFIX/etc
--localstatedir=$NEOTERM_PREFIX/var
--disable-static
--enable-pcre2
"

neoterm_step_pre_configure() {
	# Source distribution does not have separate license files
	for f in LICENSE LICENSE.BSD; do
		cp $NEOTERM_PKG_BUILDER_DIR/$f $NEOTERM_PKG_SRCDIR/
	done

	LDFLAGS+=" -landroid-glob"
}
