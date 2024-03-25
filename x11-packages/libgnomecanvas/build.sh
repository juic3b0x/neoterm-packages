NEOTERM_PKG_HOMEPAGE=https://www.gnome.org/
NEOTERM_PKG_DESCRIPTION="The GNOME Canvas library"
NEOTERM_PKG_LICENSE="LGPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.30.3
NEOTERM_PKG_REVISION=21
NEOTERM_PKG_SRCURL=https://download.gnome.org/sources/libgnomecanvas/2.30/libgnomecanvas-$NEOTERM_PKG_VERSION.tar.bz2
NEOTERM_PKG_SHA256=859b78e08489fce4d5c15c676fec1cd79782f115f516e8ad8bed6abcb8dedd40
NEOTERM_PKG_DEPENDS="atk, glib, gtk2, libart-lgpl, libglade, pango"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--enable-glade"
NEOTERM_PKG_RM_AFTER_INSTALL="lib/locale"

neoterm_step_post_configure() {
	sed -i -e 's/ -shared / -Wl,-O1,--as-needed\0/g' libtool
}
