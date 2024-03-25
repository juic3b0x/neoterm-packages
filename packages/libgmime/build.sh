NEOTERM_PKG_HOMEPAGE=https://github.com/jstedfast/gmime
NEOTERM_PKG_DESCRIPTION="MIME message parser and creator"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="3.2.14"
NEOTERM_PKG_SRCURL=https://github.com/jstedfast/gmime/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=c834081b3a308e4bad809c381cb78f19dabaeee758e86d0a30a35490b5523a9e
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="glib, libiconv, libidn2, zlib"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner, valac"
NEOTERM_PKG_BREAKS="libgmime-dev"
NEOTERM_PKG_REPLACES="libgmime-dev"
NEOTERM_PKG_DISABLE_GIR=false
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_have_iconv_detect_h=yes
--with-libiconv=gnu
--disable-crypto
--enable-vala
"

neoterm_step_pre_configure() {
	NEOTERM_PKG_VERSION=. neoterm_setup_gir

	NOCONFIGURE=1 ./autogen.sh

	cp "$NEOTERM_PKG_BUILDER_DIR"/iconv-detect.h ./
}
