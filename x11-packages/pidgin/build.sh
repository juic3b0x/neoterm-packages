NEOTERM_PKG_HOMEPAGE=https://pidgin.im/
NEOTERM_PKG_DESCRIPTION="Multi-protocol instant messaging client"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.14.12
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/pidgin/pidgin-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=2b05246be208605edbb93ae9edc079583d449e2a9710db6d348d17f59020a4b7
NEOTERM_PKG_DEPENDS="atk, dbus, dbus-glib, fontconfig, freetype, gdk-pixbuf, glib, gstreamer, gtk2, harfbuzz, libcairo, libgnt, libgnutls, libice, libidn, libsasl, libsm, libx11, libxcomposite, libxcursor, libxdamage, libxext, libxfixes, libxinerama, libxml2, libxrandr, libxrender, libxss, ncurses, pango, tcl"

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-gevolution
--disable-gtkspell
--disable-vv
--disable-meanwhile
--disable-avahi
--disable-perl
--disable-nm
"
