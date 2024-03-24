TERMUX_PKG_HOMEPAGE=https://github.com/jstedfast/gmime
TERMUX_PKG_DESCRIPTION="MIME message parser and creator"
TERMUX_PKG_LICENSE="LGPL-2.1"
TERMUX_PKG_MAINTAINER="@neoterm"
TERMUX_PKG_VERSION="3.2.14"
TERMUX_PKG_SRCURL=https://github.com/jstedfast/gmime/archive/refs/tags/${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=c834081b3a308e4bad809c381cb78f19dabaeee758e86d0a30a35490b5523a9e
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="glib, libiconv, libidn2, zlib"
TERMUX_PKG_BUILD_DEPENDS="g-ir-scanner, valac"
TERMUX_PKG_BREAKS="libgmime-dev"
TERMUX_PKG_REPLACES="libgmime-dev"
TERMUX_PKG_DISABLE_GIR=false
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_have_iconv_detect_h=yes
--with-libiconv=gnu
--disable-crypto
--enable-vala
"

termux_step_pre_configure() {
	TERMUX_PKG_VERSION=. termux_setup_gir

	NOCONFIGURE=1 ./autogen.sh

	cp "$TERMUX_PKG_BUILDER_DIR"/iconv-detect.h ./
}
