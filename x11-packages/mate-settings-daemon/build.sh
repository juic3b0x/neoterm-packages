NEOTERM_PKG_HOMEPAGE=https://mate-settings-daemon.mate-desktop.dev/
NEOTERM_PKG_DESCRIPTION="mate-settings-daemon is a fork of gnome-settings-daemon"
NEOTERM_PKG_LICENSE="GPL-2.0, LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.26.1
NEOTERM_PKG_SRCURL=https://github.com/mate-desktop/mate-settings-daemon/releases/download/v$NEOTERM_PKG_VERSION/mate-settings-daemon-$NEOTERM_PKG_VERSION.tar.xz
NEOTERM_PKG_SHA256=697ea65b542921c2b766145292d268d3009cc2da8316d2a7869869055e4b1859
NEOTERM_PKG_DEPENDS="atk, dbus, dbus-glib, dconf, fontconfig, freetype, gdk-pixbuf, glib, gtk3, harfbuzz, libcairo, libice, libmatekbd, libnotify, libsm, libx11, libxext, libxi, libxklavier, mate-desktop, pango, startup-notification, zlib"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--without-libcanberra
--without-libmatemixer
"
