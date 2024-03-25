NEOTERM_PKG_HOMEPAGE=https://www.geany.org/
NEOTERM_PKG_DESCRIPTION="Fast and lightweight IDE"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.0"
NEOTERM_PKG_SRCURL=https://download.geany.org/geany-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=565b4cd2f0311c1e3a167ec71c4a32dba642e0fe554ae5bb6b8177b7a74ccc92
NEOTERM_PKG_AUTO_UPDATE=true
# libvte is dlopen(3)ed:
NEOTERM_PKG_DEPENDS="atk, gdk-pixbuf, glib, gtk3, harfbuzz, libandroid-glob, libc++, libcairo, libvte, pango"
NEOTERM_PKG_RECOMMENDS="clang, make"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--enable-gtk3 --enable-vte"

NEOTERM_PKG_RM_AFTER_INSTALL="
share/icons/Tango/icon-theme.cache
"

neoterm_step_pre_configure() {
	export LIBS="-landroid-glob $($CC -print-libgcc-file-name)"
}
