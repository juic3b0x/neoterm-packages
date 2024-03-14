NEOTERM_PKG_HOMEPAGE=https://mailutils.org/
NEOTERM_PKG_DESCRIPTION="Mailutils is a swiss army knife of electronic mail handling. "
NEOTERM_PKG_LICENSE="LGPL-3.0, GPL-3.0"
NEOTERM_PKG_MAINTAINER="@suhan-paradkar"
NEOTERM_PKG_VERSION=3.16
NEOTERM_PKG_SRCURL=https://ftp.gnu.org/gnu/mailutils/mailutils-$NEOTERM_PKG_VERSION.tar.xz
NEOTERM_PKG_SHA256=041d158d308c0376184388e9c936cfa841a51cdc25d4db75984a771a3fa002c0
NEOTERM_PKG_DEPENDS="libandroid-glob, libcrypt, libiconv, libltdl, libunistring, ncurses, readline"
# Most of these configure arguments are for avoiding automagic dependencies.
# You may instead add dependencies properly and enable them.
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-python
--without-gssapi
--without-gnutls
--without-gdbm
--without-berkeley-db
--without-fribidi
--without-ldap
--without-guile
"

neoterm_step_pre_configure() {
	export LIBS="-landroid-glob"
}
