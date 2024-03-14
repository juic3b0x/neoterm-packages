NEOTERM_PKG_HOMEPAGE=https://github.com/orhun/kermit
NEOTERM_PKG_DESCRIPTION="A VTE-based simple and froggy terminal emulator"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@AnGelXoG"
NEOTERM_PKG_VERSION=3.8
NEOTERM_PKG_SRCURL=https://github.com/orhun/kermit/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=7b2ad85f73bccee4f6d890693afae2002ca2c51965b83c42e1ca4f4d980468c8
NEOTERM_PKG_DEPENDS="glib, gtk3, libvte, pango"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin ./kermit
}
