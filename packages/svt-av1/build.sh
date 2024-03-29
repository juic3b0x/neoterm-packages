NEOTERM_PKG_HOMEPAGE=https://gitlab.com/AOMediaCodec/SVT-AV1
NEOTERM_PKG_DESCRIPTION="Scalable Video Technology for AV1 (SVT-AV1 Encoder and Decoder)"
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="LICENSE.md, PATENTS.md"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.8.0"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://gitlab.com/AOMediaCodec/SVT-AV1/-/archive/v${NEOTERM_PKG_VERSION}/SVT-AV1-v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=5be046efd5d5a5012e919249ee9e5791c9957f79f9d006d697882f02ad014f56
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_TESTING=OFF
-DCMAKE_OUTPUT_DIRECTORY=$NEOTERM_PKG_BUILDDIR
"

neoterm_step_pre_configure() {
	LDFLAGS+=" -lm"
	case "${NEOTERM_ARCH}" in
	x86_64) LDFLAGS+=" -llog" ;;
	esac
}
