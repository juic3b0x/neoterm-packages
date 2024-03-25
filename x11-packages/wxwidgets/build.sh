NEOTERM_PKG_HOMEPAGE=https://www.wxwidgets.org/
NEOTERM_PKG_DESCRIPTION="A free and open source cross-platform C++ framework for writing advanced GUI applications"
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="docs/gpl.txt, docs/lgpl.txt, docs/licence.txt, docs/licendoc.txt, docs/preamble.txt"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.2.2.1
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://github.com/wxWidgets/wxWidgets/releases/download/v${NEOTERM_PKG_VERSION}/wxWidgets-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=dffcb6be71296fff4b7f8840eb1b510178f57aa2eb236b20da41182009242c02
NEOTERM_PKG_DEPENDS="fontconfig, gdk-pixbuf, glib, glu, gtk3, libandroid-execinfo, libc++, libcairo, libcurl, libexpat, libiconv, libjpeg-turbo, libnotify, libpng, libsecret, libsm, libtiff, libx11, libxtst, libxxf86vm, opengl, pango, pcre2, sdl2, webkit2gtk-4.1, zlib"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-option-checking
--disable-mediactrl
--enable-webview
--with-sdl
ac_cv_header_langinfo_h=no
wx_cv_func_snprintf_pos_params=yes
"

neoterm_step_pre_configure() {
	sed -i 's/\(webkit2gtk-4\.\)0/\11/g' configure

	_WX_RELEASE=$(awk '/^WX_RELEASE =/ { print $3 }' "$NEOTERM_PKG_SRCDIR"/Makefile.in)
}

neoterm_step_post_make_install() {
	cp -fr "$NEOTERM_PKG_SRCDIR"/include/wx/android \
		$NEOTERM_PREFIX/include/wx-${_WX_RELEASE}/wx/android
}
