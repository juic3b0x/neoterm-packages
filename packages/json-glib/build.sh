NEOTERM_PKG_HOMEPAGE=https://wiki.gnome.org/Projects/JsonGlib
NEOTERM_PKG_DESCRIPTION="GLib JSON manipulation library"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.8.0"
NEOTERM_PKG_SRCURL=https://ftp.gnome.org/pub/GNOME/sources/json-glib/${NEOTERM_PKG_VERSION%.*}/json-glib-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=97ef5eb92ca811039ad50a65f06633f1aae64792789307be7170795d8b319454
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="glib"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner"
NEOTERM_PKG_BREAKS="json-glib-dev"
NEOTERM_PKG_REPLACES="json-glib-dev"
NEOTERM_PKG_DISABLE_GIR=false
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dintrospection=enabled
-Dgtk_doc=disabled
"
NEOTERM_PKG_RM_AFTER_INSTALL="
share/installed-tests
libexec/installed-tests
bin/
"

neoterm_step_pre_configure() {
	NEOTERM_PKG_VERSION=. neoterm_setup_gir
}
