NEOTERM_PKG_HOMEPAGE=https://notcurses.com/
NEOTERM_PKG_DESCRIPTION="blingful TUIs and character graphics"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="3.0.9"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/dankamongmen/notcurses/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=e5cc02aea82814b843cdf34dedd716e6e1e9ca440cf0f899853ca95e241bd734
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="ffmpeg, libandroid-spawn, libc++, libunistring, ncurses, zlib"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DUSE_DOCTEST=OFF
-DUSE_DEFLATE=OFF
-DUSE_PANDOC=OFF
-DUSE_STATIC=OFF
"

neoterm_step_pre_configure() {
	LDFLAGS+=" -landroid-spawn -lm"
}
