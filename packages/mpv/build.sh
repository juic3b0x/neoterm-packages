NEOTERM_PKG_HOMEPAGE=https://mpv.io/
NEOTERM_PKG_DESCRIPTION="Command-line media player"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
# Update both mpv and mpv-x to the same version in one PR.
NEOTERM_PKG_VERSION="0.37.0"
NEOTERM_PKG_SRCURL=https://github.com/mpv-player/mpv/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=1d2d4adbaf048a2fa6ee134575032c4b2dad9a7efafd5b3e69b88db935afaddf
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_DEPENDS="ffmpeg, libandroid-glob, libandroid-support, libarchive, libass, libcaca, libiconv, liblua52, libsixel, libuchardet, openal-soft, pulseaudio, rubberband, zlib, libplacebo"
NEOTERM_PKG_RM_AFTER_INSTALL="share/icons share/applications"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dlibmpv=true
-Dlua=lua52
-Ddvdnav=disabled
-Dlcms2=disabled
-Dlibbluray=disabled
-Dvapoursynth=disabled
-Dzimg=disabled
-Dopenal=enabled
-Ddrm=disabled
-Dgbm=disabled
-Dgl=disabled
-Djpeg=disabled
-Dvdpau=disabled
-Dvaapi=disabled
-Dvulkan=disabled
-Dwayland=disabled
-Dx11=disabled
-Dxv=disabled
-Dandroid-media-ndk=disabled
"

neoterm_step_post_get_source() {
	# Version guard
	local ver_m=${NEOTERM_PKG_VERSION#*:}
	local ver_x=$(. $NEOTERM_SCRIPTDIR/x11-packages/mpv-x/build.sh; echo ${NEOTERM_PKG_VERSION#*:})
	if [ "${ver_m}" != "${ver_x}" ]; then
		neoterm_error_exit "Version mismatch between mpv and mpv-x."
	fi
}

neoterm_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
	sed -i "s/host_machine.system() == 'android'/false/" ${NEOTERM_PKG_SRCDIR}/meson.build
}

neoterm_step_post_make_install() {
	# Use opensles audio out by default:
	install -Dm600 -t $NEOTERM_PREFIX/etc/mpv/ $NEOTERM_PKG_BUILDER_DIR/mpv.conf
	install -Dm600 -t $NEOTERM_PREFIX/share/mpv/scripts/ $NEOTERM_PKG_SRCDIR/TOOLS/lua/*
}
