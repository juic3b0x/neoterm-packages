NEOTERM_PKG_HOMEPAGE=https://www.audacityteam.org/
NEOTERM_PKG_DESCRIPTION="An easy-to-use, multi-track audio editor and recorder"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
# Version 3.0.0 or higher does not work with vanilla wxWidgets.
NEOTERM_PKG_VERSION=2.4.2
NEOTERM_PKG_REVISION=9
_FFMPEG_VERSION=4.4.3
NEOTERM_PKG_SRCURL=(https://github.com/audacity/audacity/archive/Audacity-${NEOTERM_PKG_VERSION}.tar.gz
                   https://www.ffmpeg.org/releases/ffmpeg-${_FFMPEG_VERSION}.tar.xz)
NEOTERM_PKG_SHA256=(cdb4800c8e9d1d4ca19964caf8d24000f80286ebd8a4db566c2622449744c099
                   6c5b6c195e61534766a0b5fe16acc919170c883362612816d0a1c7f4f947006e)
NEOTERM_PKG_DEPENDS="gdk-pixbuf, glib, gtk3, libc++, libexpat, libflac, libmp3lame, libogg, libsndfile, libsoundtouch, libsoxr, libvorbis, wxwidgets"
# Support for FFmpeg 5.0 is not backported:
# https://github.com/audacity/audacity/issues/2445
NEOTERM_PKG_SUGGESTS="audacity-ffmpeg"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Daudacity_use_wxwidgets=system
-Daudacity_use_expat=system
-Daudacity_use_lame=system
-Daudacity_use_sndfile=system
-Daudacity_use_soxr=system
-Daudacity_use_portaudio=local
-Daudacity_use_ffmpeg=loaded
-Daudacity_use_id3tag=off
-Daudacity_use_mad=off
-Daudacity_use_nyquist=local
-Daudacity_use_vamp=off
-Daudacity_use_ogg=system
-Daudacity_use_vorbis=system
-Daudacity_use_flac=system
-Daudacity_use_lv2=off
-Daudacity_use_midi=off
-Daudacity_use_portmixer=local
-Daudacity_use_portsmf=off
-Daudacity_use_sbsms=off
-Daudacity_use_soundtouch=system
-Daudacity_use_twolame=off
"
NEOTERM_PKG_RM_AFTER_INSTALL="
opt/audacity/include
opt/audacity/lib/pkgconfig
opt/audacity/share
"

neoterm_step_pre_configure() {
	local _FFMPEG_PREFIX=${NEOTERM_PREFIX}/opt/${NEOTERM_PKG_NAME}
	LDFLAGS="-Wl,-rpath=${_FFMPEG_PREFIX}/lib ${LDFLAGS}"

	local _ARCH
	case ${NEOTERM_ARCH} in
		arm ) _ARCH=armeabi-v7a ;;
		i686 ) _ARCH=x86 ;;
		* ) _ARCH=$NEOTERM_ARCH ;;
	esac

	mkdir -p _ffmpeg-${_FFMPEG_VERSION}
	pushd _ffmpeg-${_FFMPEG_VERSION}
	$NEOTERM_PKG_SRCDIR/ffmpeg-${_FFMPEG_VERSION}/configure \
		--prefix=${_FFMPEG_PREFIX} \
		--cc=${CC} \
		--pkg-config=false \
		--arch=${_ARCH} \
		--cross-prefix=llvm- \
		--enable-cross-compile \
		--target-os=android \
		--disable-version3 \
		--disable-static \
		--enable-shared \
		--disable-all \
		--disable-autodetect \
		--disable-doc \
		--enable-avcodec \
		--enable-avformat \
		--disable-asm
	make -j ${NEOTERM_MAKE_PROCESSES}
	make install
	popd

	local lib
	for lib in libavcodec libavformat libavutil; do
		local pc=${NEOTERM_PREFIX}/lib/pkgconfig/${lib}.pc
		if [ -e ${pc} ]; then
			mv ${pc}{,.tmp}
		fi
	done
	export PKG_CONFIG_PATH=${_FFMPEG_PREFIX}/lib/pkgconfig
	CPPFLAGS="-I${_FFMPEG_PREFIX}/include ${CPPFLAGS}"

	CPPFLAGS+=" -Dushort=u_short -Dulong=u_long"
}

neoterm_step_post_make_install() {
	unset PKG_CONFIG_PATH
	local lib
	for lib in libavcodec libavformat libavutil; do
		local pc=${NEOTERM_PREFIX}/lib/pkgconfig/${lib}.pc
		if [ -e ${pc}.tmp ] && [ ! -e ${pc} ]; then
			mv ${pc}{.tmp,}
		fi
	done

	local _FFMPEG_DOCDIR=$NEOTERM_PREFIX/share/doc/audacity-ffmpeg
	mkdir -p ${_FFMPEG_DOCDIR}
	ln -sfr ${NEOTERM_PREFIX}/share/LICENSES/LGPL-2.1.txt \
		${_FFMPEG_DOCDIR}/LICENSE
}

neoterm_step_post_massage() {
	rm -rf lib/pkgconfig
}

neoterm_step_create_debscripts() {
	cat <<-EOF > ./postinst
		#!$NEOTERM_PREFIX/bin/sh
		echo
		echo "********"
		echo "Audacity in this particular package does not (yet) support audio devices."
		echo
		echo "https://github.com/neoterm/neoterm-packages/issues/10412"
		echo "********"
		echo
	EOF
}
