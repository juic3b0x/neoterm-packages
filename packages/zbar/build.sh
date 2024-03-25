NEOTERM_PKG_HOMEPAGE=https://github.com/mchehab/zbar
NEOTERM_PKG_DESCRIPTION="Software suite for reading bar codes from various sources"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.23.93"
NEOTERM_PKG_SRCURL=https://github.com/mchehab/zbar/archive/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=212dfab527894b8bcbcc7cd1d43d63f5604a07473d31a5f02889e372614ebe28
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="imagemagick, libiconv, libjpeg-turbo"
NEOTERM_PKG_BREAKS="zbar-dev"
NEOTERM_PKG_REPLACES="zbar-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--disable-pthread
--disable-video --without-xshm --without-xv
--without-x --without-gtk --without-qt
--without-python --mandir=$NEOTERM_PREFIX/share/man"

neoterm_step_pre_configure() {
	autoreconf -vfi
}
