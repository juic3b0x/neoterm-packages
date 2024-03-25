NEOTERM_PKG_HOMEPAGE=https://pngwriter.sourceforge.net
NEOTERM_PKG_DESCRIPTION="C++ library for creating PNG images"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.7.0
NEOTERM_PKG_SRCURL=https://github.com/pngwriter/pngwriter/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=82d46eef109f434f95eba9cf5908710ae4e75f575fd3858178ad06e800152825
NEOTERM_PKG_DEPENDS="zlib,freetype,libpng"
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_post_make_install() {
	mv "$NEOTERM_PREFIX"/lib/libPNGwriter_shared.so libPNGwriter.so
}
