NEOTERM_PKG_HOMEPAGE=https://github.com/williamh/dotconf
NEOTERM_PKG_DESCRIPTION="dot.conf configuration file parser"
NEOTERM_PKG_VERSION=1.3
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_SHA256=7f1ecf40de1ad002a065a321582ed34f8c14242309c3547ad59710ae3c805653
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_SRCURL=https://github.com/williamh/dotconf/archive/v${NEOTERM_PKG_VERSION}.tar.gz

neoterm_step_pre_configure () {
	aclocal && libtoolize --force && autoreconf -fi
}
