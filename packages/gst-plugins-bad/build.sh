NEOTERM_PKG_HOMEPAGE=https://gstreamer.freedesktop.org/
NEOTERM_PKG_DESCRIPTION="GStreamer Bad Plug-ins"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.24.0"
NEOTERM_PKG_SRCURL=https://gstreamer.freedesktop.org/src/gst-plugins-bad/gst-plugins-bad-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=d23c3a1a79c425d21078b4892c3302a1d4930d67b83dfa8e03df416fc3f97eba
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="game-music-emu, glib, gst-plugins-base, gstreamer, libaom, libass, libbz2, libcairo, libcurl, libopus, librsvg, libsndfile, libsrt, libx11, libxml2, littlecms, openal-soft, openjpeg, openssl, pango"
NEOTERM_PKG_BUILD_DEPENDS="glib-cross"
NEOTERM_PKG_BREAKS="gst-plugins-bad-dev"
NEOTERM_PKG_REPLACES="gst-plugins-bad-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dandroidmedia=disabled
-Dexamples=disabled
-Drtmp=disabled
-Dshm=disabled
-Dtests=disabled
-Dzbar=disabled
-Dwebp=disabled
-Dvulkan=disabled
-Dhls-crypto=openssl
"

neoterm_step_configure() {
	neoterm_setup_meson
	sed -i "2i glib-mkenums = '${NEOTERM_PREFIX}/opt/glib/cross/bin/glib-mkenums'" $NEOTERM_MESON_CROSSFILE

	local _meson_buildtype="minsize"
	local _meson_stripflag="--strip"
	if [ "$NEOTERM_DEBUG_BUILD" = "true" ]; then
		_meson_buildtype="debug"
		_meson_stripflag=
	fi

	CC=gcc CXX=g++ CFLAGS= CXXFLAGS= CPPFLAGS= LDFLAGS= $NEOTERM_MESON \
		$NEOTERM_PKG_SRCDIR \
		$NEOTERM_PKG_BUILDDIR \
		--cross-file $NEOTERM_MESON_CROSSFILE \
		--prefix $NEOTERM_PREFIX \
		--libdir lib \
		--buildtype ${_meson_buildtype} \
		${_meson_stripflag} \
		$NEOTERM_PKG_EXTRA_CONFIGURE_ARGS \
		|| (neoterm_step_configure_meson_failure_hook && false)
}
