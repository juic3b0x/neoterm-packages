NEOTERM_PKG_HOMEPAGE=https://jbig2dec.com/
NEOTERM_PKG_DESCRIPTION="Decoder implementation of the JBIG2 image compression format"
NEOTERM_PKG_LICENSE="AGPL-V3"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.20
NEOTERM_PKG_SRCURL=https://github.com/ArtifexSoftware/jbig2dec/archive/refs/tags/$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=a9705369a6633aba532693450ec802c562397e1b824662de809ede92f67aff21
NEOTERM_PKG_DEPENDS="libpng"
NEOTERM_PKG_BREAKS="jbig2dec-dev"
NEOTERM_PKG_REPLACES="jbig2dec-dev"

neoterm_step_pre_configure() {
	./autogen.sh
}
