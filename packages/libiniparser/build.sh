NEOTERM_PKG_HOMEPAGE=https://github.com/ndevilla/iniparser
NEOTERM_PKG_DESCRIPTION="Offers parsing of ini files from the C level"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=4.1
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/ndevilla/iniparser/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=960daa800dd31d70ba1bacf3ea2d22e8ddfc2906534bf328319495966443f3ae
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make_install() {
	install -Dm600 -t $NEOTERM_PREFIX/lib libiniparser.so.1
	ln -sf libiniparser.so.1 $NEOTERM_PREFIX/lib/libiniparser.so
	install -Dm600 -t $NEOTERM_PREFIX/include/iniparser src/*.h
}
