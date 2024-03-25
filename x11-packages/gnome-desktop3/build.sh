NEOTERM_PKG_HOMEPAGE=https://gitlab.gnome.org/GNOME/gnome-desktop
NEOTERM_PKG_DESCRIPTION="Utility library for loading .desktop files"
NEOTERM_PKG_LICENSE="GPL-2.0, LGPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
_MAJOR_VERSION=44
NEOTERM_PKG_VERSION=${_MAJOR_VERSION}.0
NEOTERM_PKG_SRCURL=https://download.gnome.org/sources/gnome-desktop/${_MAJOR_VERSION}/gnome-desktop-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=42c773745d84ba14bc1cf1c4c6f4606148803a5cd337941c63964795f3c59d42
NEOTERM_PKG_DEPENDS="gdk-pixbuf, glib, gsettings-desktop-schemas, gtk3, iso-codes, libcairo, libxkbcommon, xkeyboard-config"
NEOTERM_PKG_BUILD_DEPENDS="fontconfig, g-ir-scanner"
NEOTERM_PKG_DISABLE_GIR=false
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Ddesktop_docs=false
-Ddebug_tools=false
-Dintrospection=true
-Dbuild_gtk4=false
-Dlegacy_library=true
"

neoterm_step_pre_configure() {
	neoterm_setup_gir
}

neoterm_step_post_massage() {
	local _GUARD_FILE="lib/libgnome-desktop-3.so"
	if [ ! -e "${_GUARD_FILE}" ]; then
		neoterm_error_exit "Error: file ${_GUARD_FILE} not found."
	fi
}
