NEOTERM_PKG_HOMEPAGE=https://github.com/traviscross/mtr
NEOTERM_PKG_DESCRIPTION="Network diagnostic tool"
NEOTERM_PKG_LICENSE="GPL-2.0, BSD 3-Clause"
NEOTERM_PKG_LICENSE_FILE="BSDCOPYING, COPYING"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.95
NEOTERM_PKG_SRCURL=https://github.com/traviscross/mtr/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=12490fb660ba5fb34df8c06a0f62b4f9cbd11a584fc3f6eceda0a99124e8596f
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_DEPENDS="ncurses"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--without-gtk"

neoterm_step_pre_configure() {
	cp ${NEOTERM_PKG_BUILDER_DIR}/hsearch/* ${NEOTERM_PKG_SRCDIR}/portability

	cd ${NEOTERM_PKG_SRCDIR}
	./bootstrap.sh
}
