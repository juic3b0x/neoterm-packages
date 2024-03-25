NEOTERM_PKG_HOMEPAGE=https://sox.sourceforge.net/
NEOTERM_PKG_DESCRIPTION="Command line utility for converting between and applying effects to various audio files formats"
NEOTERM_PKG_LICENSE="GPL-2.0, LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=14.4.2
NEOTERM_PKG_REVISION=25
NEOTERM_PKG_SRCURL=http://downloads.sourceforge.net/project/sox/sox/${NEOTERM_PKG_VERSION}/sox-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=81a6956d4330e75b5827316e44ae381e6f1e8928003c6aa45896da9041ea149c
NEOTERM_PKG_DEPENDS="file, libandroid-glob, libao, libflac, libiconv, libid3tag, libltdl, libmad, libmp3lame, libogg, libpng, libsndfile, libvorbis, opusfile, pulseaudio, zlib"
NEOTERM_PKG_BREAKS="sox-dev"
NEOTERM_PKG_REPLACES="sox-dev"

neoterm_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
	CPPFLAGS+=" -D_FSTDIO"
}
