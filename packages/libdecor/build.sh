NEOTERM_PKG_HOMEPAGE=https://gitlab.freedesktop.org/libdecor/libdecor
NEOTERM_PKG_DESCRIPTION="Client-side decorations library for Wayland clients"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.2.2"
NEOTERM_PKG_SRCURL=https://gitlab.freedesktop.org/libdecor/libdecor/-/archive/${NEOTERM_PKG_VERSION}/libdecor-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=40a1d8be07d8b1f66e8fb98a1f4a84549ca6bf992407198a5055952be80a8525
NEOTERM_PKG_DEPENDS="dbus, glib, gtk3, libcairo, libwayland, libxkbcommon, pango"
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Ddemo=false
-Ddbus=enabled
-Dinstall_demo=false
-Dgtk=enabled
"
