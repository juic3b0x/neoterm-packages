NEOTERM_PKG_HOMEPAGE=https://ugetdm.com/
NEOTERM_PKG_DESCRIPTION="GTK+ download manager featuring download classification and HTML import"
NEOTERM_PKG_LICENSE="LGPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.2.3
NEOTERM_PKG_REVISION=22
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/urlget/uget-${NEOTERM_PKG_VERSION}-1.tar.gz
NEOTERM_PKG_SHA256=11356e4242151b9014fa6209c1f0360b699b72ef8ab47dbeb81cc23be7db9049
NEOTERM_PKG_DEPENDS="atk, gdk-pixbuf, glib, gstreamer, gtk3, libcairo, libcurl, libnotify, openssl, pango"
NEOTERM_PKG_SUGGESTS="aria2"
NEOTERM_PKG_RM_AFTER_INSTALL="lib/locale"

neoterm_step_pre_configure() {
	CFLAGS+=" -fcommon"
}

neoterm_step_post_make_install() {
	ln -sfr "${NEOTERM_PREFIX}/bin/uget-gtk" "${NEOTERM_PREFIX}/bin/uget"
}
