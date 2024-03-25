NEOTERM_PKG_HOMEPAGE=https://www.gnupg.org/related_software/pinentry/index.html
NEOTERM_PKG_DESCRIPTION="Dialog allowing secure password entry (with gtk2 support)"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.2.1
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://www.gnupg.org/ftp/gcrypt/pinentry/pinentry-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=457a185e5a85238fb945a955dc6352ab962dc8b48720b62fc9fa48c7540a4067
NEOTERM_PKG_DEPENDS="glib, gtk2, libandroid-support, libassuan, libgpg-error, libiconv, ncurses"

NEOTERM_PKG_CONFLICTS="pinentry"
NEOTERM_PKG_REPLACES="pinentry"
NEOTERM_PKG_PROVIDES="pinentry"

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-pinentry-fltk
--disable-pinentry-qt5
--enable-pinentry-gtk2
--enable-pinentry-tty
--without-libcap
"
