NEOTERM_PKG_HOMEPAGE=https://github.com/libsdl-org/SDL_ttf
NEOTERM_PKG_DESCRIPTION="A library that allows you to use TrueType fonts in your SDL applications (version 2)"
NEOTERM_PKG_LICENSE="ZLIB"
NEOTERM_PKG_LICENSE_FILE="LICENSE.txt"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.22.0"
NEOTERM_PKG_SRCURL=https://github.com/libsdl-org/SDL_ttf/releases/download/release-${NEOTERM_PKG_VERSION}/SDL2_ttf-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=d48cbd1ce475b9e178206bf3b72d56b66d84d44f64ac05803328396234d67723
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_SED_REGEXP='s/.*-//'
NEOTERM_PKG_DEPENDS="freetype, opengl, sdl2"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-freetype-builtin
--disable-harfbuzz
"
