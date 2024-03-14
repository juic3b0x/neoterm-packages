NEOTERM_PKG_HOMEPAGE=https://libvips.github.io/libvips/
NEOTERM_PKG_DESCRIPTION="A fast image processing library with low memory needs"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="Thibault Meyer <meyer.thibault@gmail.com>"
NEOTERM_PKG_VERSION="8.15.1"
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://github.com/libvips/libvips/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=5701445a076465a3402a135d13c0660d909beb8efc4f00fbbe82392e243497f2
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="cgif, fftw, fontconfig, glib, imagemagick, libc++, libcairo, libexif, libexpat, libheif, libimagequant, libjpeg-turbo, libjxl, libpng, librsvg, libtiff, libwebp, littlecms, openexr, openjpeg, pango, poppler, zlib"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner, glib-cross, valac"
NEOTERM_PKG_DISABLE_GIR=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dintrospection=enabled
-Dvapi=true
-Dorc=disabled
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
