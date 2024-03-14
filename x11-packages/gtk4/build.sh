NEOTERM_PKG_HOMEPAGE=https://www.gtk.org/
NEOTERM_PKG_DESCRIPTION="GObject-based multi-platform GUI toolkit"
NEOTERM_PKG_LICENSE="LGPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="4.12.4"
NEOTERM_PKG_SRCURL=https://download.gnome.org/sources/gtk/${NEOTERM_PKG_VERSION%.*}/gtk-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=ba67c6498e5599f928edafb9e08a320adfaa50ab2f0da6fc6ab2252fc2d57520
NEOTERM_PKG_DEPENDS="adwaita-icon-theme, fontconfig, fribidi, gdk-pixbuf, glib, glib-bin, graphene, gtk-update-icon-cache, harfbuzz, libcairo, libepoxy, libjpeg-turbo, libpng, libtiff, libwayland, libx11, libxcursor, libxdamage, libxext, libxfixes, libxi, libxinerama, libxkbcommon, libxrandr, pango, shared-mime-info"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner, glib-cross, libwayland-protocols, xorgproto"
NEOTERM_PKG_RECOMMENDS="desktop-file-utils, librsvg, ttf-dejavu"
NEOTERM_PKG_DISABLE_GIR=false
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dbuild-demos=false
-Dbuild-examples=false
-Dbuild-tests=false
-Dbuild-testsuite=false
-Dintrospection=enabled
-Dmedia-gstreamer=disabled
-Dprint-cups=disabled
-Dvulkan=disabled
-Dwayland-backend=true
"

neoterm_step_pre_configure() {
	neoterm_setup_cmake
	neoterm_setup_gir
	neoterm_setup_ninja

	local _WRAPPER_BIN="${NEOTERM_PKG_BUILDDIR}/_wrapper/bin"
	mkdir -p "${_WRAPPER_BIN}"
	if [[ "${NEOTERM_ON_DEVICE_BUILD}" == "false" ]]; then
		sed \
			-e "s|^export PKG_CONFIG_LIBDIR=|export PKG_CONFIG_LIBDIR=${NEOTERM_PREFIX}/opt/glib/cross/lib/x86_64-linux-gnu/pkgconfig:|" \
			-e "s|^export PKG_CONFIG_LIBDIR=|export PKG_CONFIG_LIBDIR=${NEOTERM_PREFIX}/opt/libwayland/cross/lib/x86_64-linux-gnu/pkgconfig:|" \
			"${NEOTERM_STANDALONE_TOOLCHAIN}/bin/pkg-config" \
			> "${_WRAPPER_BIN}/pkg-config"
		chmod +x "${_WRAPPER_BIN}/pkg-config"
		export PKG_CONFIG="${_WRAPPER_BIN}/pkg-config"
	fi
	export PATH="${_WRAPPER_BIN}:${PATH}"
}
