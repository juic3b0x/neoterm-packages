NEOTERM_PKG_HOMEPAGE=https://kokkinizita.linuxaudio.org/linuxaudio/
NEOTERM_PKG_DESCRIPTION="A real-time C++ convolution library"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=4.0.3
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://kokkinizita.linuxaudio.org/linuxaudio/downloads/zita-convolver-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=9aa11484fb30b4e6ef00c8a3281eebcfad9221e3937b1beb5fe21b748d89325f
NEOTERM_PKG_DEPENDS="libc++, fftw"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="
-C source
PREFIX=$NEOTERM_PREFIX
"
