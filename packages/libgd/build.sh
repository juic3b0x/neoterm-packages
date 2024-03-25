NEOTERM_PKG_HOMEPAGE=https://libgd.github.io/
NEOTERM_PKG_DESCRIPTION="GD is an open source code library for the dynamic creation of images by programmers"
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="COPYING"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1:2.3.3
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://github.com/libgd/libgd/releases/download/gd-${NEOTERM_PKG_VERSION:2}/libgd-${NEOTERM_PKG_VERSION:2}.tar.gz
NEOTERM_PKG_SHA256=dd3f1f0bb016edcc0b2d082e8229c822ad1d02223511997c80461481759b1ed2
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_METHOD=repology
NEOTERM_PKG_DEPENDS="fontconfig, freetype, libheif, libiconv, libjpeg-turbo, libpng, libtiff, libwebp, zlib"
NEOTERM_PKG_BREAKS="libgd-dev"
NEOTERM_PKG_REPLACES="libgd-dev"

# Disable vpx support for now, look at https://github.com/gagern/libgd/commit/d41eb72cd4545c394578332e5c102dee69e02ee8
# for enabling:
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--without-vpx --without-x"
