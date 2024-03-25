NEOTERM_PKG_HOMEPAGE=https://love2d.org/
NEOTERM_PKG_DESCRIPTION="A framework you can use to make 2D games in Lua"
NEOTERM_PKG_LICENSE="ZLIB"
NEOTERM_PKG_LICENSE_FILE="license.txt"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="11.5"
NEOTERM_PKG_REVISION=4
NEOTERM_PKG_SRCURL=https://github.com/love2d/love/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=6f55c265be5e03696c4770150c4388f5cffbdb3727606724cf88332baab429f7
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="freetype, game-music-emu, libandroid-spawn, libc++, libluajit, libmodplug, libogg, libtheora, libvorbis, mpg123, openal-soft, opengl, sdl2, zlib"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--enable-gme
"

neoterm_step_pre_configure() {
	mkdir -p platform/unix/m4
	ln -sf $NEOTERM_PREFIX/share/aclocal/sdl2.m4 platform/unix/m4/
	local _orig_prefix=${prefix}
	unset prefix
	./platform/unix/automagic
	export prefix=${_orig_prefix}

	export OBJCXX="$CXX"
	LDFLAGS+=" -landroid-spawn"
	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
