NEOTERM_PKG_HOMEPAGE=https://bluefish.openoffice.nl/
NEOTERM_PKG_DESCRIPTION="A powerful editor targeted towards programmers and webdevelopers"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.2.14"
NEOTERM_PKG_SRCURL=https://www.bennewitz.com/bluefish/stable/source/bluefish-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=22ccdf9ce4e5c9621063e6cf7d73abfb0736ab7a72bce086d06c5cf5ee125ede
NEOTERM_PKG_DEPENDS="atk, enchant, gdk-pixbuf, glib, gtk3, harfbuzz, libcairo, libxml2, pango, zlib"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-xml-catalog-update
--disable-update-databases
--disable-python
--disable-gettext
"

neoterm_step_pre_configure() {
	CFLAGS+=" -fPIC -Dgettext\(a\)=a"
}
