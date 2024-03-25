NEOTERM_PKG_HOMEPAGE=https://wiki.gnome.org/Apps/FileRoller
NEOTERM_PKG_DESCRIPTION="File Roller is an archive manager for the GNOME desktop environment."
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="43.1"
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://download.gnome.org/sources/file-roller/${NEOTERM_PKG_VERSION%.*}/file-roller-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=84994023997293beb345d9793db8f5f0bbb41faa155c6ffb48328f203957ad08
NEOTERM_PKG_DEPENDS="gdk-pixbuf, glib, gtk3, json-glib, libarchive, libcairo, libhandy, pango"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner, glib-cross"
NEOTERM_PKG_RECOMMENDS="arj, brotli, bsdtar, bzip2, cpio, gzip, lz4, lzip, lzop, p7zip, tar, unrar, unzip, xz-utils, zip, zstd"
NEOTERM_PKG_DISABLE_GIR=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Duse_native_appchooser=false
-Dcpio=$NEOTERM_PREFIX/bin/cpio
-Dintrospection=enabled
"

neoterm_step_pre_configure() {
	neoterm_setup_gir

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
