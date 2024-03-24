TERMUX_PKG_HOMEPAGE=http://www.simplesystems.org/libtiff/ # Note that http://libtiff.org/ is hijacked
TERMUX_PKG_DESCRIPTION="Support for the Tag Image File Format (TIFF) for storing image data"
TERMUX_PKG_LICENSE="custom"
TERMUX_PKG_LICENSE_FILE="LICENSE.md"
TERMUX_PKG_MAINTAINER="@neoterm"
TERMUX_PKG_VERSION="4.6.0"
TERMUX_PKG_SRCURL=https://download.osgeo.org/libtiff/tiff-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=e178649607d1e22b51cf361dd20a3753f244f022eefab1f2f218fc62ebaf87d2
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="libc++, libjpeg-turbo, liblzma, zlib, zstd"
TERMUX_PKG_BREAKS="libtiff-dev"
TERMUX_PKG_REPLACES="libtiff-dev"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--enable-cxx --disable-webp"
