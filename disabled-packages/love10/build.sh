# x11-packages
NEOTERM_PKG_HOMEPAGE=https://love2d.org/
NEOTERM_PKG_DESCRIPTION="A framework you can use to make 2D games in Lua"
NEOTERM_PKG_LICENSE="ZLIB"
NEOTERM_PKG_LICENSE_FILE="license.txt"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.10.2
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/love2d/love/releases/download/${NEOTERM_PKG_VERSION}/love-${NEOTERM_PKG_VERSION}-linux-src.tar.gz
NEOTERM_PKG_SHA256=b26b306b113158927ae12d2faadb606eb1db49ffdcd7592d6a0a3fc0af21a387
NEOTERM_PKG_DEPENDS="freetype, game-music-emu, libandroid-spawn, libc++, libluajit, libmodplug, libogg, libphysfs, libtheora, libvorbis, mpg123, openal-soft, opengl, sdl2, zlib"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--enable-gme
--with-lua=luajit
ac_cv_prog_LUA_EXECUTABLE=luajit
"

neoterm_step_pre_configure() {
	case "$NEOTERM_PKG_VERSION" in
		0.10.*|*:0.10.* ) ;;
		* ) neoterm_error_exit "Invalid version '$NEOTERM_PKG_VERSION' for package '$NEOTERM_PKG_NAME'." ;;
	esac

	export OBJCXX="$CXX"
	CPPFLAGS+=" -DluaL_reg=luaL_Reg"
	LDFLAGS+=" -landroid-spawn"
	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
