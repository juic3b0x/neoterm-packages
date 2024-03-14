NEOTERM_PKG_HOMEPAGE=https://gitlab.com/hb9fxx/qrsspig
NEOTERM_PKG_DESCRIPTION="Headless QRSS grabber for Raspberry Pi's"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.8.0
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://gitlab.com/hb9fxx/qrsspig/-/archive/v${NEOTERM_PKG_VERSION}/qrsspig-v${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=9b3df7723944ef15f99d355ed071f41ace663833afe46703036ead89415372d1
NEOTERM_PKG_DEPENDS="boost, fftw, libc++, libcurl, libgd, libliquid-dsp, libssh, libyaml-cpp, pulseaudio"
NEOTERM_PKG_BUILD_DEPENDS="boost-headers"

neoterm_step_pre_configure() {
	LDFLAGS+=" -llog"
}

neoterm_step_post_make_install() {
	install -Dm600 -t $NEOTERM_PREFIX/etc/qrsspig \
		$NEOTERM_PKG_SRCDIR/etc/qrsspig.yaml
}
