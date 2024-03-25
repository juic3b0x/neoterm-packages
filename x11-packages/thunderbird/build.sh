NEOTERM_PKG_HOMEPAGE=https://www.thunderbird.net
NEOTERM_PKG_DESCRIPTION="Unofficial Thunderbird email client"
NEOTERM_PKG_LICENSE="MPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=115.6.1
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://ftp.mozilla.org/pub/thunderbird/releases/${NEOTERM_PKG_VERSION}/source/thunderbird-${NEOTERM_PKG_VERSION}.source.tar.xz
NEOTERM_PKG_SHA256=638beb0d2907c6adbe441b7cd371f205728ac65489c04cb29bb40e71ea2846e3
NEOTERM_PKG_DEPENDS="ffmpeg, fontconfig, freetype, gdk-pixbuf, glib, gtk3, libandroid-shmem, libandroid-spawn, libc++, libcairo, libevent, libffi, libice, libicu, libjpeg-turbo, libnspr, libnss, libotr, libpixman, libsm, libvpx, libwebp, libx11, libxcb, libxcomposite, libxdamage, libxext, libxfixes, libxrandr, libxtst, pango, pulseaudio, zlib"
NEOTERM_PKG_BUILD_DEPENDS="binutils-cross, libcpufeatures, libice, libsm"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_post_get_source() {
	local f="media/ffvpx/config_unix_aarch64.h"
	echo "Applying sed substitution to ${f}"
	sed -i -E '/^#define (CONFIG_LINUX_PERF|HAVE_SYSCTL) /s/1$/0/' ${f}
}

neoterm_step_pre_configure() {
	neoterm_setup_nodejs
	neoterm_setup_rust

	cargo install cbindgen

	sed \
		-e "s|@CARGO_TARGET_NAME@|${CARGO_TARGET_NAME}|" \
		-i "${NEOTERM_PKG_SRCDIR}"/build/moz.configure/rust.configure

	export HOST_CC=$(command -v clang)
	export HOST_CXX=$(command -v clang++)

	# https://reviews.llvm.org/D141184
	CXXFLAGS+=" -U__ANDROID__ -D_LIBCPP_HAS_NO_C11_ALIGNED_ALLOC"
	LDFLAGS+=" -landroid-shmem -landroid-spawn -llog"

	if [ "$NEOTERM_ARCH" = "arm" ]; then
		neoterm_setup_no_integrated_as
		# For symbol android_getCpuFeatures
		LDFLAGS+=" -l:libndk_compat.a"
	fi
}

neoterm_step_configure() {
	sed \
		-e "s|@NEOTERM_HOST_PLATFORM@|${NEOTERM_HOST_PLATFORM}|" \
		-e "s|@NEOTERM_PREFIX@|${NEOTERM_PREFIX}|" \
		-e "s|@CARGO_TARGET_NAME@|${CARGO_TARGET_NAME}|" \
		$NEOTERM_PKG_BUILDER_DIR/mozconfig.cfg > .mozconfig

	./mach configure
}

neoterm_step_make() {
	./mach build
	./mach buildsymbols
}

neoterm_step_make_install() {
	./mach install

	install -Dm644 -t "${NEOTERM_PREFIX}/share/applications" "${NEOTERM_PKG_BUILDER_DIR}/thunderbird.desktop"
}
