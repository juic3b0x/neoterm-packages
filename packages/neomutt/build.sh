NEOTERM_PKG_HOMEPAGE=https://neomutt.org/
NEOTERM_PKG_DESCRIPTION="A version of mutt with added features"
# License: GPL-2.0-or-later
NEOTERM_PKG_LICENSE="GPL-2.0, GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="20240201"
NEOTERM_PKG_SRCURL=https://github.com/neomutt/neomutt/archive/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=5229c4fdd6fd6ef870b94032bb1073f7f881ce97cf5754b1a4f4579a97b918da
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d{8}"
NEOTERM_PKG_DEPENDS="gdbm, krb5, libandroid-support, libiconv, libsasl, ncurses, notmuch, openssl, zlib, zstd"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_CONFFILES="etc/neomuttrc"

neoterm_step_configure() {
	./configure --host=$NEOTERM_HOST_PLATFORM \
		--sysroot=$NEOTERM_PREFIX \
		--prefix=$NEOTERM_PREFIX --with-mailpath=$NEOTERM_PREFIX/var/mail \
		--notmuch \
		--disable-gpgme --disable-idn --zlib --zstd --sasl --ssl --gdbm --gss
}
