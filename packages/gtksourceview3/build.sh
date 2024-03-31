NEOTERM_PKG_HOMEPAGE=https://wiki.gnome.org/Projects/GtkSourceView
NEOTERM_PKG_DESCRIPTION="A GNOME library that extends GtkTextView"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
_MAJOR_VERSION=3.24
NEOTERM_PKG_VERSION=${_MAJOR_VERSION}.11
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://download.gnome.org/sources/gtksourceview/${_MAJOR_VERSION}/gtksourceview-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=691b074a37b2a307f7f48edc5b8c7afa7301709be56378ccf9cc9735909077fd
NEOTERM_PKG_DEPENDS="atk, gdk-pixbuf, glib, gtk3, harfbuzz, libcairo, libxml2, pango, zlib"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner, valac"
NEOTERM_PKG_DISABLE_GIR=false
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--enable-introspection=yes
--enable-vala=yes
"

neoterm_step_pre_configure() {
	neoterm_setup_gir
}

neoterm_step_post_massage() {
	local _GUARD_FILE="lib/libgtksourceview-3.0.so"
	if [ ! -e "${_GUARD_FILE}" ]; then
		neoterm_error_exit "Error: file ${_GUARD_FILE} not found."
	fi
}
