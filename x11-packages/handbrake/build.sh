NEOTERM_PKG_HOMEPAGE=https://handbrake.fr/
NEOTERM_PKG_DESCRIPTION="A GPL-licensed, multiplatform, multithreaded video transcoder"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_LICENSE_FILE="COPYING, LICENSE"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.6.1
NEOTERM_PKG_REVISION=4
NEOTERM_PKG_SRCURL=https://github.com/HandBrake/HandBrake/releases/download/${NEOTERM_PKG_VERSION}/HandBrake-${NEOTERM_PKG_VERSION}-source.tar.bz2
NEOTERM_PKG_SHA256=94ccfe03db917a91650000c510f7fd53f844da19f19ad4b4be1b8f6bc31a8d4c
NEOTERM_PKG_DEPENDS="ffmpeg, gdk-pixbuf, gst-plugins-base, gstreamer, gtk3, libass, libbluray, libcairo, libdvdnav, libdvdread, libiconv, libjansson, libjpeg-turbo, libtheora, libvorbis, libx264, libx265, libxml2, pango"
NEOTERM_PKG_BUILD_DEPENDS="liba52, libspeex, libzimg, svt-av1"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--force
--prefix $NEOTERM_PREFIX
--arch $NEOTERM_ARCH
--disable-gtk-update-checks
--disable-numa
--disable-nvenc
"
# HandBrake binaries linked against fdk-aac are not redistributable.
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" --disable-fdk-aac"

neoterm_step_pre_configure() {
	sed -i -E '/(\/contrib|contrib\/)/d' make/include/main.defs

	LDFLAGS+=" -liconv -lx265"
}

neoterm_step_configure() {
	$NEOTERM_PKG_SRCDIR/configure $NEOTERM_PKG_EXTRA_CONFIGURE_ARGS
}
