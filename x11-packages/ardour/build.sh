NEOTERM_PKG_HOMEPAGE=https://ardour.org/
NEOTERM_PKG_DESCRIPTION="A professional digital workstation for working with audio and MIDI"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="8.4"
NEOTERM_PKG_SRCURL=git+https://github.com/Ardour/ardour
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_GIT_BRANCH=$NEOTERM_PKG_VERSION
NEOTERM_PKG_DEPENDS="aubio, fftw, fontconfig, glib, gtk2, gtkmm2, libandroid-execinfo, libarchive, libatkmm-1.6, libc++, libcairo, libcairomm-1.0, libcurl, libglibmm-2.4, liblo, liblrdf, libpangomm-1.4, libsamplerate, libsigc++-2.0, libsndfile, libusb, libwebsockets, libx11, libxml2, lilv, pango, pulseaudio, rubberband, suil, taglib, vamp-plugin-sdk"
NEOTERM_PKG_BUILD_DEPENDS="boost, boost-headers"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--with-backends=dummy,pulseaudio
--no-fpu-optimization
--freedesktop
--no-nls
--no-phone-home
--no-ytk
--noconfirm
--optimize
"

neoterm_step_pre_configure() {
	LDFLAGS+=" -landroid-execinfo"
}

neoterm_step_configure() {
	./waf configure \
		--prefix=$NEOTERM_PREFIX \
		LINKFLAGS="$LDFLAGS" \
		$NEOTERM_PKG_EXTRA_CONFIGURE_ARGS
}

neoterm_step_make() {
	./waf
}

neoterm_step_make_install() {
	./waf install
}
