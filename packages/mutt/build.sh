NEOTERM_PKG_HOMEPAGE=http://www.mutt.org/
NEOTERM_PKG_DESCRIPTION="Mail client with patches from neomutt"
# License: GPL-2.0-or-later
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.2.13"
NEOTERM_PKG_SRCURL=ftp://ftp.mutt.org/pub/mutt/mutt-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=eb23faddc1cc97d867693f3a4a9f30949ad93765ad5b6fdae2797a4001c58efb
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libandroid-support, ncurses, gdbm, openssl, libsasl, media-types, zlib, libiconv"
NEOTERM_PKG_BUILD_IN_SRC=true

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
mutt_cv_c99_snprintf=yes
mutt_cv_c99_vsnprintf=yes
--disable-gpgme
--enable-compressed
--enable-debug
--enable-hcache
--enable-imap
--enable-pop
--enable-sidebar
--enable-smtp
--with-exec-shell=$NEOTERM_PREFIX/bin/sh
--with-mailpath=$NEOTERM_PREFIX/var/mail
--without-idn
--with-sasl
--with-ssl
"

# fget{c,s}_unlocked were added in API level 28.
# AC_CHECK_FUNCS(fget{c,s}_unlocked) finds them in libc, even though
# it is not defined in stdio.h, so we need to override the check or
# else compilation on device fails
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+="
ac_cv_func_fgetc_unlocked=no
ac_cv_func_fgets_unlocked=no
"

if $NEOTERM_DEBUG_BUILD; then
	export NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+="--enable-debug"
fi

NEOTERM_PKG_RM_AFTER_INSTALL="
bin/flea
bin/muttbug
share/man/man1/muttbug.1
share/man/man1/flea.1
etc/mime.types.dist
"

NEOTERM_PKG_CONFFILES="etc/Muttrc"

neoterm_step_post_configure() {
	# Build wants to run mutt_md5:
	gcc -DHAVE_STDINT_H -DMD5UTIL $NEOTERM_PKG_SRCDIR/md5.c -o $NEOTERM_PKG_BUILDDIR/mutt_md5
	touch -d "next hour" $NEOTERM_PKG_BUILDDIR/mutt_md5
}

neoterm_step_post_make_install() {
	cp doc/mutt.man $NEOTERM_PREFIX/share/man/man1/mutt.1.man
	mkdir -p $NEOTERM_PREFIX/share/examples/mutt/
	cp contrib/gpg.rc $NEOTERM_PREFIX/share/examples/mutt/
}
