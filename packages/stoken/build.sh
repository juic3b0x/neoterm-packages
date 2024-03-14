NEOTERM_PKG_HOMEPAGE=https://github.com/cernekee/stoken
NEOTERM_PKG_DESCRIPTION="Software Token for Linux/UNIX"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.93"
NEOTERM_PKG_SRCURL=https://github.com/cernekee/stoken/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=102e2d112b275efcdc20ef438670e4f24f08870b9072a81fda316efcc38aef9c
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_DEPENDS="libnettle, libxml2"

neoterm_step_pre_configure() {
	autoreconf -fi
}
