NEOTERM_PKG_HOMEPAGE=https://sourceforge.net/projects/galculator/
NEOTERM_PKG_DESCRIPTION="GTK+ based scientific calculator"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.1.4
NEOTERM_PKG_REVISION=24
NEOTERM_PKG_SRCURL=http://galculator.mnim.org/downloads/galculator-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=01cfafe6606e7ec45facb708ef85efd6c1e8bb41001a999d28212a825ef778ae
NEOTERM_PKG_DEPENDS="atk, gdk-pixbuf, glib, gtk3, libcairo, pango"

neoterm_step_pre_configure() {
	CFLAGS+=" -fcommon"
}
