NEOTERM_PKG_HOMEPAGE=https://pidgin.im/
NEOTERM_PKG_DESCRIPTION="Text-based multi-protocol instant messaging client"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.14.12
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/pidgin/pidgin-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=2b05246be208605edbb93ae9edc079583d449e2a9710db6d348d17f59020a4b7
NEOTERM_PKG_DEPENDS="glib, libgnt, libgnutls, libidn, libsasl, libxml2, ncurses, ncurses-ui-libs"
NEOTERM_PKG_BREAKS="finch-dev"
NEOTERM_PKG_REPLACES="finch-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-gtkui
--disable-gstreamer
--disable-vv
--disable-idn
--disable-meanwhile
--disable-avahi
--disable-dbus
--disable-perl
--disable-tcl
--without-zephyr
--with-ncurses-headers=$NEOTERM_PREFIX/include
--without-python3
"
NEOTERM_PKG_RM_AFTER_INSTALL="share/sounds/purple lib/purple-2/libmsn.so"

neoterm_step_pre_configure() {
	# For arpa:
	CFLAGS+=" -isystem $NEOTERM_PKG_BUILDER_DIR"
}

neoterm_step_post_configure() {
	# Hack to compile first version of libpurple-ciphers.la
	cp $NEOTERM_PREFIX/lib/libxml2.so $NEOTERM_PREFIX/lib/libpurple.so

	cd $NEOTERM_PKG_BUILDDIR/libpurple/ciphers
	make libpurple-ciphers.la
	cd ..
	make libpurple.la

	# Put a more proper version in lib:
	cp .libs/libpurple.so $NEOTERM_PREFIX/lib/

	make clean
}

neoterm_step_post_make_install() {
	cd $NEOTERM_PREFIX/lib
	for lib in jabber oscar; do
		ln -f -s purple-2/lib${lib}.so .
	done
}
