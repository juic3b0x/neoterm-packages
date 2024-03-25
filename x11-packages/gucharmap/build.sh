NEOTERM_PKG_HOMEPAGE=https://wiki.gnome.org/Apps/Gucharmap
NEOTERM_PKG_DESCRIPTION="GTK+ Unicode Character Map"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="15.1.2"
NEOTERM_PKG_SRCURL=https://gitlab.gnome.org/GNOME/gucharmap/-/archive/${NEOTERM_PKG_VERSION}/gucharmap-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=f8580cb191d0a430513d0384b1f619a5eb8ad40dbd609d0c0f8370afa756c1fe
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="atk, glib, gtk3, libcairo, pango, pcre2, unicode-data"
NEOTERM_PKG_BUILD_DEPENDS="freetype, g-ir-scanner, glib-cross, valac"
NEOTERM_PKG_DISABLE_GIR=false
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Ducd_path=$NEOTERM_PREFIX/share/unicode-data
-Ddocs=false
-Dgir=true
-Dvapi=true
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
