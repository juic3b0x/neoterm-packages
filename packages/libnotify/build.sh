NEOTERM_PKG_HOMEPAGE=https://developer.gnome.org/notification-spec/
NEOTERM_PKG_DESCRIPTION="Library for sending desktop notifications"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.8.3"
NEOTERM_PKG_SRCURL=https://ftp.gnome.org/pub/GNOME/sources/libnotify/${NEOTERM_PKG_VERSION%.*}/libnotify-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=ee8f3ef946156ad3406fdf45feedbdcd932dbd211ab4f16f75eba4f36fb2f6c0
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="gdk-pixbuf, glib"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner"
NEOTERM_PKG_DISABLE_GIR=false
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dtests=false
-Dintrospection=enabled
-Dgtk_doc=false"

neoterm_step_pre_configure() {
	NEOTERM_PKG_VERSION=. neoterm_setup_gir

	if [ "$NEOTERM_ON_DEVICE_BUILD" = "false" ]; then
		# Pre-installed headers affect GIR generation:
		rm -rf "$NEOTERM_PREFIX/include/libnotify"
	fi
}
