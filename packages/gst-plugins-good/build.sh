NEOTERM_PKG_HOMEPAGE=https://gstreamer.freedesktop.org/
NEOTERM_PKG_DESCRIPTION="GStreamer Good Plug-ins"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.24.0"
NEOTERM_PKG_SRCURL=https://gstreamer.freedesktop.org/src/gst-plugins-good/gst-plugins-good-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=b59148274c71b63eaf13e27785b68c946348e06c6c96d9f2682fe6479b4c0585
NEOTERM_PKG_DEPENDS="glib, gst-plugins-base, gstreamer, libandroid-shmem, libbz2, libcaca, libflac, libjpeg-turbo, libmp3lame, libnettle, libpng, libvpx, libx11, libxext, libxfixes, libxml2, pulseaudio, zlib"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dcairo=disabled
-Dexamples=disabled
-Dgdk-pixbuf=disabled
-Doss=disabled
-Doss4=disabled
-Dtests=disabled
-Dv4l2=disabled
-Daalib=disabled
"

neoterm_step_pre_configure() {
	local _WRAPPER_BIN="${NEOTERM_PKG_BUILDDIR}/_wrapper/bin"
	mkdir -p "${_WRAPPER_BIN}"
	if [[ "${NEOTERM_ON_DEVICE_BUILD}" == "false" ]]; then
		sed "s|^export PKG_CONFIG_LIBDIR=|export PKG_CONFIG_LIBDIR=${NEOTERM_PREFIX}/opt/glib/cross/lib/x86_64-linux-gnu/pkgconfig:|" \
			"${NEOTERM_STANDALONE_TOOLCHAIN}/bin/pkg-config" \
			> "${_WRAPPER_BIN}/pkg-config"
		chmod +x "${_WRAPPER_BIN}/pkg-config"
		export PKG_CONFIG="${_WRAPPER_BIN}/pkg-config"
	fi
	export PATH="${_WRAPPER_BIN}:${PATH}"
	LDFLAGS+=" -landroid-shmem"
}
