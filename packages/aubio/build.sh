NEOTERM_PKG_HOMEPAGE=https://aubio.org/
NEOTERM_PKG_DESCRIPTION="A library to label music and sounds"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.4.9
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://aubio.org/pub/aubio-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=d48282ae4dab83b3dc94c16cf011bcb63835c1c02b515490e1883049c3d1f3da
NEOTERM_PKG_DEPENDS="ffmpeg, libsamplerate, libsndfile"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	CPPFLAGS+=" -DFF_API_LAVF_AVCTX"
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
