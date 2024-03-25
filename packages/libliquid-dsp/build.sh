NEOTERM_PKG_HOMEPAGE=https://liquidsdr.org/
NEOTERM_PKG_DESCRIPTION="Software-defined radio digital signal processing library"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.6.0"
NEOTERM_PKG_SRCURL=https://github.com/jgaeddert/liquid-dsp/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=6ee6a5dfb48e047b118cf613c0b9f43e34356a5667a77a72a55371d2c8c53bf5
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="fftw"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	autoreconf -fi
}

neoterm_step_post_massage() {
	shopt -s nullglob
	local f
	for f in lib/libliquid.a.*; do
		neoterm_error_exit "File ${f} should not be contained herein."
	done
	shopt -u nullglob
}
