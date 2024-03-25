NEOTERM_PKG_HOMEPAGE=https://www.cipherdyne.org/fwknop/
NEOTERM_PKG_DESCRIPTION="fwknop: Single Packet Authorization > Port Knocking"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.6.10
NEOTERM_PKG_REVISION=5
NEOTERM_PKG_SRCURL=https://www.cipherdyne.org/fwknop/download/fwknop-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=f6c09bec97ed8e474a98ae14f9f53e1bcdda33393f20667b6af3fb6bb894ca77
NEOTERM_PKG_DEPENDS="gpgme"
NEOTERM_PKG_BREAKS="fwknop-dev"
NEOTERM_PKG_REPLACES="fwknop-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-server
--with-gpgme
--with-gpg=$NEOTERM_PREFIX/bin/gpg2
"

neoterm_step_post_configure() {
	# Avoid overlinking
	sed -i 's/ -shared / -Wl,--as-needed\0/g' ./libtool
}
