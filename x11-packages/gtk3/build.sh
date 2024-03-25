NEOTERM_PKG_HOMEPAGE=https://www.gtk.org/
NEOTERM_PKG_DESCRIPTION="GObject-based multi-platform GUI toolkit"
NEOTERM_PKG_LICENSE="LGPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.24.38
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://gitlab.gnome.org/GNOME/gtk/-/archive/$NEOTERM_PKG_VERSION/gtk-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=6cdf7189322b8465745fbb30249044d05b792a8f006746ccce9213db671ec16d
NEOTERM_PKG_DEPENDS="adwaita-icon-theme, atk, coreutils, desktop-file-utils, fontconfig, fribidi, gdk-pixbuf, glib, glib-bin, gtk-update-icon-cache, harfbuzz, libcairo, libepoxy, libwayland, libxcomposite, libxcursor, libxdamage, libxfixes, libxi, libxinerama, libxkbcommon, libxrandr, pango, shared-mime-info, ttf-dejavu"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner, glib-cross, libwayland-protocols, xorgproto"
NEOTERM_PKG_CONFLICTS="libgtk3"
NEOTERM_PKG_REPLACES="libgtk3"
NEOTERM_PKG_DISABLE_GIR=false
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dbroadway_backend=true
-Dintrospection=true
-Dman=true
-Dprint_backends=file,lpr
-Dwayland_backend=true
-Dx11_backend=true
-Dxinerama=yes
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

neoterm_step_create_debscripts() {
	for i in postinst postrm triggers; do
		sed \
			"s|@NEOTERM_PREFIX@|${NEOTERM_PREFIX}|g" \
			"${NEOTERM_PKG_BUILDER_DIR}/hooks/${i}.in" > ./${i}
		chmod 755 ./${i}
	done
	unset i
	chmod 644 ./triggers
}
