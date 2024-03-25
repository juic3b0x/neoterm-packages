NEOTERM_PKG_HOMEPAGE=https://www.musicpd.org
NEOTERM_PKG_DESCRIPTION="Music player daemon"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.23.15"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/MusicPlayerDaemon/MPD/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=d2865d8f8ea79aa509b1465b99a2b8f3f449fe894521c97feadc2dca85a6ecd2
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="chromaprint, dbus, ffmpeg, game-music-emu, libao, libbz2, libc++, libcurl, libexpat, libflac, libicu, libid3tag, libmad, libmp3lame, libmpdclient, libnfs, libogg, libopus, libsamplerate, libsndfile, libsoxr, libsqlite, libvorbis, openal-soft, pcre2, pulseaudio, yajl, zlib, fmt"
NEOTERM_PKG_BUILD_DEPENDS="boost, boost-headers, libiconv"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dalsa=disabled
-Depoll=false
-Dsndio=disabled
-Dzlib=enabled
-Dicu=enabled
-Diconv=enabled
-Dpcre=enabled
-Dexpat=enabled
-Ddbus=enabled
-Dipv6=enabled
"
NEOTERM_PKG_CONFFILES="etc/mpd.conf"
NEOTERM_PKG_RM_AFTER_INSTALL="include/fmt lib/pkgconfig/fmt.pc"
NEOTERM_PKG_SERVICE_SCRIPT=("mpd" "if [ -f \"$NEOTERM_ANDROID_HOME/.mpd/mpd.conf\" ]; then CONFIG=\"$NEOTERM_ANDROID_HOME/.mpd/mpd.conf\"; else CONFIG=\"$NEOTERM_PREFIX/etc/mpd.conf\"; fi\nexec mpd --stdout --no-daemon \$CONFIG 2>&1")
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"

neoterm_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $NEOTERM_PREFIX.
	if $NEOTERM_ON_DEVICE_BUILD; then
		neoterm_error_exit "Package '$NEOTERM_PKG_NAME' is not safe for on-device builds."
	fi

	CXXFLAGS+=" -DNEOTERM -UANDROID"
	LDFLAGS+=" -lOpenSLES"
	rm -f $NEOTERM_PREFIX/etc/mpd.conf

	export BOOST_ROOT=$NEOTERM_PREFIX
}

neoterm_step_post_make_install() {
	install -Dm600 $NEOTERM_PKG_SRCDIR/doc/mpdconf.example $NEOTERM_PREFIX/etc/mpd.conf
}

neoterm_step_create_debscripts() {
	echo "#!$NEOTERM_PREFIX/bin/sh" >postinst
	echo 'mkdir -p $HOME/.mpd/playlists' >>postinst
}
