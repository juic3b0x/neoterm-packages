NEOTERM_PKG_HOMEPAGE=https://wiki.gnome.org/Apps/Ghex
NEOTERM_PKG_DESCRIPTION="A simple binary editor for the Gnome desktop."
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="45.1"
NEOTERM_PKG_SRCURL=https://ftp.gnome.org/pub/GNOME/sources/ghex/${NEOTERM_PKG_VERSION%.*}/ghex-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=fb2b0823cd16249edbeaee8302f9bd5005e0150368b35f1e47c26680cacac2fa
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="glib, gtk4, libadwaita, libcairo, pango"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner, glib-cross"
NEOTERM_PKG_DISABLE_GIR=false
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dintrospection=enabled
"

neoterm_step_pre_configure() {
	NEOTERM_PKG_VERSION=. neoterm_setup_gir

	local _WRAPPER_BIN="${NEOTERM_PKG_BUILDDIR}/_wrapper/bin"
	mkdir -p "${_WRAPPER_BIN}"
	if [[ "${NEOTERM_ON_DEVICE_BUILD}" == "false" ]]; then
		sed "s|^export PKG_CONFIG_LIBDIR=|export PKG_CONFIG_LIBDIR=${NEOTERM_PREFIX}/opt/glib/cross/lib/x86_64-linux-gnu/pkgconfig:|" \
			"${NEOTERM_STANDALONE_TOOLCHAIN}/bin/pkg-config" \
			> "${_WRAPPER_BIN}/pkg-config"
		chmod +x "${_WRAPPER_BIN}/pkg-config"
		export PKG_CONFIG="${_WRAPPER_BIN}/pkg-config"
	fi
	export PATH="${_WRAPPER_BIN}:${PATH}"
}
