NEOTERM_PKG_HOMEPAGE="https://github.com/Genivia/ugrep"
NEOTERM_PKG_DESCRIPTION="A faster, user-friendly and compatible grep replacement"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="5.1.1"
NEOTERM_PKG_SRCURL="https://github.com/Genivia/ugrep/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz"
NEOTERM_PKG_SHA256=687fc43a02287bac18f973822036bb3c470a81825b8eb3d98a335603b249b13b
NEOTERM_PKG_DEPENDS="libbz2, libc++, liblz4, liblzma, pcre2, zlib, zstd"
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--with-pcre2=$NEOTERM_PREFIX/include
--with-zlib=$NEOTERM_PREFIX/include
--with-bzlib=$NEOTERM_PREFIX/include
--with-lzma=$NEOTERM_PREFIX/include
--with-lz4=$NEOTERM_PREFIX/include
--with-zstd=$NEOTERM_PREFIX/include
--oldincludedir=$NEOTERM_PREFIX/include
"

neoterm_step_pre_configure() {
	autoreconf -fi
}
