NEOTERM_PKG_HOMEPAGE=https://sleuthkit.org/
NEOTERM_PKG_DESCRIPTION="The Sleuth Kit® (TSK) is a library for digital forensics tools. "
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="licenses/README.md, licenses/GNUv2-COPYING, licenses/GNUv3-COPYING, licenses/IBM-LICENSE, licenses/Apache-LICENSE-2.0.txt, licenses/cpl1.0.txt, licenses/bsd.txt, licenses/mit.txt"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="4.12.1"
NEOTERM_PKG_SRCURL=https://github.com/sleuthkit/sleuthkit/archive/sleuthkit-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=8b04fc40a38188c218a835ff4d4720d3d12b21ae9c88652a41932442f255e971
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
NEOTERM_PKG_DEPENDS="libc++, libsqlite, zlib"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--disable-java"

neoterm_step_pre_configure() {
	./bootstrap
}
