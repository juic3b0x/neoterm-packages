# x11-packages
NEOTERM_PKG_HOMEPAGE=https://www.widelands.org/
NEOTERM_PKG_DESCRIPTION="A free, open source real-time strategy game with singleplayer campaigns and a multiplayer mode"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.0
NEOTERM_PKG_SRCURL=https://github.com/widelands/widelands/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=1dab0c4062873cc72c5e0558f9e9620b0ef185f1a78923a77c4ce5b9ed76031a
NEOTERM_PKG_DEPENDS="glew, libandroid-execinfo, libandroid-glob, libcurl, libicu, libpng, opengl, sdl2, sdl2-image, sdl2-mixer, sdl2-ttf, widelands-data"
NEOTERM_PKG_BUILD_DEPENDS="boost, boost-headers"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_INSTALL_PREFIX=$NEOTERM_PREFIX/bin
-DWL_INSTALL_BASEDIR=$NEOTERM_PREFIX/share/doc/$NEOTERM_PKG_NAME
-DWL_INSTALL_DATADIR=$NEOTERM_PREFIX/share/$NEOTERM_PKG_NAME
-DGTK_UPDATE_ICON_CACHE=OFF
-DOPTION_BUILD_TESTS=OFF
"

neoterm_step_pre_configure() {
	LDFLAGS+=" -landroid-glob -landroid-execinfo"
}
