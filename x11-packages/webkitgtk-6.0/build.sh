NEOTERM_PKG_HOMEPAGE=https://webkitgtk.org
NEOTERM_PKG_DESCRIPTION="A full-featured port of the WebKit rendering engine"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.40.3
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://webkitgtk.org/releases/webkitgtk-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=cc0aa83f40dbc64c1c6ae42ec6b85af4be2a9dbf524cfcb95f89a367fb5098dd
NEOTERM_PKG_DEPENDS="enchant, fontconfig, freetype, glib, gst-plugins-bad, gst-plugins-base, gst-plugins-good, gstreamer, gtk4, harfbuzz, harfbuzz-icu, libc++, libcairo, libgcrypt, libhyphen, libicu, libjpeg-turbo, libpng, libsoup3, libtasn1, libwebp, libxml2, libx11, libxcomposite, libxdamage, libxslt, libxt, littlecms, openjpeg, pango, woff2, zlib"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner, xorgproto"
NEOTERM_PKG_DISABLE_GIR=false

neoterm_step_post_get_source() {
	local p
	for p in $NEOTERM_SCRIPTDIR/x11-packages/webkit2gtk-4.1/*.patch; do
		echo "Applying $(basename "${p}")"
		sed "s|@NEOTERM_PREFIX@|${NEOTERM_PREFIX}|g" "${p}" \
			| patch --silent -p1
	done
}

neoterm_step_pre_configure() {
	NEOTERM_PKG_EXTRA_CONFIGURE_ARGS=$(
		. $NEOTERM_SCRIPTDIR/x11-packages/webkit2gtk-4.1/build.sh
		echo $NEOTERM_PKG_EXTRA_CONFIGURE_ARGS
	)
	NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+="
		-DUSE_GTK4=ON
		-DENABLE_WEBDRIVER=OFF
	"

	neoterm_setup_gir

	CPPFLAGS+=" -DHAVE_MISSING_STD_FILESYSTEM_PATH_CONSTRUCTOR"
	CPPFLAGS+=" -DCMS_NO_REGISTER_KEYWORD"
}

neoterm_step_post_massage() {
	local _GUARD_FILE="lib/lib${NEOTERM_PKG_NAME}.so"
	if [ ! -e "${_GUARD_FILE}" ]; then
		neoterm_error_exit "Error: file ${_GUARD_FILE} not found."
	fi
}
