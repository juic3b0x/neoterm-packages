NEOTERM_PKG_HOMEPAGE="https://www.cups.org/"
NEOTERM_PKG_DESCRIPTION="Common UNIX Printing System"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.4.7"
NEOTERM_PKG_SRCURL=https://github.com/OpenPrinting/cups/releases/download/v${NEOTERM_PKG_VERSION}/cups-${NEOTERM_PKG_VERSION}-source.tar.gz
NEOTERM_PKG_SHA256=dd54228dd903526428ce7e37961afaed230ad310788141da75cebaa08362cf6c
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libc++, libcrypt, libgnutls, libiconv, zlib"
NEOTERM_PKG_BUILD_DEPENDS="libandroid-spawn"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--with-tls=gnutls
"
NEOTERM_PKG_CONFFILES="
etc/cups/cups-files.conf
etc/cups/cupsd.conf
etc/cups/snmp.conf
"

NEOTERM_PKG_SERVICE_SCRIPT=("cupsd" "mkdir -p $NEOTERM_PREFIX/var/run/cups && exec cupsd -f")

neoterm_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!${NEOTERM_PREFIX}/bin/sh
	mkdir -p $NEOTERM_PREFIX/var/run/cups
	EOF
}
