NEOTERM_PKG_HOMEPAGE=https://wiki.gnome.org/Projects/GtkSourceView
NEOTERM_PKG_DESCRIPTION="A GNOME library that extends GtkTextView"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
_MAJOR_VERSION=4.8
NEOTERM_PKG_VERSION=${_MAJOR_VERSION}.4
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://download.gnome.org/sources/gtksourceview/${_MAJOR_VERSION}/gtksourceview-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=7ec9d18fb283d1f84a3a3eff3b7a72b09a10c9c006597b3fbabbb5958420a87d
NEOTERM_PKG_DEPENDS="atk, fribidi, glib, gtk3, libcairo, libxml2, pango"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner"
NEOTERM_PKG_DISABLE_GIR=false
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dgir=true
-Dvapi=false
"

neoterm_step_pre_configure() {
	neoterm_setup_gir
}

neoterm_step_post_massage() {
	local _GUARD_FILE="lib/libgtksourceview-4.so"
	if [ ! -e "${_GUARD_FILE}" ]; then
		neoterm_error_exit "Error: file ${_GUARD_FILE} not found."
	fi
}
