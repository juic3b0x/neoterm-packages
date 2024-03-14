NEOTERM_PKG_HOMEPAGE=https://marco.mate-desktop.dev/
NEOTERM_PKG_DESCRIPTION="MATE default window manager"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.26.2
NEOTERM_PKG_SRCURL=https://github.com/mate-desktop/marco/releases/download/v$NEOTERM_PKG_VERSION/marco-$NEOTERM_PKG_VERSION.tar.xz
NEOTERM_PKG_SHA256=12f1a254fe1072f0304884711e089a5682780a011593402ed38de6b9480e07a3
NEOTERM_PKG_DEPENDS="atk, gdk-pixbuf, glib, gtk3, harfbuzz, libcairo, libcanberra, libice, libsm, libx11, libxcomposite, libxcursor, libxdamage, libxext, libxfixes, libxinerama, libxrandr, libxrender, libxres, mate-desktop, pango, startup-notification, zenity, zlib"

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
ZENITY=${NEOTERM_PREFIX}/bin/zenity
"
