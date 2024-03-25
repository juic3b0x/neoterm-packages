NEOTERM_PKG_HOMEPAGE=http://qpdf.sourceforge.net
NEOTERM_PKG_DESCRIPTION="Content-Preserving PDF Transformation System"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="11.9.0"
NEOTERM_PKG_SRCURL=https://github.com/qpdf/qpdf/releases/download/v$NEOTERM_PKG_VERSION/qpdf-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=9f5d6335bb7292cc24a7194d281fc77be2bbf86873e8807b85aeccfbff66082f
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
NEOTERM_PKG_DEPENDS="libc++, libjpeg-turbo, zlib"
NEOTERM_PKG_BREAKS="qpdf-dev"
NEOTERM_PKG_REPLACES="qpdf-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="-DRANDOM_DEVICE=/dev/urandom"

neoterm_step_pre_configure() {
	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
