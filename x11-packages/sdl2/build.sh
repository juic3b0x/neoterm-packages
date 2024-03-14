NEOTERM_PKG_HOMEPAGE=https://www.libsdl.org
NEOTERM_PKG_DESCRIPTION="A library for portable low-level access to a video framebuffer, audio output, mouse, and keyboard (version 2)"
NEOTERM_PKG_LICENSE="ZLIB"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.30.1"
NEOTERM_PKG_SRCURL=https://www.libsdl.org/release/SDL2-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=01215ffbc8cfc4ad165ba7573750f15ddda1f971d5a66e9dcaffd37c587f473a
NEOTERM_PKG_DEPENDS="libdecor, libwayland, libx11, libxcursor, libxext, libxfixes, libxi, libxkbcommon, libxrandr, libxss, pulseaudio"
NEOTERM_PKG_BUILD_DEPENDS="libwayland-cross-scanner, libwayland-protocols, opengl"
NEOTERM_PKG_RECOMMENDS="opengl"
NEOTERM_PKG_CONFLICTS="libsdl2"
NEOTERM_PKG_REPLACES="libsdl2"
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-3dnow
--disable-alsa
--disable-assembly
--disable-dbus
--disable-directx
--disable-esd
--disable-fcitx
--disable-ibus
--disable-ime
--disable-libudev
--disable-mmx
--disable-oss
--disable-pthread-sem
--disable-render-d3d
--disable-render-metal
--disable-video-cocoa
--disable-video-kmsdrm
--disable-video-rpi
--disable-video-vivante
--enable-libdecor
--enable-pthreads
--enable-video-opengl
--enable-video-opengles
--enable-video-opengles1
--enable-video-opengles2
--enable-video-vulkan
--enable-video-wayland
--enable-video-x11-scrnsaver
--enable-video-x11-xcursor
--enable-video-x11-xdbe
--enable-video-x11-xfixes
--enable-video-x11-xinput
--enable-video-x11-xrandr
--enable-video-x11-xshape
--x-includes=${NEOTERM_PREFIX}/include
--x-libraries=${NEOTERM_PREFIX}/lib
"

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=0

	local v=$(sed -En 's/^LT_MAJOR=([0-9]+).*/\1/p' configure.ac)
	if [ "${v}" != "${_SOVERSION}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}

neoterm_step_pre_configure() {
	rm -rf "$NEOTERM_PKG_SRCDIR"/Xcode-iOS
	find "$NEOTERM_PKG_SRCDIR" -type f | \
		xargs -n 1 sed -i \
		-e 's/\([^A-Za-z0-9_]__ANDROID\)\(__[^A-Za-z0-9_]\)/\1_NO_NEOTERM\2/g' \
		-e 's/\([^A-Za-z0-9_]__ANDROID\)__$/\1_NO_NEOTERM__/g'

	local _WRAPPER_BIN="${NEOTERM_PKG_BUILDDIR}/_wrapper/bin"
	mkdir -p "${_WRAPPER_BIN}"
	if [[ "${NEOTERM_ON_DEVICE_BUILD}" == "false" ]]; then
		sed "s|^export PKG_CONFIG_LIBDIR=|export PKG_CONFIG_LIBDIR=${NEOTERM_PREFIX}/opt/libwayland/cross/lib/x86_64-linux-gnu/pkgconfig:|" \
			"${NEOTERM_STANDALONE_TOOLCHAIN}/bin/pkg-config" \
			> "${_WRAPPER_BIN}/pkg-config"
		chmod +x "${_WRAPPER_BIN}/pkg-config"
		export PKG_CONFIG="${_WRAPPER_BIN}/pkg-config"
	fi
	export PATH="${_WRAPPER_BIN}:${PATH}"
}

neoterm_step_post_massage() {
	# ld(1)ing with `-lSDL2` won't work without this:
	# https://github.com/neoterm/x11-packages/issues/633
	cd ${NEOTERM_PKG_MASSAGEDIR}/${NEOTERM_PREFIX}/lib || exit 1
	if [ ! -e "./libSDL2.so" ]; then
		ln -sf libSDL2-2.0.so libSDL2.so
	fi
}
