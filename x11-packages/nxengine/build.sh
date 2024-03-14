NEOTERM_PKG_HOMEPAGE=https://nxengine.sourceforge.net
NEOTERM_PKG_DESCRIPTION="Open-source rewrite engine of the Cave Story for Dingux and MotoMAGX"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@Yonle"
NEOTERM_PKG_VERSION=1.0.0.4-Rev4
NEOTERM_PKG_REVISION=4
NEOTERM_PKG_SRCURL=https://github.com/EXL/NXEngine/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=d467c112e81d4c56337ebf6968bd8bd781bce9140f674e72009a5274d2c15784
NEOTERM_PKG_DEPENDS="libc++, pulseaudio, sdl, sdl-ttf"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	make -j $NEOTERM_MAKE_PROCESSES -f Makefile.linux \
		CC="$CC" \
		CXX="$CXX" \
		LINK="$CXX" \
		CFLAGS="$CFLAGS $CPPFLAGS -Wno-c++11-narrowing" \
		CXXFLAGS="$CXXFLAGS $CPPFLAGS -Wno-c++11-narrowing" \
		LFLAGS="$LDFLAGS"
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin ./nx
	install -Dm600 -t $NEOTERM_PREFIX/share/nxengine \
		smalfont.bmp DroidSansMono.ttf font.ttf \
		sprites.sif tilekey.dat
}
