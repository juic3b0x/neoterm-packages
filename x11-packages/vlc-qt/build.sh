NEOTERM_PKG_HOMEPAGE=https://www.videolan.org/
NEOTERM_PKG_DESCRIPTION="A popular libre and open source media player and multimedia engine"
NEOTERM_PKG_LICENSE="GPL-2.0, LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="3.0.20"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://download.videolan.org/pub/videolan/vlc/${NEOTERM_PKG_VERSION}/vlc-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=adc7285b4d2721cddf40eb5270cada2aaa10a334cb546fd55a06353447ba29b5
NEOTERM_PKG_DEPENDS="chromaprint, dbus, ffmpeg, fluidsynth, fontconfig, freetype, fribidi, glib, gst-plugins-base, gstreamer, harfbuzz, liba52, libandroid-shmem, libandroid-spawn, libaom, libarchive, libass, libbluray, libc++, libcaca, libcairo, libcddb, libdav1d, libdvbpsi, libdvdnav, libdvdread, libebml, libflac, libgcrypt, libgnutls, libgpg-error, libiconv, libidn, libjpeg-turbo, liblua52, libmad, libmatroska, libmpeg2, libnfs, libogg, libopus, libpng, librsvg, libsecret, libsoxr, libssh2, libtheora, libtwolame, libvorbis, libvpx, libx11, libx264, libx265, libxcb, libxml2, mpg123, ncurses, opengl, pulseaudio, qt5-qtbase, qt5-qtsvg, qt5-qtx11extras, samba, taglib, xcb-util-keysyms, zlib"
NEOTERM_PKG_BUILD_DEPENDS="qt5-qtbase-cross-tools, xorgproto"
NEOTERM_PKG_CONFLICTS="vlc"
NEOTERM_PKG_REPLACES="vlc"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-static
--disable-live555
--disable-dc1394
--disable-dv1394
--disable-linsys
--disable-opencv
--disable-dsm
--disable-v4l2
--disable-decklink
--disable-vnc
--disable-freerdp
--disable-asdcp
--disable-gme
--disable-sid
--disable-shout
--disable-mod
--disable-mpc
--disable-shine
--disable-crystalhd
--disable-libva
--disable-dxva2
--disable-d3d11va
--disable-faad
--disable-dca
--disable-speex
--disable-spatialaudio
--disable-schroedinger
--disable-mfx
--disable-fluidlite
--disable-zvbi
--disable-aribsub
--disable-aribb25
--disable-kate
--disable-tiger
--disable-vdpau
--disable-sdl-image
--disable-kva
--disable-mmal
--disable-alsa
--disable-oss
--disable-sndio
--disable-wasapi
--disable-jack
--disable-samplerate
--disable-kai
--disable-chromecast
--disable-skins2
--disable-srt
--disable-goom
--disable-projectm
--disable-vsxu
--disable-avahi
--disable-udev
--disable-mtp
--disable-upnp
--disable-microdns
--disable-notify
--disable-libplacebo
ac_cv_func_ffsll=yes
ac_cv_func_swab=yes
ac_cv_prog_LUAC=luac5.2
"

neoterm_step_pre_configure() {
	autoreconf -fi

	CFLAGS+=" -fcommon"
	LDFLAGS+=" -landroid-shmem -landroid-spawn -lm"
	LDFLAGS+=" -Wl,-rpath=$NEOTERM_PREFIX/lib/vlc"

	local _libgcc="$($CC -print-libgcc-file-name)"
	LDFLAGS+=" -L$(dirname $_libgcc) -l:$(basename $_libgcc)"
}

neoterm_step_post_configure() {
	# Avoid overlinking
	sed -i 's/ -shared / -Wl,--as-needed\0/g' ./libtool
}
