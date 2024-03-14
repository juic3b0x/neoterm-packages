NEOTERM_PKG_HOMEPAGE=https://pipewire.org/
NEOTERM_PKG_DESCRIPTION="A server and user space API to deal with multimedia pipelines"
NEOTERM_PKG_LICENSE="MIT, LGPL-2.1, LGPL-3.0, GPL-2.0"
NEOTERM_PKG_LICENSE_FILE="COPYING, LICENSE"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.0.3"
NEOTERM_PKG_SRCURL="https://gitlab.freedesktop.org/pipewire/pipewire/-/archive/${NEOTERM_PKG_VERSION}/pipewire-${NEOTERM_PKG_VERSION}.tar.bz2"
NEOTERM_PKG_SHA256=344d861efe19e9b8cd2389811fe2bdfb4f70ba640e271d92950d0899c0326181
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="ffmpeg, glib, libc++, liblua54, libopus, libsndfile, libwebrtc-audio-processing, lilv, ncurses, openssl, pulseaudio, readline"

# 'media-session' session-managers is disabled as it requires alsa.
# Since we are building without x11, dbus is disabled.
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dgstreamer=disabled
-Dgstreamer-device-provider=disabled
-Dtests=disabled
-Dexamples=disabled
-Dpipewire-alsa=disabled
-Dalsa=disabled
-Dpipewire-jack=disabled
-Djack=disabled
-Ddbus=disabled
-Dsession-managers=['wireplumber']
-Dffmpeg=enabled
-Dwireplumber:system-lua=true
-Dwireplumber:system-lua-version=54
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

	sed -i "s/'-Werror=strict-prototypes',//" ${NEOTERM_PKG_SRCDIR}/meson.build
	CFLAGS+=" -Dindex=strchr -Drindex=strrchr"
	sed "s|@NEOTERM_PKG_BUILDER_DIR@|${NEOTERM_PKG_BUILDER_DIR}|g" \
		"${NEOTERM_PKG_BUILDER_DIR}"/reallocarray.diff | patch -p1
}
