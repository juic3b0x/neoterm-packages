NEOTERM_PKG_HOMEPAGE=https://gstreamer.freedesktop.org/
NEOTERM_PKG_DESCRIPTION="GStreamer base plug-ins"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.24.0"
NEOTERM_PKG_SRCURL=https://gstreamer.freedesktop.org/src/gst-plugins-base/gst-plugins-base-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=f33774129c437e2207034f8927af4cf7ed8c0f006a4602b5cde2823ec6c0cc07
NEOTERM_PKG_DEPENDS="glib, graphene, gstreamer, libandroid-shmem, libjpeg-turbo, libogg, libopus, libpng, libtheora, libvorbis, libx11, libxcb, libxext, libxv, zlib"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner, opengl"
NEOTERM_PKG_RECOMMENDS="opengl"
NEOTERM_PKG_BREAKS="gst-plugins-base-dev"
NEOTERM_PKG_REPLACES="gst-plugins-base-dev"
NEOTERM_PKG_DISABLE_GIR=false
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dintrospection=enabled
-Dtests=disabled
-Dexamples=disabled
-Dpango=disabled
"

neoterm_step_pre_configure() {
	NEOTERM_PKG_VERSION=. neoterm_setup_gir

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
