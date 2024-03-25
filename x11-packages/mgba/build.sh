NEOTERM_PKG_HOMEPAGE=https://mgba.io/
NEOTERM_PKG_DESCRIPTION="An emulator for running Game Boy Advance games"
NEOTERM_PKG_LICENSE="MPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.10.3"
NEOTERM_PKG_SRCURL=https://github.com/mgba-emu/mgba/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=be2cda7de3da8819fdab0c659c5cd4c4b8ca89d9ecddeeeef522db6d31a64143
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="ffmpeg, libedit, libelf, liblua54, libpng, libsqlite, libzip, opengl, sdl2, zlib"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_GLES2=OFF
-DBUILD_GLES3=OFF
-DBUILD_QT=OFF
-DLUA_MATH_LIBRARY=m
-DUSE_EPOXY=OFF
-DUSE_LUA=5.4
-DUSE_MINIZIP=OFF
"

neoterm_step_pre_configure() {
	CPPFLAGS+=" -DHAVE_STRTOF_L"
}
