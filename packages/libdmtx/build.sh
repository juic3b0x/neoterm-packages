NEOTERM_PKG_HOMEPAGE=https://github.com/dmtx/libdmtx
NEOTERM_PKG_DESCRIPTION="A software library that enables programs to read and write Data Matrix barcodes"
NEOTERM_PKG_LICENSE="BSD 2-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.7.7
NEOTERM_PKG_SRCURL=https://github.com/dmtx/libdmtx/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=7aa62adcefdd6e24bdabeb82b3ce41a8d35f4a0c95ab0c4438206aecafd6e1a1
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"

neoterm_step_pre_configure() {
	autoreconf -fi
}
