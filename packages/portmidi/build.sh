NEOTERM_PKG_HOMEPAGE=https://github.com/PortMidi/portmidi
NEOTERM_PKG_DESCRIPTION="A cross-platform MIDI input/output library"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.0.4
NEOTERM_PKG_SRCURL=https://github.com/PortMidi/portmidi/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=64893e823ae146cabd3ad7f9a9a9c5332746abe7847c557b99b2577afa8a607c
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DLINUX_DEFINES=PMNULL
"

neoterm_step_post_massage() {
	cd ${NEOTERM_PKG_MASSAGEDIR}/${NEOTERM_PREFIX}/lib || exit 1
	if [ ! -e "./libporttime.so" ]; then
		ln -sf libportmidi.so libporttime.so
	fi
}
