NEOTERM_PKG_HOMEPAGE=http://links.twibright.com
NEOTERM_PKG_DESCRIPTION="Links is a text and graphics mode WWW browser"
# License: GPL-2.0-with-OpenSSL-exception
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.29
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=http://links.twibright.com/download/links-$NEOTERM_PKG_VERSION.tar.bz2
NEOTERM_PKG_SHA256=22aa96c0b38e1a6f8f7ed9d7a4167a47fc37246097759ef6059ecf8f9ead7998
NEOTERM_PKG_DEPENDS="brotli, fontconfig, freetype, glib, libbz2, libcairo, libevent, libjpeg-turbo, liblzma, libpng, librsvg, libtiff, libwebp, libx11, openssl, zlib, zstd"
NEOTERM_PKG_BUILD_DEPENDS="libxt"

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--mandir=$NEOTERM_PREFIX/share/man
--enable-graphics
--without-openmp
"
