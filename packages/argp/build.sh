NEOTERM_PKG_HOMEPAGE=https://github.com/argp-standalone/argp-standalone
NEOTERM_PKG_DESCRIPTION="Standalone version of arguments parsing functions from GLIBC"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.5.0
NEOTERM_PKG_SRCURL=https://github.com/argp-standalone/argp-standalone/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=c29eae929dfebd575c38174f2c8c315766092cec99a8f987569d0cad3c6d64f6
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"

neoterm_step_pre_configure() {
	autoreconf -fi
}

neoterm_step_post_make_install() {
	install -Dm600 $NEOTERM_PKG_SRCDIR/argp.h $NEOTERM_PREFIX/include
}
