NEOTERM_PKG_HOMEPAGE=https://breakfastquay.com/rubberband/
NEOTERM_PKG_DESCRIPTION="An audio time-stretching and pitch-shifting library and utility program"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="3.3.0"
NEOTERM_PKG_SRCURL=https://breakfastquay.com/files/releases/rubberband-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=d9ef89e2b8ef9f85b13ac3c2faec30e20acf2c9f3a9c8c45ce637f2bc95e576c
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="fftw, libc++, libsamplerate, libsndfile"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dfft=fftw
-Dresampler=libsamplerate
"
