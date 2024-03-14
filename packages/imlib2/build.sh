NEOTERM_PKG_HOMEPAGE=https://sourceforge.net/projects/enlightenment/
NEOTERM_PKG_DESCRIPTION="Library that does image file loading and saving as well as rendering, manipulation, arbitrary polygon support"
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="COPYING, COPYING-PLAIN"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.12.2"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/enlightenment/imlib2-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=cc49931a20560968a8648c9ca079085976085ea96d59a01b1e17cb55af0ffe42
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="freetype, gdk-pixbuf, giflib, glib, libandroid-shmem, libbz2, libcairo, libheif, libid3tag, libjpeg-turbo, libjxl, liblzma, libpng, librsvg, libtiff, libwebp, libx11, libxcb, libxext, openjpeg, zlib"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="LIBS=-landroid-shmem"
