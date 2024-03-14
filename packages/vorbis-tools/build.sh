NEOTERM_PKG_HOMEPAGE=https://github.com/xiph/vorbis-tools
NEOTERM_PKG_DESCRIPTION="Ogg Vorbis tools"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.4.2
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=http://downloads.xiph.org/releases/vorbis/vorbis-tools-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=db7774ec2bf2c939b139452183669be84fda5774d6400fc57fde37f77624f0b0
# libflac for flac support in oggenc:
NEOTERM_PKG_DEPENDS="libiconv, libvorbis, libflac, libogg"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-ogg123
"

neoterm_step_pre_configure() {
	LDFLAGS+=" -lm"
}
