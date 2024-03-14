NEOTERM_PKG_HOMEPAGE="https://freeimage.sourceforge.io"
NEOTERM_PKG_DESCRIPTION="The library project for developers who would like to support popular graphics image formats"
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="license-fi.txt, license-gplv2.txt, license-gplv3.txt, license-bsd-2-clause.txt"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.18.0
NEOTERM_PKG_REVISION=6
NEOTERM_PKG_SRCURL="https://downloads.sourceforge.net/project/freeimage/Source%20Distribution/${NEOTERM_PKG_VERSION}/FreeImage${NEOTERM_PKG_VERSION//./}.zip"
NEOTERM_PKG_SHA256=f41379682f9ada94ea7b34fe86bf9ee00935a3147be41b6569c9605a53e438fd
NEOTERM_PKG_DEPENDS="libc++"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	CXXFLAGS+=" -std=c++11"

	cp -f "${NEOTERM_PKG_BUILDER_DIR}/license-bsd-2-clause.txt" "${NEOTERM_PKG_SRCDIR}"

	if [ "${NEOTERM_ARCH}" = "aarch64" ] || [ "${NEOTERM_ARCH}" = "arm" ]; then
		CFLAGS+=" -DPNG_ARM_NEON_OPT=0"
	fi

}
