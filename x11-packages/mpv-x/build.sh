NEOTERM_PKG_HOMEPAGE=https://mpv.io/
NEOTERM_PKG_DESCRIPTION="Command-line media player"
# License: GPL-2.0-or-later
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
# Update both mpv and mpv-x to the same version in one PR.
NEOTERM_PKG_VERSION="0.37.0"
NEOTERM_PKG_SRCURL=https://github.com/mpv-player/mpv/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=1d2d4adbaf048a2fa6ee134575032c4b2dad9a7efafd5b3e69b88db935afaddf
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_DEPENDS="ffmpeg, libandroid-glob, libandroid-shmem, libarchive, libass, libbluray, libcaca, libdrm, libdvdnav, libiconv, libjpeg-turbo, liblua52, libsixel, libuchardet, libx11, libxext, libxinerama, libxpresent, libxrandr, libxss, libzimg, littlecms, openal-soft, pipewire, pulseaudio, rubberband, zlib, libplacebo"
NEOTERM_PKG_CONFLICTS="mpv"
NEOTERM_PKG_REPLACES="mpv"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dlibmpv=true
-Dlua=lua52
-Ddvdnav=enabled
-Dvapoursynth=disabled
-Dopenal=enabled
-Dgbm=disabled
-Dgl=disabled
-Dvdpau=disabled
-Dvaapi=disabled
-Dvulkan=disabled
-Dwayland=disabled
-Dxv=disabled
-Dandroid-media-ndk=disabled
"

neoterm_step_post_get_source() {
	# Version guard
	local ver_m=$(. $NEOTERM_SCRIPTDIR/packages/mpv/build.sh; echo ${NEOTERM_PKG_VERSION#*:})
	local ver_x=${NEOTERM_PKG_VERSION#*:}
	if [ "${ver_m}" != "${ver_x}" ]; then
		neoterm_error_exit "Version mismatch between mpv and mpv-x."
	fi
}

neoterm_step_pre_configure() {
	LDFLAGS+=" -landroid-glob -landroid-shmem"
	sed -i "s/host_machine.system() == 'android'/false/" ${NEOTERM_PKG_SRCDIR}/meson.build
}

neoterm_step_post_make_install() {
	install -Dm600 -t $NEOTERM_PREFIX/etc/mpv/ $NEOTERM_PKG_BUILDER_DIR/mpv.conf
	install -Dm600 -t $NEOTERM_PREFIX/share/mpv/scripts/ $NEOTERM_PKG_SRCDIR/TOOLS/lua/*
}
