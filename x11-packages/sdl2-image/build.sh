NEOTERM_PKG_HOMEPAGE=https://github.com/libsdl-org/SDL_image
NEOTERM_PKG_DESCRIPTION="A simple library to load images of various formats as SDL surfaces (version 2)"
NEOTERM_PKG_LICENSE="ZLIB"
NEOTERM_PKG_LICENSE_FILE="LICENSE.txt"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.8.2"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/libsdl-org/SDL_image/releases/download/release-${NEOTERM_PKG_VERSION}/SDL2_image-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=8f486bbfbcf8464dd58c9e5d93394ab0255ce68b51c5a966a918244820a76ddc
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_SED_REGEXP='s/.*-//'
NEOTERM_PKG_DEPENDS="libjpeg-turbo, libjxl, libpng, libtiff, libwebp, sdl2"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-stb-image
--disable-jpg-shared
--disable-jxl-shared
--disable-png-shared
--disable-tif-shared
--disable-webp-shared
"
