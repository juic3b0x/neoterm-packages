NEOTERM_PKG_HOMEPAGE=https://mp3splt.sourceforge.net
NEOTERM_PKG_DESCRIPTION="Utility to split mp3, ogg vorbis and FLAC files without decoding"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.6.2
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=http://prdownloads.sourceforge.net/mp3splt/mp3splt-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=3ec32b10ddd8bb11af987b8cd1c76382c48d265d0ffda53041d9aceb1f103baa
NEOTERM_PKG_DEPENDS="libmp3splt"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--mandir=$NEOTERM_PREFIX/share/man"

neoterm_step_post_configure() {
	cd $NEOTERM_PKG_SRCDIR/src
	sed -i -e 's/BEOS/ANDROID/g' freedb.c
	touch langinfo.h
}
