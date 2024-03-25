NEOTERM_PKG_HOMEPAGE=https://github.com/nu774/fdkaac
NEOTERM_PKG_DESCRIPTION="command line encoder frontend for libfdk-aac"
NEOTERM_PKG_LICENSE="ZLIB"
NEOTERM_PKG_MAINTAINER="@DLC01"
NEOTERM_PKG_VERSION=1.0.5
NEOTERM_PKG_SRCURL=https://github.com/nu774/fdkaac/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=87b2d2cc913a1f90bd19315061ede81c1c3364e160802c70117a7ea81e80bd33
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_DEPENDS="libfdk-aac"

neoterm_step_pre_configure() {
	autoreconf -fi
}
