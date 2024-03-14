NEOTERM_PKG_HOMEPAGE=https://developer.android.com/
NEOTERM_PKG_DESCRIPTION="Android platform tools"
NEOTERM_PKG_LICENSE="Apache-2.0, BSD 2-Clause"
NEOTERM_PKG_LICENSE_FILE="LICENSE, vendor/core/fastboot/LICENSE"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=34.0.4
NEOTERM_PKG_REVISION=4
NEOTERM_PKG_SRCURL=https://github.com/nmeum/android-tools/releases/download/$NEOTERM_PKG_VERSION/android-tools-$NEOTERM_PKG_VERSION.tar.xz
NEOTERM_PKG_SHA256=7a22ff9cea81ff4f38f560687858e8f8fb733624412597e3cc1ab0262f8da3a1
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="abseil-cpp, brotli, libc++, liblz4, libprotobuf, libusb, pcre2, zlib, zstd"
NEOTERM_PKG_BUILD_DEPENDS="googletest"

neoterm_step_pre_configure() {
	neoterm_setup_protobuf
	neoterm_setup_golang

	LDFLAGS+=" $($NEOTERM_SCRIPTDIR/packages/libprotobuf/interface_link_libraries.sh)"
}
