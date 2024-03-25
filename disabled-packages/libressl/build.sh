# Status: NeoTerm currently uses openssl. Transitioning to libressl
#	  is tempting, but on hold for now to see how widespread
#	  the adoption of libressl in Linux distributions is.
NEOTERM_PKG_HOMEPAGE=https://www.libressl.org/
NEOTERM_PKG_DESCRIPTION="Library implementing the TLS protocol as well as general purpose cryptography functions"
NEOTERM_PKG_LICENSE="OpenSSL, ISC"
NEOTERM_PKG_MAINTEINER="@neoterm"
NEOTERM_PKG_VERSION=2.5.5
NEOTERM_PKG_SRCURL=https://ftp.openbsd.org/pub/OpenBSD/LibreSSL/libressl-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=e57f5e3d5842a81fe9351b6e817fcaf0a749ca4ef35a91465edba9e071dce7c4
NEOTERM_PKG_DEPENDS="ca-certificates"
NEOTERM_PKG_CONFLICTS="openssl"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--with-openssldir=$NEOTERM_PREFIX/etc/tls"
# etc/tls/cert.pem is provided by ca-certificates:
NEOTERM_PKG_RM_AFTER_INSTALL="etc/tls/cert.pem"

neoterm_step_pre_configure() {
	CPPFLAGS+=" -DNO_SYSLOG"
}
