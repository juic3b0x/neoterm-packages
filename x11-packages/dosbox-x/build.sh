NEOTERM_PKG_HOMEPAGE=https://dosbox-x.com/
NEOTERM_PKG_DESCRIPTION="A cross-platform DOS emulator based on the DOSBox project"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.84.3
NEOTERM_PKG_SRCURL=https://github.com/joncampbell123/dosbox-x/archive/refs/tags/dosbox-x-v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=6c807e72ece5de6b038e5ff3a7f1bc2e3bd61901548ed027192f58ff19585881
NEOTERM_PKG_DEPENDS="dosbox-x-data, fluidsynth, freetype, libc++, libiconv, libpcap, libpng, libslirp, libx11, libxkbfile, libxrandr, opengl, sdl2, sdl2-net, zlib"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_path_SDL2_CONFIG=$NEOTERM_PREFIX/bin/sdl2-config
--enable-sdl2
--disable-alsa-midi
--disable-dynamic-x86
--disable-fpu-x86
--disable-unaligned-memory
--disable-avcodec
"

neoterm_step_post_get_source() {
	sed -i 's:/tmp/tinyfd:'"$NEOTERM_PREFIX"'\0:g' \
		src/libs/tinyfiledialogs/tinyfiledialogs.c
}

neoterm_step_pre_configure() {
	autoreconf -fi

	LDFLAGS+=" -liconv"
}
