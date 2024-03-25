NEOTERM_PKG_HOMEPAGE=https://telepathy.freedesktop.org/
NEOTERM_PKG_DESCRIPTION="GLib bindings for the Telepathy D-Bus protocol"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
# Do not bump to 0.99.x.
NEOTERM_PKG_VERSION=1:0.24.2
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://telepathy.freedesktop.org/releases/telepathy-glib/telepathy-glib-${NEOTERM_PKG_VERSION:2}.tar.gz
NEOTERM_PKG_SHA256=b0a374d771cdd081125f38c3abd079657642301c71a543d555e2bf21919273f0
NEOTERM_PKG_DEPENDS="dbus-glib, glib"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner"
NEOTERM_PKG_BREAKS="telepathy-glib-dev"
NEOTERM_PKG_REPLACES="telepathy-glib-dev"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_DISABLE_GIR=false
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--enable-introspection=yes
"

neoterm_step_pre_configure() {
	neoterm_setup_gir
}

neoterm_step_post_massage() {
	local _GUARD_FILES="lib/libtelepathy-glib.so"
	local f
	for f in ${_GUARD_FILES}; do
		 if [ ! -e "${f}" ]; then
			  neoterm_error_exit "Error: file ${f} not found."
		 fi
	done
}
