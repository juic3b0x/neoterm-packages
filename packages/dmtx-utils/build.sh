NEOTERM_PKG_HOMEPAGE=https://github.com/dmtx/dmtx-utils
NEOTERM_PKG_DESCRIPTION="A command line interface for libdmtx"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.7.6
NEOTERM_PKG_SRCURL=https://github.com/dmtx/dmtx-utils/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=0d396ec14f32a8cf9e08369a4122a16aa2e5fa1675e02218f16f1ab777ea2a28
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_DEPENDS="imagemagick, libdmtx"

neoterm_step_pre_configure() {
	autoreconf -fi
}
