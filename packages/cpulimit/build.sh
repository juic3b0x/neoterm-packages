NEOTERM_PKG_HOMEPAGE=https://github.com/opsengine/cpulimit
NEOTERM_PKG_DESCRIPTION="CPU usage limiter"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.2
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/opsengine/cpulimit/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=64312f9ac569ddcadb615593cd002c94b76e93a0d4625d3ce1abb49e08e2c2da
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	CPPFLAGS+=" -D__USE_GNU"
	CFLAGS+=" $CPPFLAGS"
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin src/cpulimit
}
