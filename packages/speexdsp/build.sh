NEOTERM_PKG_HOMEPAGE=https://speex.org/
NEOTERM_PKG_DESCRIPTION="Speex audio processing library"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.2.1
NEOTERM_PKG_SRCURL=https://github.com/xiph/speexdsp/archive/SpeexDSP-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=d17ca363654556a4ff1d02cc13d9eb1fc5a8642c90b40bd54ce266c3807b91a7
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_METHOD=repology
NEOTERM_PKG_BREAKS="speexdsp-dev"
NEOTERM_PKG_REPLACES="speexdsp-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--disable-neon"
NEOTERM_PKG_RM_AFTER_INSTALL="share/doc/speexdsp/manual.pdf"

neoterm_step_pre_configure() {
	./autogen.sh
}
