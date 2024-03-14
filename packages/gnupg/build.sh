NEOTERM_PKG_HOMEPAGE=https://www.gnupg.org/
NEOTERM_PKG_DESCRIPTION="Implementation of the OpenPGP standard for encrypting and signing data and communication"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.4.4
NEOTERM_PKG_SRCURL=https://www.gnupg.org/ftp/gcrypt/gnupg/gnupg-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=67ebe016ca90fa7688ce67a387ebd82c6261e95897db7b23df24ff335be85bc6
NEOTERM_PKG_DEPENDS="libassuan, libbz2, libgcrypt, libgnutls, libgpg-error, libksba, libnpth, libsqlite, readline, pinentry, resolv-conf, zlib"
NEOTERM_PKG_CONFLICTS="gnupg2 (<< 2.2.9-1), dirmngr (<< 2.2.17-1)"
NEOTERM_PKG_REPLACES="gnupg2 (<< 2.2.9-1), dirmngr (<< 2.2.17-1)"
NEOTERM_PKG_SUGGESTS="scdaemon"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-ldap
--enable-sqlite
--enable-tofu
"
# Remove non-english help files and man pages shipped with the gnupg (1) package:
NEOTERM_PKG_RM_AFTER_INSTALL="share/gnupg/help.*.txt share/man/man1/gpg-zip.1 share/man/man7/gnupg.7"

neoterm_step_pre_configure() {
	CPPFLAGS+=" -Ddn_skipname=__dn_skipname"
}

neoterm_step_post_make_install() {
	cd $NEOTERM_PREFIX/bin
	ln -sf gpg gpg2
}
