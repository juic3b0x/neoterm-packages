NEOTERM_PKG_HOMEPAGE=http://tarot.freeshell.org/leafpad/
NEOTERM_PKG_DESCRIPTION="GTK+ based simple text editor"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.8.19
NEOTERM_PKG_SRCURL=http://download.savannah.gnu.org/releases/leafpad/leafpad-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=07d3f712f4dbd0a33251fd1dee14e21afdc9f92090fc768c11ab0ac556adbe97
NEOTERM_PKG_DEPENDS="glib, gtk2, libcairo, pango"
NEOTERM_PKG_RM_AFTER_INSTALL="
lib/locale
"
