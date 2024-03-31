NEOTERM_PKG_HOMEPAGE=https://ffmpeg.org
NEOTERM_PKG_DESCRIPTION="FFplay media player"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
# Please align the version with `ffmpeg` package.
NEOTERM_PKG_VERSION="6.1.1"
NEOTERM_PKG_SRCURL=https://www.ffmpeg.org/releases/ffmpeg-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=8684f4b00f94b85461884c3719382f1261f0d9eb3d59640a1f4ac0873616f968
NEOTERM_PKG_DEPENDS="ffmpeg, libandroid-shmem, libx11, libxcb, libxext, libxv, pulseaudio, sdl2"

neoterm_step_pre_configure() {
	_FFPLAY_PREFIX="$NEOTERM_PREFIX/opt/$NEOTERM_PKG_NAME"
	LDFLAGS="-Wl,-rpath=${_FFPLAY_PREFIX}/lib $LDFLAGS -landroid-shmem"
}

neoterm_step_configure() {
	local _ARCH
	case "$NEOTERM_ARCH" in
		arm ) _ARCH=armeabi-v7a ;;
		i686 ) _ARCH=x86 ;;
		* ) _ARCH="$NEOTERM_ARCH" ;;
	esac

	$NEOTERM_PKG_SRCDIR/configure \
		--prefix="${_FFPLAY_PREFIX}" \
		--cc="$CC" \
		--pkg-config="$PKG_CONFIG" \
		--arch="${_ARCH}" \
		--cross-prefix=llvm- \
		--enable-cross-compile \
		--target-os=android \
		--disable-version3 \
		--disable-static \
		--enable-shared \
		--disable-autodetect \
		--disable-doc \
		--disable-asm \
		--enable-libpulse \
		--enable-libxcb \
		--enable-libxcb-shm \
		--enable-libxcb-xfixes \
		--enable-libxcb-shape \
		--enable-sdl \
		--enable-xlib \
		--enable-ffplay
}

neoterm_step_post_make_install() {
	mkdir -p $NEOTERM_PREFIX/bin
	ln -sfr "${_FFPLAY_PREFIX}/bin/ffplay" "$NEOTERM_PREFIX/bin/"
}

neoterm_step_post_massage() {
	cd "$NEOTERM_PKG_MASSAGEDIR/${_FFPLAY_PREFIX}" || exit 1
	find . ! -type d \
		! -wholename "./bin/ffplay" \
		! -wholename "./lib/libavdevice.so*" \
		-exec rm -f '{}' \;
	find . -type d -empty -delete
}
