NEOTERM_PKG_HOMEPAGE=http://www.graphicsmagick.org/
NEOTERM_PKG_DESCRIPTION="Collection of image processing tools"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.3.42"
# Bandwith limited on main ftp site, so it's asked to use sourceforge instead:
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/project/graphicsmagick/graphicsmagick/${NEOTERM_PKG_VERSION}/GraphicsMagick-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=484fccfd2b2faf6c2ba9151469ece5072bcb91ba4ed73e75ed3d8e46c759d557
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="freetype, libbz2, libc++, libde265, libheif, libjasper, libjpeg-turbo, liblzma, libpng, libtiff, libwebp, libxml2, littlecms, zlib, zstd"
NEOTERM_PKG_BREAKS="graphicsmagick-dev"
NEOTERM_PKG_REPLACES="graphicsmagick++, graphicsmagick-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_func_ftime=no
--with-fontpath=/system/fonts
--without-x
"
