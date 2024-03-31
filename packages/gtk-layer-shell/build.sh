NEOTERM_PKG_HOMEPAGE=https://github.com/wmww/gtk-layer-shell
NEOTERM_PKG_DESCRIPTION="Library to create panels and other desktop components for Wayland using the Layer Shell protocol"
NEOTERM_PKG_LICENSE="LGPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.8.2"
NEOTERM_PKG_SRCURL=git+https://github.com/wmww/gtk-layer-shell
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="gtk3, libwayland"
NEOTERM_PKG_BUILD_DEPENDS="libwayland-cross-scanner, libwayland-protocols"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Ddocs=false
-Dintrospection=false
-Dtests=false
"

neoterm_step_pre_configure() {
	export PATH="$NEOTERM_PREFIX/opt/libwayland/cross/bin:$PATH"
}
