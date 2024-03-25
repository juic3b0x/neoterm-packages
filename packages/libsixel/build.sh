NEOTERM_PKG_HOMEPAGE=https://saitoha.github.io/libsixel/
NEOTERM_PKG_DESCRIPTION="Encoder/decoder implementation for DEC SIXEL graphics"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.10.3
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://github.com/libsixel/libsixel/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=028552eb8f2a37c6effda88ee5e8f6d87b5d9601182ddec784a9728865f821e0
NEOTERM_PKG_DEPENDS="gdk-pixbuf, glib, libcurl, libgd, libjpeg-turbo, libpng"
NEOTERM_PKG_BREAKS="libsixel-dev"
NEOTERM_PKG_REPLACES="libsixel-dev"

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dgd=enabled
-Dgdk-pixbuf2=enabled
-Djpeg=enabled
-Dlibcurl=enabled
-Dpng=enabled
-Dpython2=disabled
"
