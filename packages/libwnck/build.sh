NEOTERM_PKG_HOMEPAGE=https://gitlab.gnome.org/GNOME/libwnck
NEOTERM_PKG_DESCRIPTION="Window Navigator Construction Kit"
NEOTERM_PKG_LICENSE="LGPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
_MAJOR_VERSION=43
NEOTERM_PKG_VERSION=${_MAJOR_VERSION}.0
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://ftp.gnome.org/pub/GNOME/sources/libwnck/${_MAJOR_VERSION}/libwnck-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=905bcdb85847d6b8f8861e56b30cd6dc61eae67ecef4cd994a9f925a26a2c1fe
NEOTERM_PKG_DEPENDS="atk, gdk-pixbuf, glib, gtk3, libcairo, libx11, libxrender, pango, startup-notification"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner"
NEOTERM_PKG_RM_AFTER_INSTALL="lib/locale"
NEOTERM_PKG_DISABLE_GIR=false
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dintrospection=enabled
"

neoterm_step_pre_configure() {
	neoterm_setup_gir
}
