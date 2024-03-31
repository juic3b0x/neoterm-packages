NEOTERM_PKG_HOMEPAGE=https://github.com/sunnyone/loqui
NEOTERM_PKG_DESCRIPTION="IRC client for Gtk environment"
NEOTERM_PKG_LICENSE="LGPL-2.0, GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.7.0
NEOTERM_PKG_SRCURL=https://github.com/sunnyone/loqui/releases/download/${NEOTERM_PKG_VERSION}/loqui-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=c593211d6bb477d5477ec9b81143e3faf96e859ad2edaf527fbc370333e5e0e7
NEOTERM_PKG_DEPENDS="gdk-pixbuf, glib, gtk3, pango"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
GLIB_GENMARSHAL=glib-genmarshal
--disable-glibtestr
--disable-gtktest
"
NEOTERM_PKG_RM_AFTER_INSTALL="lib/locale"

neoterm_step_pre_configure() {
	CFLAGS+=" -Wno-error=return-type"
}
