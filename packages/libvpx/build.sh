NEOTERM_PKG_HOMEPAGE=https://www.webmproject.org
NEOTERM_PKG_DESCRIPTION="VP8 & VP9 Codec SDK"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1:1.14.0"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/webmproject/libvpx/archive/v${NEOTERM_PKG_VERSION:2}.tar.gz
NEOTERM_PKG_SHA256=5f21d2db27071c8a46f1725928a10227ae45c5cd1cad3727e4aafbe476e321fa
NEOTERM_PKG_DEPENDS="libc++"
NEOTERM_PKG_BREAKS="libvpx-dev"
NEOTERM_PKG_REPLACES="libvpx-dev"
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"

neoterm_pkg_auto_update() {
	# Get the newest tag:
	local tag
	tag="$(neoterm_github_api_get_tag "${NEOTERM_PKG_SRCURL}" "${NEOTERM_PKG_UPDATE_TAG_TYPE}")"
	# check if this is not a release (e.g. a release candidate):
	if grep -qP "^${NEOTERM_PKG_UPDATE_VERSION_REGEXP}\$" <<<"$tag"; then
		neoterm_pkg_upgrade_version "$tag"
	else
		echo "WARNING: Skipping auto-update: Not a release($tag)"
	fi
}

neoterm_step_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $NEOTERM_PREFIX.
	if $NEOTERM_ON_DEVICE_BUILD; then
		neoterm_error_exit "Package '$NEOTERM_PKG_NAME' is not safe for on-device builds."
	fi

	# Force fresh install of header files:
	rm -Rf $NEOTERM_PREFIX/include/vpx

	if [ $NEOTERM_ARCH = "arm" ]; then
		_CONFIGURE_TARGET="--target=armv7-android-gcc --disable-neon-asm"
	elif [ $NEOTERM_ARCH = "i686" ]; then
		_CONFIGURE_TARGET="--target=x86-android-gcc"
	elif [ $NEOTERM_ARCH = "aarch64" ]; then
		_CONFIGURE_TARGET="--force-target=arm64-v8a-android-gcc"
	elif [ $NEOTERM_ARCH = "x86_64" ]; then
		_CONFIGURE_TARGET="--target=x86_64-android-gcc"
	else
		neoterm_error_exit "Unsupported arch: $NEOTERM_ARCH"
	fi

	# For --disable-realtime-only, see
	# https://bugs.chromium.org/p/webm/issues/detail?id=800
	# "The issue is that on android we soft enable realtime only.
	#  [..] You can enable non-realtime by setting --disable-realtime-only"
	# Discovered in https://github.com/juic3b0x/neoterm-packages/issues/554
	#CROSS=${NEOTERM_HOST_PLATFORM}- CC=clang CXX=clang++ $NEOTERM_PKG_SRCDIR/configure \
	$NEOTERM_PKG_SRCDIR/configure \
		$_CONFIGURE_TARGET \
		--prefix=$NEOTERM_PREFIX \
		--disable-examples \
		--disable-realtime-only \
		--disable-unit-tests \
		--enable-pic \
		--enable-postproc \
		--enable-vp8 \
		--enable-vp9 \
		--enable-vp9-highbitdepth \
		--enable-vp9-temporal-denoising \
		--enable-vp9-postproc \
		--enable-shared \
		--enable-small \
		--as=auto \
		--extra-cflags="-fPIC"
}

neoterm_step_post_massage() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION_GUARD_FILES="lib/libvpx.so.9"
	local f
	for f in ${_SOVERSION_GUARD_FILES}; do
		if [ ! -e "${f}" ]; then
			neoterm_error_exit "Error: file ${f} not found; please check if SOVERSION has changed."
		fi
	done
}
