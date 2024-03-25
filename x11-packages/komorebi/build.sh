NEOTERM_PKG_HOMEPAGE=https://github.com/cheesecakeufo/komorebi
NEOTERM_PKG_DESCRIPTION="Animated Wallpapers for Linux"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.1
NEOTERM_PKG_SRCURL=https://github.com/cheesecakeufo/komorebi/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=66ee2fe21e16c3f9c18b824fa88a8b726812b1fdd81217cb53f7dad8d6dbae0f
NEOTERM_PKG_DEPENDS="clutter, clutter-gst, clutter-gtk, gdk-pixbuf, glib, gstreamer, gtk3, komorebi-data, libgee, webkit2gtk-4.1"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner, valac"

neoterm_step_post_get_source() {
	sed -i 's/\(webkit2gtk-4.\)0/\11/g' CMakeLists.txt
	find . -type f -name '*.vala' -o -name '*.desktop' | xargs -n 1 sed -i \
		"s:/System/Resources/Komorebi:${NEOTERM_PREFIX}/share/komorebi:g"
}

neoterm_step_pre_configure() {
	neoterm_setup_gir
}
