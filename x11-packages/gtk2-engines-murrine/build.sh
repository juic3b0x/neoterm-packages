NEOTERM_PKG_HOMEPAGE=https://download.gnome.org/sources/murrine/
NEOTERM_PKG_DESCRIPTION="Gtk +-2.0 theme engine based on cairo"
NEOTERM_PKG_LICENSE="LGPL-2.1, LGPL-3.0"
NEOTERM_PKG_MAINTAINER="Yisus7u7 <dev.yisus@hotmail.com>"
NEOTERM_PKG_VERSION=0.98.2
NEOTERM_PKG_REVISION=4
NEOTERM_PKG_SRCURL=http://deb.debian.org/debian/pool/main/g/gtk2-engines-murrine/gtk2-engines-murrine_${NEOTERM_PKG_VERSION}.orig.tar.xz
NEOTERM_PKG_SHA256=e9c68ae001b9130d0f9d1b311e8121a94e5c134b82553ba03971088e57d12c89
NEOTERM_PKG_DEPENDS="gdk-pixbuf, glib, gtk2, libcairo, libpixman, pango"

neoterm_step_pre_configure() {
	LDFLAGS+=" -lm"
}

neoterm_step_post_configure() {
	# Avoid overlinking
	sed -i 's/ -shared / -Wl,--as-needed\0/g' ./libtool
}
