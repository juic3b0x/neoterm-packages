NEOTERM_PKG_HOMEPAGE=https://wiki.gnome.org/Projects/libsoup
NEOTERM_PKG_DESCRIPTION="HTTP client and server library"
NEOTERM_PKG_LICENSE="LGPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="3.4.4"
NEOTERM_PKG_SRCURL=https://download.gnome.org/sources/libsoup/${NEOTERM_PKG_VERSION%.*}/libsoup-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=291c67725f36ed90ea43efff25064b69c5a2d1981488477c05c481a3b4b0c5aa
NEOTERM_PKG_DEPENDS="brotli, glib, libnghttp2, libpsl, libsqlite, zlib"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner, glib-cross"
NEOTERM_PKG_RECOMMENDS="glib-networking"
NEOTERM_PKG_DISABLE_GIR=false
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dintrospection=enabled
-Dvapi=enabled
-Ddocs=disabled
-Dgssapi=disabled
-Dtests=false
-Dtls_check=false
-Dsysprof=disabled
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

neoterm_step_post_massage() {
	local _GUARD_FILE="lib/libsoup-3.0.so"
	if [ ! -e "${_GUARD_FILE}" ]; then
		neoterm_error_exit "Error: file ${_GUARD_FILE} not found."
	fi
}
