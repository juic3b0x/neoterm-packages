NEOTERM_PKG_HOMEPAGE=https://github.com/FluidSynth/fluidsynth
NEOTERM_PKG_DESCRIPTION="Software synthesizer based on the SoundFont 2 specifications"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="Yonle <yonle@lecturify.net>"
NEOTERM_PKG_VERSION="2.3.4"
NEOTERM_PKG_SRCURL=https://github.com/FluidSynth/fluidsynth/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=1529ef5bc3b9ef3adc2a7964505912f7305103e269e50cc0316f500b22053ac9
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="dbus, glib, libc++, libsndfile, pulseaudio, readline"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="-DLIB_INSTALL_DIR=${NEOTERM_PREFIX}/lib"
