NEOTERM_PKG_HOMEPAGE=https://wiki.gnome.org/action/show/Projects/libsoup
NEOTERM_PKG_DESCRIPTION="HTTP client and server library"
NEOTERM_PKG_LICENSE="LGPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
# This specific package is for libsoup-2.4.
# libsoup-3.0 is packaged as libsoup3.
NEOTERM_PKG_VERSION=2.74.3
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://download.gnome.org/sources/libsoup/${NEOTERM_PKG_VERSION%.*}/libsoup-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=e4b77c41cfc4c8c5a035fcdc320c7bc6cfb75ef7c5a034153df1413fa1d92f13
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_DEPENDS="brotli, glib, libpsl, libsqlite, libxml2, zlib"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner"
NEOTERM_PKG_RECOMMENDS="glib-networking"
NEOTERM_PKG_BREAKS="libsoup-dev"
NEOTERM_PKG_REPLACES="libsoup-dev"
NEOTERM_PKG_DISABLE_GIR=false
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dintrospection=enabled
-Dvapi=enabled
-Dgssapi=disabled
-Dtls_check=false
-Dsysprof=disabled
"

neoterm_step_pre_configure() {
	neoterm_setup_gir
}

neoterm_step_post_massage() {
	local _GUARD_FILE="lib/libsoup-2.4.so"
	if [ ! -e "${_GUARD_FILE}" ]; then
		neoterm_error_exit "Error: file ${_GUARD_FILE} not found."
	fi
}
