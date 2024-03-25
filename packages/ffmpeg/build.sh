NEOTERM_PKG_HOMEPAGE=https://ffmpeg.org
NEOTERM_PKG_DESCRIPTION="Tools and libraries to manipulate a wide range of multimedia formats and protocols"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
# Please align version with `ffplay` package.
NEOTERM_PKG_VERSION="6.1.1"
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://www.ffmpeg.org/releases/ffmpeg-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=8684f4b00f94b85461884c3719382f1261f0d9eb3d59640a1f4ac0873616f968
NEOTERM_PKG_DEPENDS="freetype, game-music-emu, libaom, libandroid-glob, libass, libbluray, libbz2, libdav1d, libgnutls, libiconv, liblzma, libmp3lame, libopencore-amr, libopenmpt, libopus, librav1e, libsoxr, libsrt, libssh, libtheora, libv4l, libvo-amrwbenc, libvorbis, libvpx, libvidstab, libwebp, libx264, libx265, libxml2, libzimg, littlecms, ocl-icd, svt-av1, xvidcore, zlib"
NEOTERM_PKG_BUILD_DEPENDS="opencl-headers"
NEOTERM_PKG_CONFLICTS="libav"
NEOTERM_PKG_BREAKS="ffmpeg-dev"
NEOTERM_PKG_REPLACES="ffmpeg-dev"

neoterm_step_pre_configure() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed. (These variables are also used afterwards.)
	_FFMPEG_SOVER_avutil=58
	_FFMPEG_SOVER_avcodec=60
	_FFMPEG_SOVER_avformat=60

	local f
	for f in util codec format; do
		local v=$(sh ffbuild/libversion.sh av${f} \
				libav${f}/version.h libav${f}/version_major.h \
				| sed -En 's/^libav'"${f}"'_VERSION_MAJOR=([0-9]+)$/\1/p')
		if [ ! "${v}" ] || [ "$(eval echo \$_FFMPEG_SOVER_av${f})" != "${v}" ]; then
			neoterm_error_exit "SOVERSION guard check failed for libav${f}.so."
		fi
	done
}

neoterm_step_configure() {
	cd $NEOTERM_PKG_BUILDDIR

	local _EXTRA_CONFIGURE_FLAGS=""
	if [ $NEOTERM_ARCH = "arm" ]; then
		_ARCH="armeabi-v7a"
		_EXTRA_CONFIGURE_FLAGS="--enable-neon"
	elif [ $NEOTERM_ARCH = "i686" ]; then
		_ARCH="x86"
		# Specify --disable-asm to prevent text relocations on i686,
		# see https://trac.ffmpeg.org/ticket/4928
		_EXTRA_CONFIGURE_FLAGS="--disable-asm"
	elif [ $NEOTERM_ARCH = "x86_64" ]; then
		_ARCH="x86_64"
	elif [ $NEOTERM_ARCH = "aarch64" ]; then
		_ARCH=$NEOTERM_ARCH
		_EXTRA_CONFIGURE_FLAGS="--enable-neon"
	else
		neoterm_error_exit "Unsupported arch: $NEOTERM_ARCH"
	fi

	$NEOTERM_PKG_SRCDIR/configure \
		--arch="${_ARCH}" \
		--as="$AS" \
		--cc="$CC" \
		--cxx="$CXX" \
		--nm="$NM" \
		--pkg-config="$PKG_CONFIG" \
		--strip="$STRIP" \
		--cross-prefix="${NEOTERM_HOST_PLATFORM}-" \
		--disable-indevs \
		--disable-outdevs \
		--enable-indev=lavfi \
		--disable-static \
		--disable-symver \
		--enable-cross-compile \
		--enable-gnutls \
		--enable-gpl \
		--enable-version3 \
		--enable-jni \
		--enable-lcms2 \
		--enable-libaom \
		--enable-libass \
		--enable-libbluray \
		--enable-libdav1d \
		--enable-libfreetype \
		--enable-libgme \
		--enable-libmp3lame \
		--enable-libopencore-amrnb \
		--enable-libopencore-amrwb \
  		--enable-libopenmpt \
		--enable-libopus \
		--enable-librav1e \
		--enable-libsoxr \
		--enable-libsrt \
		--enable-libssh \
		--enable-libsvtav1 \
		--enable-libtheora \
		--enable-libv4l2 \
		--enable-libvidstab \
		--enable-libvo-amrwbenc \
		--enable-libvorbis \
		--enable-libvpx \
		--enable-libwebp \
		--enable-libx264 \
		--enable-libx265 \
		--enable-libxml2 \
		--enable-libxvid \
		--enable-libzimg \
		--enable-mediacodec \
		--enable-opencl \
		--enable-shared \
		--prefix="$NEOTERM_PREFIX" \
		--target-os=android \
		--extra-libs="-landroid-glob" \
		--disable-vulkan \
		$_EXTRA_CONFIGURE_FLAGS \
		--disable-libfdk-aac
	# GPLed FFmpeg binaries linked against fdk-aac are not redistributable.
}

neoterm_step_post_massage() {
	cd ${NEOTERM_PKG_MASSAGEDIR}/${NEOTERM_PREFIX}/lib || exit 1
	local f
	for f in util codec format; do
		local s=$(eval echo \$_FFMPEG_SOVER_av${f})
		if [ ! "${s}" ]; then
			neoterm_error_exit "Empty SOVERSION for libav${f}."
		fi
		# SOVERSION suffix is expected by some programs, e.g. Firefox.
		if [ ! -e "./libav${f}.so.${s}" ]; then
			ln -sf libav${f}.so libav${f}.so.${s}
		fi
	done
}
