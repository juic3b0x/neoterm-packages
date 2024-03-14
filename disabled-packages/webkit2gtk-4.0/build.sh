# x11-packages
# This specific package is for webkit2gtk-4.0.
NEOTERM_PKG_HOMEPAGE=https://webkitgtk.org
NEOTERM_PKG_DESCRIPTION="A full-featured port of the WebKit rendering engine"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.38.1
NEOTERM_PKG_SRCURL=https://webkitgtk.org/releases/webkitgtk-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=02e195b3fb9e057743b3364ee7f1eec13f71614226849544c07c32a73b8f1848
NEOTERM_PKG_DEPENDS="atk, enchant, fontconfig, freetype, glib, gst-plugins-base, gst-plugins-good, gstreamer, gtk3, harfbuzz, harfbuzz-icu, libc++, libcairo, libgcrypt, libhyphen, libicu, libjpeg-turbo, libnotify, libpng, libsoup, libtasn1, libwebp, libxml2, libx11, libxcomposite, libxdamage, libxslt, libxt, littlecms, openjpeg, pango, woff2"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner, xorgproto"
#NEOTERM_PKG_PROVIDES="webkit2gtk-4.0"
NEOTERM_PKG_BREAKS="webkit, webkitgtk"
NEOTERM_PKG_REPLACES="webkit, webkitgtk"
NEOTERM_PKG_DISABLE_GIR=false

# USE_OPENGL_OR_ES causes crashes when enabled.
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DPORT=GTK
-DENABLE_GAMEPAD=OFF
-DUSE_SYSTEMD=OFF
-DUSE_LIBSECRET=OFF
-DENABLE_INTROSPECTION=ON
-DENABLE_DOCUMENTATION=OFF
-DUSE_WPE_RENDERER=OFF
-DENABLE_BUBBLEWRAP_SANDBOX=OFF
-DUSE_LD_GOLD=OFF
-DUSE_OPENGL_OR_ES=OFF
-DENABLE_JOURNALD_LOG=OFF
-DUSE_SOUP2=ON
-DUSE_GTK4=OFF
-DENABLE_WEBDRIVER=OFF
"
# WebKitWebDriver is provided by a subpackage of webkit2gtk-4.1 named
# webkit2gtk-driver.
NEOTERM_PKG_RM_AFTER_INSTALL="bin/WebKitWebDriver"

neoterm_step_pre_configure() {
	neoterm_setup_gir

	CPPFLAGS+=" -DHAVE_MISSING_STD_FILESYSTEM_PATH_CONSTRUCTOR"
	CPPFLAGS+=" -DCMS_NO_REGISTER_KEYWORD"
}

neoterm_step_post_massage() {
	local _GUARD_FILE="lib/lib${NEOTERM_PKG_NAME}-4.0.so"
	if [ ! -e "${_GUARD_FILE}" ]; then
		neoterm_error_exit "Error: file ${_GUARD_FILE} not found."
	fi
}
