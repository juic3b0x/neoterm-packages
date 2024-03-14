NEOTERM_PKG_HOMEPAGE=https://github.com/Martchus/tagparser
NEOTERM_PKG_DESCRIPTION="C++ library for reading and writing MP4 (iTunes), ID3, Vorbis, Opus, FLAC and Matroska tags"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="12.1.0"
NEOTERM_PKG_SRCURL=https://github.com/Martchus/tagparser/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=5632786ab40509fc15039210b6092fcd496231d3db3c5e8995a2689f39954540
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libc++, libc++utilities, zlib"
NEOTERM_PKG_BUILD_DEPENDS="iso-codes"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_SHARED_LIBS=ON
-DLANGUAGE_FILE_ISO_639_2=$NEOTERM_PREFIX/share/iso-codes/json/iso_639-2.json
"

neoterm_step_pre_configure() {
	CXXFLAGS+=" -std=c++17"
}
