NEOTERM_PKG_HOMEPAGE=http://www.whence.com/minimodem/
NEOTERM_PKG_DESCRIPTION="General-purpose software audio FSK modem"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.24-1
NEOTERM_PKG_SRCURL=https://github.com/kamalmostafa/minimodem/archive/refs/tags/minimodem-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=812611a880008c86086c105683063076176e87115490f8c266a0e25f9e27719f
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_METHOD=repology
NEOTERM_PKG_DEPENDS="fftw, libsndfile, pulseaudio"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--without-alsa
"

neoterm_step_pre_configure() {
	autoreconf -fi
}
