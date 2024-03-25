NEOTERM_PKG_HOMEPAGE=https://wiki.gnome.org/Projects/GtkSourceView
NEOTERM_PKG_DESCRIPTION="C++ binding for gtksourceview"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
_MAJOR_VERSION=3.21
NEOTERM_PKG_VERSION=${_MAJOR_VERSION}.3
NEOTERM_PKG_SRCURL=https://download.gnome.org/sources/gtksourceviewmm/${_MAJOR_VERSION}/gtksourceviewmm-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=dbb00b1c28e0407cc27d8b07a2ed0b4ea22f92e4b3e3006431cbd6726b6256b5
NEOTERM_PKG_DEPENDS="atk, gdk-pixbuf, glib, gtk3, gtkmm3, gtksourceview3, harfbuzz, libatkmm-1.6, libc++, libcairo, libcairomm-1.0, libglibmm-2.4, libpangomm-1.4, libsigc++-2.0, pango, zlib"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-documentation
"

neoterm_step_pre_configure() {
	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}

neoterm_step_post_massage() {
	local _GUARD_FILE="lib/${NEOTERM_PKG_NAME}.so"
	if [ ! -e "${_GUARD_FILE}" ]; then
		neoterm_error_exit "Error: file ${_GUARD_FILE} not found."
	fi
}
